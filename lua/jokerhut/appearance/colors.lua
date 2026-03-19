function ColorMyPencils(color)
	color = color or "rose-pine"

	if color == "catpuccin" then
		require("catpuccin").setup({

			integrations = {
				cmp = true,
				neotree = true,
				harpoon = true,
				telescope = {
					enabled = true,
				},
				alpha = true,
				overseer = true,
				mason = true,
				markview = true,
			},
		})
	end

	if color == "tokyonight-night" then
		vim.g.tokyonight_style = "night"
		require("tokyonight").setup({
			styles = { comments = { italic = false } },
		})
	end

	vim.cmd.colorscheme(color)
end

ColorMyPencils()

local M = {}

function M.SelectColorscheme()
	local themes = {
		"tokyonight-night",
		"vague",
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
	}

	vim.ui.select(themes, { prompt = "Select Colorscheme:" }, function(choice)
		if choice then
			ColorMyPencils(choice)
		end
	end)
end

return M
