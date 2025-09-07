-- lua/plugins/nvim-tree.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.termguicolors = true

require("nvim-tree").setup({
	-- your tree options
})

-- === focus toggle code ===
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
		return -- do nothing if tree isn’t open
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

-- after your existing code in lua/plugins/nvim-tree.lua
local api = require("nvim-tree.api")

vim.api.nvim_create_autocmd("FileType", {
	pattern = "NvimTree",
	callback = function(ev)
		-- <leader>cd: set tree root to directory under cursor
		vim.keymap.set("n", "<leader>cd", function()
			local node = api.tree.get_node_under_cursor()
			if node and node.type == "directory" then
				api.tree.change_root(node.absolute_path)
			else
				vim.notify("Cursor is not on a directory", vim.log.levels.WARN)
			end
		end, { buffer = ev.buf, desc = "NvimTree: change root to cursor dir" })

		-- optional: <leader>cu go up one level
		vim.keymap.set("n", "<leader>cu", function()
			api.tree.change_root("..")
		end, { buffer = ev.buf, desc = "NvimTree: change root to parent" })
	end,
})
