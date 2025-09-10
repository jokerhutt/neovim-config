local ok_alpha, alpha = pcall(require, "alpha")
if not ok_alpha then
	return
end

local dashboard = require("alpha.themes.dashboard")
local ok_ascii, ascii = pcall(require, "ascii")
if ok_ascii then
	dashboard.section.header.val = ascii.art.text.neovim.sharp
else
	dashboard.section.header.val = { "Neovim" }
end

-- BUTTONS
dashboard.section.buttons.val = {
	dashboard.button("e", "  New file", ":ene <BAR> startinsert<CR>"),
	dashboard.button("<leader>pf", "  Find file", ":Telescope find_files<CR>"),
	dashboard.button("<leader>pv", "  Open filetree", ":NvimTreeToggle<CR>"),
	dashboard.button("<leader>pr", "  Recent files", ":Telescope oldfiles<CR>"),
	dashboard.button("w", "󰱼  Find word", ":Telescope live_grep<CR>"),
	dashboard.button("<leader>bb", "  Bookmarks", ":Telescope marks<CR>"),
	dashboard.button("<leader>ol", "󰑖  Last session", ":SessionManager load_last_session<CR>"),
	dashboard.button("q", "  Quit", ":qa<CR>"),
}

-- SHOW ONLY ON STARTUP WITH NO ARGS
vim.api.nvim_create_autocmd("VimEnter", {
	callback = function()
		if vim.fn.argc() == 0 then
			alpha.start(true)
		end
	end,
})

alpha.setup(dashboard.opts)
