function ColorMyPencils(color)
	color = color or "rose-pine"
	vim.cmd.colorscheme(color)

	vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

ColorMyPencils()

-- Override theme for JS/TS to github dark dimmed
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
	callback = function()
		-- load github-dark-dimmed
		require("github-theme").setup({})
		vim.cmd.colorscheme("github_dark_dimmed")

		-- params (children, color, etc.)
		vim.api.nvim_set_hl(0, "@variable.parameter", { fg = "#f59d51" })
		vim.api.nvim_set_hl(0, "TSParameter", { fg = "#f59d51" }) -- legacy capture, just in case

		-- braces / brackets
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
