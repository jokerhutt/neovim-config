-- ~/.config/nvim/ftplugin/java.lua
-- jdtls as the sole formatter for Java, using an Eclipse XML profile.

local ok_jdtls, jdtls = pcall(require, "jdtls")
if not ok_jdtls then
	vim.notify("nvim-jdtls not found", vim.log.levels.ERROR)
	return
end

local home = vim.loop.os_homedir()

-- Adjust these to your paths
local JDTLS_ROOT = home .. "/.local/share/jdtls" -- folder containing 'plugins' and 'config_*'
local LOMBOK_JAR = home .. "/.local/share/lombok/lombok.jar" -- download lombok.jar
local JAVA_DEBUG = vim.fn.stdpath("data") .. "/java-debug" -- optional debug plugin build output
local ECLIPSE_STYLE = home .. "/.config/nvim/eclipse-java-google-style.xml" -- your formatter XML
local JAVA_HOME = "/Library/Java/JavaVirtualMachines/temurin-21.jdk/Contents/Home" -- macOS JDK 21

-- Resolve launcher + OS config
local LAUNCHER_JAR = vim.fn.glob(JDTLS_ROOT .. "/plugins/org.eclipse.equinox.launcher_*.jar")
local CONFIG_DIR = JDTLS_ROOT .. "/config_mac" -- or config_linux / config_win

-- Project root
local root_dir = require("jdtls.setup").find_root({ ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" })
if not root_dir or root_dir == "" then
	return
end

-- Workspace per project
local project_name = vim.fn.fnamemodify(root_dir, ":p:h:t")
local WORKSPACE = vim.fn.stdpath("cache") .. "/jdtls/" .. project_name

-- Optional debug bundle
local debug_bundle =
	vim.fn.glob(JAVA_DEBUG .. "/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar", 1)
local bundles = {}
if debug_bundle and debug_bundle ~= "" then
	bundles = { debug_bundle }
end

-- LSP caps
local caps = {}
pcall(function()
	caps = require("cmp_nvim_lsp").default_capabilities()
end)

-- on_attach
local function lsp_attach(client, bufnr)
	local function nmap(lhs, rhs, desc)
		vim.keymap.set("n", lhs, rhs, { buffer = bufnr, silent = true, desc = desc })
	end

	nmap("gd", vim.lsp.buf.definition, "Go to definition")
	nmap("gr", vim.lsp.buf.references, "Find references")
	nmap("K", vim.lsp.buf.hover, "Hover")
	nmap("<leader>rn", vim.lsp.buf.rename, "Rename")
	nmap("<leader>ca", vim.lsp.buf.code_action, "Code Action")

	pcall(function()
		nmap("<leader>oi", jdtls.organize_imports, "Organize imports")
		nmap("<leader>ev", jdtls.extract_variable, "Extract variable")
		nmap("<leader>em", jdtls.extract_method, "Extract method")
	end)

	pcall(function()
		require("jdtls.dap").setup_dap({ hotcodereplace = "auto" })
		require("jdtls.dap").setup_dap_main_class_configs()
	end)
end

-- Command
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

-- Start/attach with formatter profile
jdtls.start_or_attach({
	cmd = cmd,
	cmd_env = { JAVA_HOME = JAVA_HOME, PATH = JAVA_HOME .. "/bin:" .. os.getenv("PATH") },
	root_dir = root_dir,
	capabilities = caps,
	on_attach = lsp_attach,
	init_options = { bundles = bundles },
	settings = {
		java = {
			configuration = { updateBuildConfiguration = "interactive" },
			contentProvider = { preferred = "fernflower" },
			signatureHelp = { enabled = true },
			format = {
				enabled = true,
				settings = {
					url = "file://" .. ECLIPSE_STYLE,
					profile = "GoogleStyle", -- or whatever the XML defines
				},
			},
			-- Optional: organize imports on save
			saveActions = { organizeImports = true },
			-- Optional: how annotations and wrapping behave depend on the XML
		},
	},
})

-- Buffer-local fallback opts (won’t fight jdtls)
vim.bo.expandtab = true
vim.bo.shiftwidth = 4
vim.bo.tabstop = 4
vim.bo.softtabstop = 4
vim.bo.cindent = false
