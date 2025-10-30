pcall(function()
	require("mason").setup()
end)

pcall(function()
	require("mason-null-ls").setup({
		ensure_installed = {
			"prettier",
			"stylua",
			"black",
			"shellcheck",
			"shfmt",
			"clang-format",
			"cppcheck",
		},
		automatic_installation = true,
	})
end)

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
		-- Python
		null_ls.builtins.formatting.black,
		-- Shell
		null_ls.builtins.formatting.shfmt.with({ extra_args = { "-i", "4", "-ci" } }),
		require("none-ls-shellcheck.diagnostics"),
		require("none-ls-shellcheck.code_actions"),
		-- C
		null_ls.builtins.formatting.clang_format.with({
			filetypes = { "c" },
			extra_args = {
				"--style={BasedOnStyle: LLVM, IndentWidth: 4, TabWidth: 4, UseTab: Never, ContinuationIndentWidth: 4, AlignAfterOpenBracket: DontAlign, AlignOperands: false, ColumnLimit: 0}",
			},
		}),
		null_ls.builtins.diagnostics.cppcheck.with({ filetypes = { "c" } }),
	},
})

local grp = vim.api.nvim_create_augroup("FormatOnSaveAll", { clear = true })
vim.api.nvim_create_autocmd("BufWritePre", {
	group = grp,
	callback = function(args)
		vim.lsp.buf.format({
			bufnr = args.buf,
			async = false,
			filter = function(c)
				return c.name == "null-ls" or c.name == "none-ls"
			end,
		})
	end,
})
