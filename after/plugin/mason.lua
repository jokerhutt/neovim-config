require("mason").setup()

local lspconfig = require("lspconfig")
local caps = require("cmp_nvim_lsp").default_capabilities()

require("mason-lspconfig").setup({
	ensure_installed = { "lua_ls", "ts_ls", "pyright", "bashls", "clangd", "jdtls" },
	handlers = {
		function(server)
			lspconfig[server].setup({ capabilities = caps })
		end,
		["jdtls"] = function() end, -- skip: nvim-jdtls/ftplugin handles Java
	},
})
