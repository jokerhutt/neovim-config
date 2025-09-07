local lspconfig = require("lspconfig")

-- Lua
lspconfig.lua_ls.setup({
	settings = {
		Lua = {
			diagnostics = { globals = { "vim" } },
			workspace = { checkThirdParty = false },
		},
	},
})

-- JavaScript / TypeScript
lspconfig.ts_ls.setup({})

-- Python
lspconfig.pyright.setup({})

-- C /C++
lspconfig.clangd.setup({})
