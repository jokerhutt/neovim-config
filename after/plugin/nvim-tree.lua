-- disable netrw (recommended by nvim-tree)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.termguicolors = true

require("nvim-tree").setup({
	actions = {
		open_file = {
			quit_on_open = false,
			resize_window = true,
			window_picker = { enable = false }, -- don’t ask where to open
		},
	},

	on_attach = function(bufnr)
		local api = require("nvim-tree.api")

		-- bring back all default mappings
		api.config.mappings.default_on_attach(bufnr)

		local function map(lhs, rhs, desc)
			vim.keymap.set(
				"n",
				lhs,
				rhs,
				{ buffer = bufnr, noremap = true, silent = true, nowait = true, desc = "NvimTree: " .. desc }
			)
		end

		-- override open
		map("<CR>", api.node.open.edit, "Open")
		map("<leader>v", api.node.open.vertical, "Open in vsplit")
		map("<leader>s", api.node.open.horizontal, "Open in split")

		-- change root to dir under cursor
		map("<leader>cd", function()
			local node = api.tree.get_node_under_cursor()
			if node and node.type == "directory" then
				api.tree.change_root(node.absolute_path)
			else
				vim.notify("Cursor is not on a directory", vim.log.levels.WARN)
			end
		end, "Change root to cursor dir")

		-- change root to parent
		map("<leader>cu", api.tree.change_root_to_parent, "Change root to parent")
	end,
})

-- ===== focus toggle: tree ↔ last non-tree window =====
local api = require("nvim-tree.api")
local LAST_NORMAL_WIN = nil

vim.api.nvim_create_autocmd("WinEnter", {
	callback = function()
		if vim.bo.filetype ~= "NvimTree" then
			LAST_NORMAL_WIN = vim.api.nvim_get_current_win()
		end
	end,
})

local function toggle_focus_tree_or_last()
	if not api.tree.is_visible() then
		-- no tree -> open and focus it
		api.tree.open({ find_file = false, focus = true })
		return
	end

	if vim.bo.filetype == "NvimTree" then
		if LAST_NORMAL_WIN and vim.api.nvim_win_is_valid(LAST_NORMAL_WIN) then
			vim.api.nvim_set_current_win(LAST_NORMAL_WIN)
		else
			vim.cmd("wincmd p")
		end
	else
		api.tree.focus()
	end
end

vim.keymap.set("n", "<leader>pv", toggle_focus_tree_or_last, { desc = "Focus swap: tree ↔ last window" })
