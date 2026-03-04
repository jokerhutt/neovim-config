require("mason").setup()

local lspconfig = require("lspconfig")
local caps = require("cmp_nvim_lsp").default_capabilities()

require("mason-lspconfig").setup({
	ensure_installed = { "lua_ls", "tailwindcss", "ts_ls", "yamlls", "basedpyright", "bashls", "clangd", "jdtls" },
	handlers = {
		function(server)
			lspconfig[server].setup({ capabilities = caps })
		end,
		["jdtls"] = function() end,

		["yamlls"] = function()
			lspconfig.yamlls.setup({
				capabilities = caps,
				root_dir = function()
					return vim.fn.getcwd()
				end,
				settings = {
					yaml = {
						validate = true,
						hover = true,
						completion = true,
					},
				},
			})
		end,

		["tailwindcss"] = function()
			lspconfig.tailwindcss.setup({
				capabilities = caps,
				filetypes = {
					"html",
					"css",
					"javascript",
					"javascriptreact",
					"typescript",
					"typescriptreact",
				},
			})
		end,
	},
})
