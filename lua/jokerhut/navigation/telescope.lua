local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>pf", builtin.find_files, { desc = "Find files in project" })
vim.keymap.set("n", "<leader>pg", builtin.git_files, { desc = "Find git files" })
vim.keymap.set("n", "<leader>p/", builtin.current_buffer_fuzzy_find, { desc = "Search in current file" })

vim.keymap.set("n", "<leader>ps", function()
	builtin.grep_string({ search = vim.fn.input("Grep > ") })
end, { desc = "Find string in project" })
