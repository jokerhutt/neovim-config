vim.o.background = "dark"

vim.o.termguicolors = true

require("jokerhut.keymaps")
require("jokerhut.packer")
require("jokerhut.set")
print("hello jokerhut")

vim.g.netrw_keepdir = 0

vim.api.nvim_set_hl(0, "NvimTreeNormal", { bg = "#404450" })
