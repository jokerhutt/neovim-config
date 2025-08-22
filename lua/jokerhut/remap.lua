vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.keymap.set("n", "<leader>t", ":ToggleTerm<CR>")

vim.keymap.set("n", "<leader>y", '"+y')
vim.keymap.set("v", "<leader>y", '"+y')
vim.keymap.set("n", "<leader>Y", '"+Y')

vim.keymap.set("n", "<leader>p", '"+p')
vim.keymap.set("v", "<leader>p", '"+p')

vim.keymap.set(
	"n",
	"<leader>cr",
	"<cmd>CompilerStop<cr>" .. "<cmd>CompilerRedo<cr>" .. "<cmd>CompilerToggleResults<cr>",
	{ noremap = true, silent = true, desc = "Compile, run, and show results" }
)
