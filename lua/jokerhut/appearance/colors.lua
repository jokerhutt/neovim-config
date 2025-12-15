function ColorMyPencils(color)
	color = color or "catppuccin-macchiato"

	if color == "tokyonight-night" then
		vim.g.tokyonight_style = "night"
		require("tokyonight").setup({
			styles = { comments = { italic = false } },
		})
	end

	vim.cmd.colorscheme(color)
end

ColorMyPencils()

vim.keymap.set("n", "<leader>cc", function()
	vim.ui.select({
		"tokyonight-night",
		"dracula",
		"dracula-soft",
		"material-palenight",
		"vscode",
		"darkplus",
		"catppuccin-macchiato",
		"catppuccin-mocha",
		"catppuccin-frappe",
		"rose-pine",
		"github_dark_dimmed",
		"nordic",
		"xcode",
	}, { prompt = "Select Colorscheme:" }, function(choice)
		if choice then
			ColorMyPencils(choice)
		end
	end)
end, { desc = "Change colorscheme" })
