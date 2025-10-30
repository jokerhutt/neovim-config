local smart = require("jokerhut.ui.smart_panels")

-- ===== Compiler detect (return win) =====
local function compiler_is_open()
	for _, win in ipairs(vim.api.nvim_list_wins()) do
		local buf = vim.api.nvim_win_get_buf(win)
		local ft = vim.bo[buf].filetype
		local name = vim.api.nvim_buf_get_name(buf)
		if ft == "compiler_results" or ft == "compiler" or ft == "qf" or name:match("Compiler Results") then
			return true, win
		end
	end
	return false, nil
end

-- ===== Terminal detect =====
local function term_is_open()
	for _, win in ipairs(vim.api.nvim_list_wins()) do
		if vim.bo[vim.api.nvim_win_get_buf(win)].buftype == "terminal" then
			return true
		end
	end
	return false
end

-- ===== Panels =====
smart.register("terminal", {
	is_open = term_is_open,
	open = function()
		local ok, win = compiler_is_open()
		if ok and win and vim.api.nvim_win_is_valid(win) then
			pcall(vim.api.nvim_win_close, win, true)
		end
		pcall(vim.cmd, "cclose") -- if it’s quickfix
		vim.cmd("ToggleTerm")
	end,
	close = function()
		if term_is_open() then
			vim.cmd("ToggleTerm")
		end
	end,
})

smart.register("compiler", {
	is_open = function()
		local ok = compiler_is_open()
		return ok
	end,
	open = function()
		if term_is_open() then
			pcall(vim.cmd, "ToggleTerm")
		end
		vim.cmd("CompilerToggleResults")
	end,
	close = function()
		local ok, win = compiler_is_open()
		if ok and win and vim.api.nvim_win_is_valid(win) then
			pcall(vim.api.nvim_win_close, win, true)
		end
		pcall(vim.cmd, "cclose")
	end,
})

-- ===== Keymaps =====
-- IntelliJ-style toggles
vim.keymap.set("n", "<leader>tt", function()
	smart.toggle("terminal")
end, { desc = "Toggle Terminal (hides other panels)" })

vim.keymap.set("n", "<leader>tc", function()
	smart.toggle("compiler")
end, { desc = "Toggle Compiler Results (hides other panels)" })

-- Compiler commands (now aware of smart panels)
vim.keymap.set("n", "<leader>c", function()
	-- hide other panels, then open the compiler menu
	smart.open("compiler")
	vim.cmd("CompilerOpen")
end, { noremap = true, silent = true, desc = "Open compiler menu" })

vim.keymap.set("n", "<leader>r", function()
	smart.open("compiler")
	vim.cmd("CompilerRedo")
end, { noremap = true, silent = true, desc = "Redo last compile" })

vim.keymap.set("n", "<leader>cr", function()
	smart.open("compiler")
	vim.cmd("CompilerStop | CompilerRedo | CompilerToggleResults")
end, { noremap = true, silent = true, desc = "Compile, run, and show results" })
