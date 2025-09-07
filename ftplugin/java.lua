-- ftplugin/java.lua

local jdtls = require("jdtls")
local home = os.getenv("HOME")

-- Paths we agreed on
local JDTLS_ROOT = home .. "/.local/share/jdtls" -- you untarred jdtls here
local LOMBOK_JAR = home .. "/.local/share/lombok/lombok.jar" -- you downloaded lombok here
local JAVA_DEBUG = vim.fn.stdpath("data") .. "/java-debug" -- ~/.local/share/nvim/java-debug

-- Resolve launcher + config dir (macOS)
local LAUNCHER_JAR = vim.fn.glob(JDTLS_ROOT .. "/plugins/org.eclipse.equinox.launcher_*.jar")
local CONFIG_DIR = JDTLS_ROOT .. "/config_mac"

-- Per-project workspace
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local WORKSPACE = home .. "/.cache/jdtls/" .. project_name

-- Root detection
local root_dir = require("jdtls.setup").find_root({ ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" })
if not root_dir or root_dir == "" then
	return
end

-- Optional: java-debug bundle
local debug_bundle =
	vim.fn.glob(JAVA_DEBUG .. "/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar", 1)
local bundles = {}
if debug_bundle and debug_bundle ~= "" then
	bundles = { debug_bundle }
end

-- Capabilities and on_attach
local caps = require("cmp_nvim_lsp").default_capabilities()

local function lsp_attach(_, bufnr)
	pcall(function()
		require("jdtls.dap").setup_dap({ hotcodereplace = "auto" })
	end)
	pcall(function()
		require("jdtls.dap").setup_dap_main_class_configs()
	end)

	local map = function(lhs, rhs)
		vim.keymap.set("n", lhs, rhs, { buffer = bufnr, silent = true })
	end
	map("gd", vim.lsp.buf.definition)
	map("gr", vim.lsp.buf.references)
	map("K", vim.lsp.buf.hover)
end

-- Use JDK 21 we set in ~/.zshrc; enforce if needed:
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

-- Extra DAP configuration for running single Java files
local dap = require("dap")

dap.configurations.java = {
	{
		type = "java",
		request = "launch",
		name = "Debug current file",
		program = "${file}",
	},
}
