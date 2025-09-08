-- lua/maven_runner.lua
local M = {}
local terms = {} -- per key: "mb","mt","mr"

local function ensure_right_split()
	local old = vim.opt.splitright:get()
	vim.opt.splitright = true
	vim.cmd("vsplit")
	vim.opt.splitright = old
end

local function focus_or_open(bufnr)
	local win = vim.fn.bufwinid(bufnr)
	if win ~= -1 then
		vim.api.nvim_set_current_win(win)
	else
		ensure_right_split()
		vim.api.nvim_win_set_buf(0, bufnr)
	end
end

local function make_readonly(bufnr)
	vim.bo[bufnr].readonly = true
	vim.bo[bufnr].modifiable = false
	vim.bo[bufnr].swapfile = false
	vim.bo[bufnr].undofile = false
	vim.bo[bufnr].buflisted = false

	-- don't auto-drop into insert when focusing the term
	vim.api.nvim_create_autocmd({ "TermOpen", "TermEnter", "BufEnter" }, {
		buffer = bufnr,
		callback = function()
			pcall(vim.cmd, "stopinsert")
		end,
	})

	-- local 'q' to just close the *window* (buffer stays hidden → job keeps running)
	vim.keymap.set("n", "q", "<cmd>close<CR>", { buffer = bufnr, silent = true })
end

local function scroll_to_bottom(bufnr)
	local win = vim.fn.bufwinid(bufnr)
	if win == -1 then
		return
	end
	local last = vim.api.nvim_buf_line_count(bufnr)
	pcall(vim.api.nvim_win_set_cursor, win, { last, 0 })
end

local function attach_autoscroll(bufnr)
	if vim.b[bufnr].maven_runner_autoscroll then
		return
	end
	vim.b[bufnr].maven_runner_autoscroll = true
	vim.api.nvim_buf_attach(bufnr, false, {
		on_lines = function()
			scroll_to_bottom(bufnr)
		end,
		on_bytes = function()
			scroll_to_bottom(bufnr)
		end,
	})
end

local function job_alive(job_id)
	if not job_id then
		return false
	end
	local ok, pid = pcall(vim.fn.jobpid, job_id)
	return ok and pid > 0
end

local function mark_hide(bufnr, key)
	-- crucial: hide, don't wipe → keeps PTY alive when window is closed
	vim.bo[bufnr].bufhidden = "hide"

	-- if the buffer *is* wiped some other way, clean our index
	vim.api.nvim_create_autocmd("BufWipeout", {
		buffer = bufnr,
		callback = function()
			if terms[key] == bufnr then
				terms[key] = nil
			end
		end,
	})
end

function M.focus(key)
	local bufnr = terms[key]
	if bufnr and vim.api.nvim_buf_is_valid(bufnr) then
		focus_or_open(bufnr)
		scroll_to_bottom(bufnr)
	else
		vim.notify("No Maven terminal for key: " .. tostring(key), vim.log.levels.WARN)
	end
end

function M.focus_any()
	for _, k in ipairs({ "mr", "mt", "mb" }) do
		local b = terms[k]
		if b and vim.api.nvim_buf_is_valid(b) then
			return M.focus(k)
		end
	end
	vim.notify("No Maven terminals are running.", vim.log.levels.WARN)
end

function M.run(cmd, key)
	local bufnr = terms[key]
	if bufnr and vim.api.nvim_buf_is_valid(bufnr) then
		focus_or_open(bufnr)
		attach_autoscroll(bufnr)
		make_readonly(bufnr)

		local chan = vim.b[bufnr].terminal_job_id
		if job_alive(chan) then
			-- stop previous run and start fresh in the same terminal
			vim.api.nvim_chan_send(chan, "\003") -- Ctrl-C
			vim.api.nvim_chan_send(chan, cmd .. "\n")
			scroll_to_bottom(bufnr)
		else
			-- terminal exists but job died → spawn a new one in-place
			vim.cmd("enew")
			vim.cmd("terminal " .. cmd)
			bufnr = vim.api.nvim_get_current_buf()
			terms[key] = bufnr
			attach_autoscroll(bufnr)
			make_readonly(bufnr)
			scroll_to_bottom(bufnr)
			mark_hide(bufnr, key)
		end
		return
	end

	-- first time for this key
	ensure_right_split()
	vim.cmd("terminal " .. cmd)
	bufnr = vim.api.nvim_get_current_buf()
	terms[key] = bufnr
	attach_autoscroll(bufnr)
	make_readonly(bufnr)
	scroll_to_bottom(bufnr)
	mark_hide(bufnr, key)
end

return M
