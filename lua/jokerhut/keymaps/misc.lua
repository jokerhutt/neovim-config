-- MARKDOWN PREVIEW TOGGLE --
vim.keymap.set("n", "<leader>md", "<cmd>Markview splitToggle<CR>", { desc = "Toggle markdown preview split" })

-- UNDO TREE --
vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)

-- LEETCODE --
vim.keymap.set("n", "<leader>lc", "<cmd>Leet<CR>", { silent = true })
vim.keymap.set("n", "<leader>lcn", "<cmd>Leet list status=NOT_STARTED<CR>", { noremap = true, silent = true })
