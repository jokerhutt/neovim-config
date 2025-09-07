function ColorMyPencils(color)
	color = color or "catppuccin"
	vim.cmd.colorscheme(color)

	vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

ColorMyPencils()

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
	callback = function()

		require("github-theme").setup({})
		vim.cmd.colorscheme("github_dark_dimmed")

		vim.api.nvim_set_hl(0, "@variable.parameter", { fg = "#f59d51" })
		vim.api.nvim_set_hl(0, "TSParameter", { fg = "#f59d51" }) 

		vim.api.nvim_set_hl(0, "@punctuation.bracket", { fg = "#d9a93f" })
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = "java",
	callback = function()
		require("dracula").setup({ transparent_bg = true })
		vim.cmd.colorscheme("dracula")
	end,
})
