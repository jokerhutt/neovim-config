local presets = require("markview.presets")

require("markview").setup({
	markdown = { headings = presets.headings.glow },
})

vim.api.nvim_create_autocmd("BufWritePost", {
	pattern = "*.md",
	callback = function()
		vim.cmd("Markview splitRedraw")
	end,
})

vim.api.nvim_create_autocmd({ "TextChanged", "TextChangedI" }, {
	pattern = "*.md",
	callback = function()
		vim.cmd("Markview splitRedraw")
	end,
})
