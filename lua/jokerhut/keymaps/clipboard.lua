-- SYSTEM CLIPBOARD --
vim.keymap.set("n", "<leader>p", '"+p', { desc = "Clipboard paste" })
vim.keymap.set("v", "<leader>p", '"+p', { desc = "Clipboard paste" })

vim.keymap.set("n", "<leader>y", '"+y', { desc = "Clipboard yank" })
vim.keymap.set("v", "<leader>y", '"+y', { desc = "Clipboard yank" })

vim.keymap.set("n", "<leader>Y", '"+Y', { desc = "Clipboard yank line" })
