-- COLORS -- 
vim.keymap.set("n", "<leader>cc",require("config.colors").SelectColorscheme, { desc = "Change colorscheme" })

-- NEO-TREE --
vim.keymap.set("n", "<leader>pv", require("config.neo-tree").toggle, {desc = "Toggle between editor pane and tree pane"})

-- SYSTEM CLIPBOARD --
vim.keymap.set("n", "<leader>p", '"+p', { desc = "Clipboard paste" })
vim.keymap.set("v", "<leader>p", '"+p', { desc = "Clipboard paste" })
vim.keymap.set("n", "<leader>y", '"+y', { desc = "Clipboard yank" })
vim.keymap.set("v", "<leader>y", '"+y', { desc = "Clipboard yank" })
vim.keymap.set("n", "<leader>Y", '"+Y', { desc = "Clipboard yank line" })

-- TELESCOPE --
vim.keymap.set("n", "<leader>pf", function()
  require("telescope.builtin").find_files()
end)

-- LAZYGIT --
vim.keymap.set("n", "<leader>gg", "<cmd>LazyGit<CR>", { desc = "Open LazyGit" })

-- FUGITIVE --
vim.keymap.set("n", "<leader>gs", vim.cmd.Git, { desc = "Open Fugitive" })

vim.keymap.set("n", "gp", "<cmd>Lspsaga peek_definition<CR>")
vim.keymap.set("n", "gt", "<cmd>Lspsaga peek_type_definition<CR>")
vim.keymap.set("n", "gh", "<cmd>Lspsaga hover_doc<CR>")

vim.keymap.set("n", "<leader>pg", function()
  require("telescope.builtin").git_files()
end)

vim.keymap.set("n", "<leader>p/", function()
  require("telescope.builtin").current_buffer_fuzzy_find()
end)

vim.keymap.set("n", "<leader>ps", function()
  require("telescope.builtin").live_grep()
end)

-- TRANSPARENCY --
vim.keymap.set("n", "<leader>ut", function()
  require("config.ui").toggle_transparency()
end, { desc = "Toggle transparency" })

-- TOGGLES --
vim.keymap.set("n", "<leader>oe", ":Neotree filesystem toggle left<CR>", { desc = "Toggle Neo-tree (filesystem)" })

vim.keymap.set("n", "<leader>ob", require("config.ui").toggle_transparency, { desc = "Toggle background transparency" })

vim.keymap.set("n", "<leader>tt", "<cmd>ToggleTerm direction=horizontal<CR>")
vim.keymap.set("n", "<leader>tv", "<cmd>ToggleTerm direction=vertical<CR>")
vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], { silent = true })

-- Diffview: open/close repo diff
vim.keymap.set("n", "<leader>od", "<cmd>DiffviewToggle<CR>", { desc = "Toggle Diffview (repo diff)" })

-- Diffview: file history (current file)
vim.keymap.set("n", "<leader>oh", "<cmd>DiffviewFileHistory %<CR>", { desc = "File history (current file)" })

-- SNIPPETS --

vim.keymap.set("n", "<leader>mf", require("utils.makefiles").create_make_file, { desc = "Create make file at cursor file" })
