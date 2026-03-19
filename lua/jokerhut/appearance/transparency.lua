local transparent = false

local function apply_transparency()
	local groups = {
		-- core
		"Normal",
		"NormalNC",
		"NormalFloat",
		"FloatBorder",
		"SignColumn",
		"EndOfBuffer",
		"StatusLine",
		"StatusLineNC",
		"WinSeparator",

		-- Edgy
		"EdgyNormal",
		"EdgyTitle",
		"EdgyWinBar",

		-- common sidebars
		"NeoTreeNormal",
		"NeoTreeNormalNC",
		"TelescopeNormal",
	}

	for _, g in ipairs(groups) do
		vim.api.nvim_set_hl(0, g, { bg = "none" })
	end
end

local M = {}

function M.toggle_transparency()
	transparent = not transparent

	if transparent then
		apply_transparency()
	else
		vim.cmd("colorscheme " .. vim.g.colors_name)
	end
end

return M
