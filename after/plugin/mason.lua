require("mason").setup()
require("mason-lspconfig").setup({
	ensure_installed = {
		"lua_ls", -- Lua
		"ts_ls", -- JavaScript / TypeScript (was tsserver)
		"jdtls", -- Java
		"pyright", -- Python
	},
})
