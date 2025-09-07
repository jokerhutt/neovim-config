require("bufferline").setup({
	options = {
		show_buffer_close_icons = false,
		show_close_icon = false,
		always_show_bufferline = true,
		offsets = {
			{ filetype = "NvimTree", text = "Explorer", separator = true },
		},
	},
})

-- ordered buffer ids from bufferline
local function ordered_buffers()
	local ok, bl = pcall(require, "bufferline")
	if not ok then
		return {}
	end
	local elems = bl.get_elements().elements or {}
	local ids = {}
	for _, e in ipairs(elems) do
		ids[#ids + 1] = e.id
	end
	return ids
end

-- window in THIS tabpage showing bufnr
local function win_showing_buf(bufnr)
	for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
		if vim.api.nvim_win_get_buf(win) == bufnr then
			return win
		end
	end
end

-- cycle: if target visible -> jump to its window; else load it here
local function cycle_focus_visible(dir)
	local list = ordered_buffers()
	if #list == 0 then
		return
	end

	local cur = vim.api.nvim_get_current_buf()
	local idx = 1
	for i, b in ipairs(list) do
		if b == cur then
			idx = i
			break
		end
	end

	idx = ((idx - 1 + dir) % #list) + 1
	local target = list[idx]

	local win = win_showing_buf(target)
	if win then
		vim.api.nvim_set_current_win(win) -- focus pane showing it
	else
		vim.api.nvim_win_set_buf(0, target) -- open in current pane
	end
end

vim.keymap.set("n", "<leader>[", function()
	cycle_focus_visible(-1)
end, { desc = "Prev buffer (focus if visible)" })
vim.keymap.set("n", "<leader>]", function()
	cycle_focus_visible(1)
end, { desc = "Next buffer (focus if visible)" })
