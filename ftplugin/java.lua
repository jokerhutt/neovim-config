-- ~/.config/nvim/ftplugin/java.lua

local jdtls = require("jdtls")
local home = vim.loop.os_homedir()

-- Paths you set up
local JDTLS_ROOT = home .. "/.local/share/jdtls" -- where you extracted jdtls
local LOMBOK_JAR = home .. "/.local/share/lombok/lombok.jar" -- downloaded lombok.jar
local JAVA_DEBUG = vim.fn.stdpath("data") .. "/java-debug" -- ~/.local/share/nvim/java-debug

-- Resolve launcher + OS config (macOS)
local LAUNCHER_JAR = vim.fn.glob(JDTLS_ROOT .. "/plugins/org.eclipse.equinox.launcher_*.jar")
local CONFIG_DIR = JDTLS_ROOT .. "/config_mac"

-- Find project root first
local root_dir = require("jdtls.setup").find_root({ ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" })
if not root_dir or root_dir == "" then
	return
end

-- Stable workspace per project (cache dir)
local project_name = vim.fn.fnamemodify(root_dir, ":p:h:t")
local WORKSPACE = vim.fn.stdpath("cache") .. "/jdtls/" .. project_name

-- Basic sanity checks
if LAUNCHER_JAR == nil or LAUNCHER_JAR == "" then
	vim.notify("JDTLS launcher not found in " .. JDTLS_ROOT, vim.log.levels.ERROR)
	return
end
if vim.fn.filereadable(LOMBOK_JAR) == 0 then
	vim.notify("Lombok jar not found at " .. LOMBOK_JAR, vim.log.levels.WARN)
end

-- Optional: java-debug bundle
local debug_bundle =
	vim.fn.glob(JAVA_DEBUG .. "/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar", 1)
local bundles = {}
if debug_bundle ~= nil and debug_bundle ~= "" then
	bundles = { debug_bundle }
end

-- Capabilities & on_attach
local caps = require("cmp_nvim_lsp").default_capabilities()
local function lsp_attach(_, bufnr)
	pcall(function()
		require("jdtls.dap").setup_dap({ hotcodereplace = "auto" })
	end)
	pcall(function()
		require("jdtls.dap").setup_dap_main_class_configs()
	end)

	local function map(lhs, rhs, desc)
		if type(rhs) == "function" then
			vim.keymap.set("n", lhs, rhs, { buffer = bufnr, silent = true, desc = desc })
		end
	end

	-- core
	map("gd", vim.lsp.buf.definition, "Go to definition")
	map("gr", vim.lsp.buf.references, "Find references")
	map("K", vim.lsp.buf.hover, "Hover docs")

	-- lspsaga (guard each call)
	do
		local ok_saga, saga = pcall(require, "lspsaga.codeaction")
		if ok_saga then
			-- generic code actions
			map("<leader>ca", function()
				saga.code_action()
			end, "Code Action (lspsaga)")

			-- explicit “Implement interface / Generate …” menu
			map("<leader>ei", function()
				saga.code_action()
			end, "Implement/Generate menu")

			if type(saga.range_code_action) == "function" then
				vim.keymap.set({ "n", "v" }, "<leader>cA", function()
					saga.range_code_action()
				end, { buffer = bufnr, silent = true, desc = "Range Code Action (lspsaga)" })
			end
		else
			map("<leader>ca", vim.lsp.buf.code_action, "Code Action")
			map("<leader>ei", vim.lsp.buf.code_action, "Implement/Generate menu")
		end
	end

	-- jdtls helpers
	local ok_j, j = pcall(require, "jdtls")
	if ok_j then
		map("<leader>oi", j.organize_imports, "Organize imports")
		map("<leader>ev", j.extract_variable, "Extract variable")
		map("<leader>em", j.extract_method, "Extract method")

		if type(j.test_nearest_method) == "function" then
			map("<leader>tn", j.test_nearest_method, "Test: nearest method")
		end
		if type(j.test_nearest_class) == "function" then
			map("<leader>tC", j.test_nearest_class, "Test: class")
		end
	end
end

-- Force JDK 21 (matches your ~/.zshrc)
local JAVA_HOME = "/Library/Java/JavaVirtualMachines/temurin-21.jdk/Contents/Home"

local cmd = {
	"java",
	"-Declipse.application=org.eclipse.jdt.ls.core.id1",
	"-Dosgi.bundles.defaultStartLevel=4",
	"-Declipse.product=org.eclipse.jdt.ls.core.product",
	"-Dlog.protocol=true",
	"-Dlog.level=ALL",
	"-Xms1g",
	"--add-modules=ALL-SYSTEM",
	"--add-opens",
	"java.base/java.util=ALL-UNNAMED",
	"--add-opens",
	"java.base/java.lang=ALL-UNNAMED",
	"-javaagent:" .. LOMBOK_JAR,
	"-jar",
	LAUNCHER_JAR,
	"-configuration",
	CONFIG_DIR,
	"-data",
	WORKSPACE,
}

jdtls.start_or_attach({
	cmd = cmd,
	cmd_env = { JAVA_HOME = JAVA_HOME, PATH = JAVA_HOME .. "/bin:" .. os.getenv("PATH") },
	root_dir = root_dir,
	capabilities = caps,
	on_attach = lsp_attach,
	init_options = { bundles = bundles },
	settings = {
		java = {
			signatureHelp = { enabled = true },
			configuration = { updateBuildConfiguration = "interactive" },
			contentProvider = { preferred = "fernflower" },
		},
	},
})

-- (Optional) simple DAP config for single-file runs
local ok_dap, dap = pcall(require, "dap")
if ok_dap then
	dap.configurations.java = {
		{
			type = "java",
			request = "launch",
			name = "Debug current file",
			program = "${file}",
		},
	}
end
