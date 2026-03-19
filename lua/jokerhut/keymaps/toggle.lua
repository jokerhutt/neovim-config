local transparency = require("jokerhut.appearance.transparency")

-- TOGGLES --

vim.keymap.set("n", "<leader>oe", ":Neotree filesystem toggle left<CR>", { desc = "Toggle Neo-tree (filesystem)" })

vim.keymap.set("n", "<leader>ob", transparency.toggle_transparency, { desc = "Toggle background transparency" })

vim.keymap.set("n", "<leader>ot", ":ToggleTerm<CR>", { desc = "Toggle terminal" })
vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], { silent = true })

-- Diffview: open/close repo diff
vim.keymap.set("n", "<leader>od", "<cmd>DiffviewToggle<CR>", { desc = "Toggle Diffview (repo diff)" })

-- Diffview: file history (current file)
vim.keymap.set("n", "<leader>oh", "<cmd>DiffviewFileHistory %<CR>", { desc = "File history (current file)" })
