-- ERROR DIAGNOSTIC ON CURSOR --
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic under cursor" })
vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename symbol" })

vim.keymap.set("n", "<leader>ee", function()
	require("telescope.builtin").diagnostics({
		bufnr = 0,
	})
end, { desc = "File diagnostics" })

vim.keymap.set("n", "<leader>er", function()
	require("telescope.builtin").diagnostics({
		bufnr = 0,
		severity_limit = vim.diagnostic.severity.ERROR,
	})
end, { desc = "Errors only" })

vim.keymap.set("n", "<leader>ew", function()
	require("telescope.builtin").diagnostics({
		bufnr = 0,
		severity_limit = vim.diagnostic.severity.WARN,
	})
end, { desc = "Warnings only" })
