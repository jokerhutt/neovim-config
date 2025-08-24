-- Mason setup
local ok_mason, mason = pcall(require, "mason")
if ok_mason then
	mason.setup()
end

local ok_bridge, mason_null_ls = pcall(require, "mason-null-ls")
if ok_bridge then
	mason_null_ls.setup({
		ensure_installed = {
			"prettier",
			"stylua",
			"google-java-format",
			"autopep8",
			"shellcheck",
			"shfmt",
			"clang-format",
			"cppcheck",
		},
		automatic_installation = true,
	})
end

vim.env.PATH = vim.fn.stdpath("data") .. "/mason/bin:" .. vim.env.PATH

local null_ls = require("null-ls")

null_ls.setup({
	debug = true,
	root_dir = require("null-ls.utils").root_pattern(".git", "."),
	sources = {
		-- Web
		null_ls.builtins.formatting.prettier,
		-- Lua
		null_ls.builtins.formatting.stylua,
		-- Java
		null_ls.builtins.formatting.google_java_format,
		-- Python
		null_ls.builtins.formatting.autopep8,
		-- Shell
		null_ls.builtins.diagnostics.shellcheck,
		null_ls.builtins.formatting.shfmt.with({ extra_args = { "-i", "4", "-ci" } }),
		-- C only
		null_ls.builtins.formatting.clang_format.with({
			filetypes = { "c" },
			extra_args = {
				"--style={BasedOnStyle: LLVM, IndentWidth: 4, TabWidth: 4, UseTab: Never, ContinuationIndentWidth: 4, AlignAfterOpenBracket: DontAlign, AlignOperands: false, ColumnLimit: 0}",
			},
		}),
		null_ls.builtins.diagnostics.cppcheck.with({ filetypes = { "c" } }),
	},

	on_attach = function(client, bufnr)
		if client.supports_method("textDocument/formatting") then
			local function prefer_nulls(c)
				return c.name == "null-ls" or c.name == "none-ls"
			end

			vim.keymap.set("n", "<leader>f", function()
				vim.lsp.buf.format({ bufnr = bufnr, filter = prefer_nulls })
			end, { buffer = bufnr, desc = "Format buffer" })

			local grp = vim.api.nvim_create_augroup("FormatOnSave", { clear = true })
			vim.api.nvim_clear_autocmds({ group = grp, buffer = bufnr })
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = grp,
				buffer = bufnr,
				callback = function()
					vim.lsp.buf.format({ bufnr = bufnr, filter = prefer_nulls })
				end,
			})
		end
	end,
})

require("mason-lspconfig").setup({
	ensure_installed = { "lua_ls", "ts_ls", "jdtls", "pyright", "bashls", "clangd" },
})

local lspconfig = require("lspconfig")
lspconfig.clangd.setup({
	on_attach = function(client, _)
		client.server_capabilities.documentFormattingProvider = false
	end,
})

local cf_style =
	"{BasedOnStyle: LLVM, IndentWidth: 4, TabWidth: 4, UseTab: Never, ContinuationIndentWidth: 4, AlignAfterOpenBracket: DontAlign, AlignOperands: false, ColumnLimit: 0}"
vim.api.nvim_create_autocmd("BufWritePost", {
	pattern = { "*.c", "*.h" },
	callback = function(args)
		local file = args.match
		vim.system({ "clang-format", "--style=" .. cf_style, "-i", file }, { text = true }, function()
			vim.schedule(function()
				vim.cmd("edit")
			end)
		end)
	end,
})
