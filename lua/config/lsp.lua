require("mason").setup()

local lspconfig = require("lspconfig")
local caps = require("cmp_nvim_lsp").default_capabilities()

require("mason-lspconfig").setup({
  ensure_installed = {
    "lua_ls",
    "tailwindcss",
    "ts_ls",
    "yamlls",
    "basedpyright",
    "bashls",
    "clangd",
    "jdtls",
  },
  handlers = {
    function(server)
      lspconfig[server].setup({ capabilities = caps })
    end,

    ["jdtls"] = function() end,

    ["yamlls"] = function()
      lspconfig.yamlls.setup({
        capabilities = caps,
        root_dir = function()
          return vim.fn.getcwd()
        end,
        settings = {
          yaml = {
            validate = true,
            hover = true,
            completion = true,
          },
        },
      })
    end,

    ["tailwindcss"] = function()
      lspconfig.tailwindcss.setup({
        capabilities = caps,
        filetypes = {
          "html",
          "css",
          "javascript",
          "javascriptreact",
          "typescript",
          "typescriptreact",
        },
      })
    end,
  },
})

-- LSP AND DIAGNOSTIC KEYMAPS --
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic under cursor" })
vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename symbol" })

vim.keymap.set("n", "<leader>ee", function()
  require("telescope.builtin").diagnostics({ bufnr = 0 })
end, { desc = "File diagnostics" })

vim.keymap.set("n", "<leader>er", function()
  require("telescope.builtin").diagnostics({
    bufnr = 0,
    severity_limit = vim.diagnostic.severity.ERROR,
  })
end, { desc = "Errors only" })

vim.keymap.set("n", "<leader>ew", function()
  require("telescope.builtin").diagnostics({
    bufnr = 0,
    severity_limit = vim.diagnostic.severity.WARN,
  })
end, { desc = "Warnings only" })
