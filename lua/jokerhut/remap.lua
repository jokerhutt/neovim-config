vim.g.mapleader = " "
local opts = { noremap = true, silent = true }

-- TOGGLE TERMINAL --
vim.keymap.set("n", "<leader>t", ":ToggleTerm<CR>")

-- ERROR DIAGNOSTIC ON CURSOR --
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic under cursor" })

-- MARKDOWN PREVIEW TOGGLE --
vim.keymap.set("n", "<leader>md", "<cmd>Markview splitToggle<CR>", { desc = "Toggle markdown preview split" })

-- reopen alpha dashboard
vim.keymap.set("n", "<leader>db", function()
	if vim.bo.filetype == "alpha" then
		vim.cmd("AlphaRedraw")
	else
		vim.cmd("Alpha")
	end
end, { desc = "Open Alpha dashboard" })

vim.keymap.set("n", "<leader>gg", "<cmd>LazyGit<CR>", { desc = "Open LazyGit" })

-- SYSTEM CLIPBOARD --
vim.keymap.set("n", "<leader>p", '"+p')
vim.keymap.set("v", "<leader>p", '"+p')
vim.keymap.set("n", "<leader>y", '"+y')
vim.keymap.set("v", "<leader>y", '"+y')
vim.keymap.set("n", "<leader>Y", '"+Y')

-- keep half-page jumps centered
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Half-page down, center" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Half-page up, center" })

-- keep search results centered
vim.keymap.set("n", "n", "nzzzv", { desc = "Next search result, center" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Prev search result, center" })

-- NAVIGATION --
vim.keymap.set("n", "<leader>h", "<C-w>h", { desc = "Go to left pane" })
vim.keymap.set("n", "<leader>j", "<C-w>j", { desc = "Go to below pane" })
vim.keymap.set("n", "<leader>k", "<C-w>k", { desc = "Go to above pane" })
vim.keymap.set("n", "<leader>l", "<C-w>l", { desc = "Go to right pane" })

-- COMPILER --
vim.keymap.set(
	"n",
	"<leader>c",
	"<cmd>CompilerOpen<cr>",
	{ noremap = true, silent = true, desc = "Open compiler menu" }
)
vim.keymap.set("n", "<leader>r", "<cmd>CompilerRedo<cr>", { noremap = true, silent = true, desc = "Redo last compile" })
vim.keymap.set(
	"n",
	"<leader>cr",
	"<cmd>CompilerStop<cr>" .. "<cmd>CompilerRedo<cr>" .. "<cmd>CompilerToggleResults<cr>",
	{ noremap = true, silent = true, desc = "Compile, run, and show results" }
)
vim.keymap.set(
	"n",
	"<leader>co",
	"<cmd>CompilerToggleResults<cr>",
	{ noremap = true, silent = true, desc = "Toggle compiler results" }
)

-- UNDO TREE --
vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)

-- CLOSE OTHER BUFFERS --
vim.keymap.set("n", "<leader>o", vim.cmd.only)

-- FUGITIVE --
vim.keymap.set("n", "<leader>gs", vim.cmd.Git)

-- LEETCODE --
vim.keymap.set("n", "<leader>lc", "<cmd>Leet<CR>", { silent = true })
vim.keymap.set("n", "<leader>lcn", "<cmd>Leet list status=NOT_STARTED<CR>", { noremap = true, silent = true })
