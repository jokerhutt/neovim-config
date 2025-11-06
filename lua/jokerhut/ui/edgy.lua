vim.opt.laststatus = 3
vim.opt.splitkeep = "screen"
vim.opt.splitbelow = true
vim.opt.splitright = true

require("edgy").setup({
	left = {
		{ ft = "NvimTree", pinned = true },
	},
	right = {
		{ ft = "OverseerList", title = "Tasks" },
		{ ft = "OverseerOutput", title = "Task Output" },
	},
	bottom = {
		{ ft = "toggleterm", title = "Terminal" },
		{ ft = "qf", title = "Problems" },
	},
	options = {
		left = { size = 35 },
		bottom = { size = 14 },
		right = { size = 50 },
	},
	animate = { enabled = false },
})
