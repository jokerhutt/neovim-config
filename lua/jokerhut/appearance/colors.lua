function ColorMyPencils(color)
	color = color or "dracula"
	vim.cmd.colorscheme(color)
end

ColorMyPencils()

vim.keymap.set("n", "<leader>cc", function()
	vim.ui.select(
		{ "dracula", "catppuccin-macchiato", "rose-pine", "github_dark_dimmed", "nordic", "xcode" }, -- list any you installed
		{ prompt = "Select Colorscheme:" },
		function(choice)
			if choice then
				ColorMyPencils(choice)
			end
		end
	)
end, { desc = "Change colorscheme" })
