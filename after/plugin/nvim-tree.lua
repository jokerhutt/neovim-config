vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.termguicolors = true

require("nvim-tree").setup({
	view = {
		width = 50,
		side = "left",
	},
	actions = {
		open_file = {
			quit_on_open = false,
			resize_window = true,
			window_picker = { enable = false },
		},
	},

	on_attach = function(bufnr)
		local api = require("nvim-tree.api")

		api.config.mappings.default_on_attach(bufnr)

		local function map(lhs, rhs, desc)
			vim.keymap.set(
				"n",
				lhs,
				rhs,
				{ buffer = bufnr, noremap = true, silent = true, nowait = true, desc = "NvimTree: " .. desc }
			)
		end

		map("<CR>", api.node.open.edit, "Open")

		map("<CR>", api.node.open.edit, "Open")

		map("A", function()
			local api = require("nvim-tree.api")
			local node = api.tree.get_node_under_cursor()
			local base
			if node and node.type == "directory" then
				base = node.absolute_path
			elseif node then
				base = vim.fn.fnamemodify(node.absolute_path, ":h")
			else
				base = api.tree.get_nodes().root.absolute_path
			end

			vim.ui.input({ prompt = "New directory name: " }, function(name)
				if not name or name == "" then
					return
				end
				local path = base .. "/" .. name
				vim.fn.mkdir(path, "p") -- create directory (recursive)
				api.tree.reload() -- refresh the view
			end)
		end, "Create directory")

		map("<leader>v", function()
			local old = vim.opt.splitright:get()
			vim.opt.splitright = true
			api.node.open.vertical()
			vim.opt.splitright = old
		end, "Open in vsplit (always right)")

		map("<leader>s", function()
			local old = vim.opt.splitbelow:get()
			vim.opt.splitbelow = true
			api.node.open.horizontal()
			vim.opt.splitbelow = old
		end, "Open in split (always below)")

		-- change root to dir under cursor
		map("<leader>cd", function()
			local node = api.tree.get_node_under_cursor()
			if node and node.type == "directory" then
				api.tree.change_root(node.absolute_path)
			else
				vim.notify("Cursor is not on a directory", vim.log.levels.WARN)
			end
		end, "Change root to cursor dir")

		map("<leader>cu", api.tree.change_root_to_parent, "Change root to parent")
	end,
})

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
