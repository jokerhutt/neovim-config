-- after/plugin/markdown.lua
local presets = require("markview.presets")

require("markview").setup({
	markdown = { headings = presets.headings.glow },
})

-- auto refresh on write
vim.api.nvim_create_autocmd("BufWritePost", {
	pattern = "*.md",
	callback = function()
		vim.cmd("Markview splitRedraw")
	end,
})

-- optional: live refresh on every change
vim.api.nvim_create_autocmd({ "TextChanged", "TextChangedI" }, {
	pattern = "*.md",
	callback = function()
		vim.cmd("Markview splitRedraw")
	end,
})
