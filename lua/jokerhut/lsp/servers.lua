local caps = require("cmp_nvim_lsp").default_capabilities()

local function setup(server, opts)
	opts = opts or {}
	opts.capabilities = caps
	vim.lsp.config(server, opts)
end

setup("lua_ls", {
	settings = {
		Lua = {
			diagnostics = { globals = { "vim" } },
			workspace = {
				library = vim.api.nvim_get_runtime_file("", true),
				checkThirdParty = false,
			},
			telemetry = { enable = false },
		},
	},
})

setup("ts_ls")
setup("basedpyright")
setup("bashls")
setup("clangd")
