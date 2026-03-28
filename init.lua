vim.o.background = "dark"
vim.o.termguicolors = true
vim.o.cursorline = true
vim.g.mapleader = " "

require("config.options")
require("config.ui")
require("lazy_setup")
require("config.colors")
require("config.keymaps")

vim.g.netrw_keepdir = 0

vim.api.nvim_set_hl(0, "NvimTreeNormal", { bg = "#404450" })
