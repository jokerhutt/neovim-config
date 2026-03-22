local makefiles = require("jokerhut.snippets.makefiles")

-- TOGGLES --

vim.keymap.set("n", "<leader>mf", makefiles.create_make_file, { desc = "Create make file at cursor file" })
