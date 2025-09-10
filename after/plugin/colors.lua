function ColorMyPencils(color)
	color = color or "dracula"
	vim.cmd.colorscheme(color)

	vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
	vim.api.nvim_set_hl(0, "@attribute", { fg = "#5f87ff" })
	vim.api.nvim_set_hl(0, "Annotation", { fg = "#5f87ff" })
end

ColorMyPencils()

vim.api.nvim_create_autocmd("ColorScheme", {
	group = vim.api.nvim_create_augroup("AlwaysMyPencils", { clear = true }),
	callback = function()
		vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
		vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
		vim.api.nvim_set_hl(0, "@attribute", { fg = "#5f87ff" })
		vim.api.nvim_set_hl(0, "Annotation", { fg = "#5f87ff" })
	end,
})
