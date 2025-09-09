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

-- Only show Alpha when starting with no files/args
vim.api.nvim_create_autocmd("VimEnter", {
	callback = function()
		if vim.fn.argc() == 0 then
			alpha.start(true)
		end
	end,
})

alpha.setup(dashboard.opts)
