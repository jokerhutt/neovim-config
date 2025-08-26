require("mason").setup()
require("mason-lspconfig").setup({
	ensure_installed = {
		"lua_ls", -- Lua
		"ts_ls", -- JavaScript / TypeScript
		"jdtls", -- Java
		"pyright", -- Python
		"bashls", -- Bash
		"clangd",
	},
})

local lspconfig = require("lspconfig")
lspconfig.clangd.setup({})
