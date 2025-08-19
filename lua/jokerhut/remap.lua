vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.keymap.set("n", "<leader>t", ":ToggleTerm<CR>")
vim.keymap.set("n", "<leader>f", function()
  vim.cmd("ToggleTerm")
end, { desc = "Toggle terminal focus" })
