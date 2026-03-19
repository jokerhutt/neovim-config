local colors = require("jokerhut.appearance.colors")
vim.keymap.set("n", "<leader>cc", colors.SelectColorscheme, { desc = "Change colorscheme" })
