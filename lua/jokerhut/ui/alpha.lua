local ok_alpha, alpha = pcall(require, "alpha")
if not ok_alpha then
	return
end
local dashboard = require("alpha.themes.dashboard")

-- Header (ASCII if available)
local ok_ascii, ascii = pcall(require, "ascii")
dashboard.section.header.val = ok_ascii and ascii.art.text.neovim.sharp or { "Neovim" }
dashboard.section.header.opts.hl = "DashboardHeader"

-- Highlight groups
vim.o.termguicolors = true
vim.api.nvim_set_hl(0, "DashboardHeader", { fg = "#89b4fa", bold = true })

vim.api.nvim_set_hl(0, "DashBtnFiles", { fg = "#f5c2e7", bold = true }) -- pink
vim.api.nvim_set_hl(0, "DashBtnApps", { fg = "#89b4fa", bold = true }) -- light blue
vim.api.nvim_set_hl(0, "DashBtnDots", { fg = "#fab387", bold = true }) -- orange
vim.api.nvim_set_hl(0, "DashKey", { fg = "#cdd6f4", bold = true })
vim.api.nvim_set_hl(0, "DashMuted", { fg = "#6c7086" })
vim.api.nvim_set_hl(0, "DashPkg", { fg = "#7f849c" })
vim.api.nvim_set_hl(0, "DashTitle", { fg = "#94e2d5", bold = true })

-- per-project colors
vim.api.nvim_set_hl(0, "DashP1", { fg = "#cba6f7", bold = true })
vim.api.nvim_set_hl(0, "DashP2", { fg = "#f38ba8", bold = true })
vim.api.nvim_set_hl(0, "DashP3", { fg = "#fab387", bold = true })
vim.api.nvim_set_hl(0, "DashP4", { fg = "#74c7ec", bold = true })
vim.api.nvim_set_hl(0, "DashP5", { fg = "#74c7ec", bold = true })
vim.api.nvim_set_hl(0, "DashP6", { fg = "#a6e3a1", bold = true })
vim.api.nvim_set_hl(0, "DashP7", { fg = "#a6e3a1", bold = true })

-- Packages line (dynamic)
local start = vim.fn.globpath(vim.o.packpath, "pack/*/start/*", 1, 1)
local opt = vim.fn.globpath(vim.o.packpath, "pack/*/opt/*", 1, 1)
local pkgs = #start + #opt
local packages_line = {
	type = "text",
	val = ("neovim loaded %d packages"):format(pkgs),
	opts = { position = "center", hl = "DashPkg" },
}

-- Pinned projects
local pinned_title = {
	type = "text",
	val = "Pinned projects",
	opts = { position = "center", hl = "DashTitle" },
}

local pinned = {
	type = "group",
	val = {
		dashboard.button("1", "  ~/JCode/JHomelab", ":cd ~/JCode/JHomelab | Telescope find_files<CR>"),
		dashboard.button("2", "  ~/.config/nvim", ":cd ~/.config/nvim | Telescope find_files<CR>"),
		dashboard.button("3", "󰴺  ~/codemain/james-bot", ":cd ~/codemain/james-bot | Telescope find_files<CR>"),
	},
	opts = { position = "center", spacing = 1 },
}

-- color each pinned entry
local pin_hls = { "DashP1", "DashP2", "DashP3", "DashP4", "DashP5", "DashP6", "DashP7" }
for i, b in ipairs(pinned.val) do
	b.opts.hl, b.opts.hl_shortcut = pin_hls[((i - 1) % #pin_hls) + 1], "DashKey"
end

-- Layout
dashboard.config.layout = {
	{ type = "padding", val = 2 },
	dashboard.section.header,
	{ type = "padding", val = 2 },
	pinned_title,
	{ type = "padding", val = 1 },
	pinned,
}

-- Show only on empty start
vim.api.nvim_create_autocmd("VimEnter", {
	once = true,
	callback = function()
		if vim.fn.argc() == 0 then
			alpha.start(true)
		end
	end,
})

alpha.setup(dashboard.opts)

-- Re-apply header color after colorscheme changes
vim.api.nvim_create_autocmd("ColorScheme", {
	callback = function()
		vim.api.nvim_set_hl(0, "DashboardHeader", { fg = "#89b4fa", bold = true })
	end,
})
