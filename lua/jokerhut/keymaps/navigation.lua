-- keep half-page jumps centered
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Half-page down, center" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Half-page up, center" })

-- keep search results centered
vim.keymap.set("n", "n", "nzzzv", { desc = "Next search result, center" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Prev search result, center" })
