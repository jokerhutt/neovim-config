-- TOGGLES --
vim.keymap.set(
	"n",
	"<leader>oc",
	"<cmd>CompilerToggleResults<cr>",
	{ noremap = true, silent = true, desc = "Toggle compiler results" }
)

vim.keymap.set("n", "<leader>ot", ":ToggleTerm<CR>")
