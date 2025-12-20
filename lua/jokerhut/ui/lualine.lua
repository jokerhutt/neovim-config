require("lualine").setup({
	options = {
		theme = "tokyonight-night",
		globalstatus = true,
		component_separators = { left = "", right = "" },
		section_separators = { left = "", right = "" },
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = { "branch", "diff", "diagnostics" },
		lualine_c = { "filename" },
		lualine_x = { "encoding", "fileformat", "filetype" },
		lualine_y = { "progress" },
		lualine_z = { "location" },
	},
	winbar = {
		lualine_c = { { "filename", path = 1 } },
	},
	inactive_winbar = {
		lualine_c = { { "filename", path = 1 } },
	},
})
