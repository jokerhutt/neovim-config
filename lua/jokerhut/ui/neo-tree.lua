vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

local ok, neotree = pcall(require, "neo-tree")
if not ok then
	vim.notify("neo-tree not found", vim.log.levels.ERROR)
	return
end

neotree.setup({
	close_if_last_window = false,
	enable_git_status = true,
	enable_diagnostics = false,

	default_component_configs = {
		indent = {
			indent_size = 2,
			padding = 1,
			with_markers = true,
			indent_marker = "│",
			last_indent_marker = "└",
		},
	},

	window = {
		mappings = {
			["<cr>"] = function(state)
				local node = state.tree:get_node()

				if node.path == state.path then
					vim.cmd("Neotree reveal_force_cwd dir=" .. vim.fn.fnameescape(vim.fn.fnamemodify(state.path, ":h")))
					vim.cmd("cd " .. vim.fn.fnameescape(vim.fn.fnamemodify(state.path, ":h")))
					vim.notify("Moved up to " .. vim.fn.fnamemodify(state.path, ":h"))
					return
				end

				require("neo-tree.sources.filesystem.commands").open(state)
			end,

			["|"] = "open_vsplit",
			["-"] = "open_split",
			["<bs>"] = "navigate_up",

			["A"] = {
				function(state)
					local node = state.tree:get_node()
					local base = (node.type == "directory") and node.path or vim.fn.fnamemodify(node.path, ":h")
					vim.ui.input({ prompt = "New directory name: " }, function(name)
						if not name or name == "" then
							return
						end
						vim.fn.mkdir(base .. "/" .. name, "p")
						require("neo-tree.sources.filesystem").refresh(state)
					end)
				end,
				desc = "Create directory",
			},
		},
	},

	filesystem = {
		follow_current_file = { enabled = true, leave_dirs_open = false },
		filtered_items = { hide_dotfiles = false },
		group_empty_dirs = false,
		hijack_netrw_behavior = "open_default",
		use_libuv_file_watcher = true,
	},
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = "neo-tree",
	callback = function(ev)
		vim.keymap.set("n", "<leader>cd", function()
			local manager = require("neo-tree.sources.manager")
			local state = manager.get_state("filesystem")
			local node = nil

			if state and state.tree and state.tree.get_node then
				node = state.tree:get_node()
			end
			if not node then
				local renderer = require("neo-tree.ui.renderer")
				if renderer.get_node then
					node = renderer.get_node()
				end
			end
			if not node or node.type ~= "directory" then
				vim.notify("Select a directory node", vim.log.levels.WARN)
				return
			end

			local dir = vim.fn.fnameescape(node.path)
			vim.cmd("Neotree dir=" .. dir)
			vim.cmd("cd " .. dir)
			vim.notify("Changed working dir to " .. node.path)
		end, { buffer = ev.buf, desc = "Neo-tree: change root and cd" })
	end,
})

local last_normal_win = nil
vim.api.nvim_create_autocmd("WinEnter", {
	callback = function()
		if vim.bo.filetype ~= "neo-tree" then
			last_normal_win = vim.api.nvim_get_current_win()
		end
	end,
})

local function toggle_focus_tree_or_last()
	local nt_win = nil
	for _, win in ipairs(vim.api.nvim_list_wins()) do
		local ft = vim.bo[vim.api.nvim_win_get_buf(win)].filetype
		if ft == "neo-tree" then
			nt_win = win
			break
		end
	end
	if not nt_win then
		vim.cmd("Neotree show filesystem left")
		return
	end
	if vim.api.nvim_get_current_win() == nt_win then
		if last_normal_win and vim.api.nvim_win_is_valid(last_normal_win) then
			vim.api.nvim_set_current_win(last_normal_win)
		else
			vim.cmd("wincmd p")
		end
	else
		vim.api.nvim_set_current_win(nt_win)
	end
end

vim.keymap.set("n", "<leader>pv", toggle_focus_tree_or_last, { desc = "Focus swap: neo-tree ↔ last window" })
