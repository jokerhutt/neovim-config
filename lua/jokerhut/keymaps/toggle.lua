-- TOGGLES --
vim.keymap.set(
	"n",
	"<leader>oc",
	"<cmd>CompilerToggleResults<cr>",
	{ noremap = true, silent = true, desc = "Toggle compiler results" }
)

vim.keymap.set("n", "<leader>oe", ":Neotree filesystem toggle left<CR>", { desc = "Toggle Neo-tree (filesystem)" })

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

local function toggle_transparency()
	transparent = not transparent

	if transparent then
		apply_transparency()
	else
		vim.cmd("colorscheme " .. vim.g.colors_name)
	end
end

vim.keymap.set("n", "<leader>ob", toggle_transparency, { desc = "Toggle background transparency" })

vim.keymap.set("n", "<leader>ot", ":ToggleTerm<CR>", { desc = "Toggle terminal" })
vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], { silent = true })

-- Diffview: open/close repo diff
vim.keymap.set("n", "<leader>od", "<cmd>DiffviewToggle<CR>", { desc = "Toggle Diffview (repo diff)" })

-- Diffview: file history (current file)
vim.keymap.set("n", "<leader>oh", "<cmd>DiffviewFileHistory %<CR>", { desc = "File history (current file)" })
