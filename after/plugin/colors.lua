require("themes.rosepine")

function ColorMyPencils(color)
	color = color or "rose-pine"
	vim.cmd.colorscheme(color)


end

vim.api.nvim_create_autocmd("FileType", {
  pattern = "java",
  callback = function()

        vim.api.nvim_set_hl(0, "@lsp.mod.static.java", { fg = "#eb6f92" })

        vim.api.nvim_set_hl(0, "@lsp.type.modifier.java", { bold = true })

        vim.api.nvim_set_hl(0, "@keyword.type.java", { fg = "#9ccfd8", bold = true })

    -- LSP methods
    vim.api.nvim_set_hl(0, "@function.method", { fg = "#c4a7e7" })
    -- Treesitter method calls
    vim.api.nvim_set_hl(0, "@function.method.call", { fg = "#eb6f92"})
    -- Properties / fields
    vim.api.nvim_set_hl(0, "@property", { fg = "#31748f" })

    vim.api.nvim_set_hl(0, "@type.builtin.java", { fg = "#ebbcba" })

  end,
})

ColorMyPencils()

vim.api.nvim_create_autocmd("ColorScheme", {
	group = vim.api.nvim_create_augroup("AlwaysMyPencils", { clear = true }),
	callback = function() end,
})
