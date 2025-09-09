-- Mason
local ok_mason, mason = pcall(require, "mason")
if ok_mason then mason.setup() end

-- Mason-null-ls bridge
local ok_bridge, mason_null_ls = pcall(require, "mason-null-ls")
if ok_bridge then
  mason_null_ls.setup({
    ensure_installed = {
      "prettier",
      "stylua",
      -- "google-java-format", -- not used; jdtls formats Java
      "autopep8",
      "shellcheck",
      "shfmt",
      "clang-format",
      "cppcheck",
    },
    automatic_installation = true,
  })
end

-- Put Mason tools on PATH
vim.env.PATH = vim.fn.stdpath("data") .. "/mason/bin:" .. vim.env.PATH

-- null-ls
local null_ls = require("null-ls")

null_ls.setup({
  debug = true,
  root_dir = require("null-ls.utils").root_pattern(".git", "."),
  sources = {
    -- Web
    null_ls.builtins.formatting.prettier,
    -- Lua
    null_ls.builtins.formatting.stylua,
    -- Python
    null_ls.builtins.formatting.autopep8,
    -- Shell
    null_ls.builtins.diagnostics.shellcheck,
    null_ls.builtins.formatting.shfmt.with({ extra_args = { "-i", "4", "-ci" } }),
    -- C only
    null_ls.builtins.formatting.clang_format.with({
      filetypes = { "c" },
      extra_args = {
        "--style={BasedOnStyle: LLVM, IndentWidth: 4, TabWidth: 4, UseTab: Never, ContinuationIndentWidth: 4, AlignAfterOpenBracket: DontAlign, AlignOperands: false, ColumnLimit: 0}",
      },
    }),
    null_ls.builtins.diagnostics.cppcheck.with({ filetypes = { "c" } }),
  },

  on_attach = function(client, bufnr)
    if client.supports_method("textDocument/formatting") then
      local function prefer_for_buf(c)
        -- Use jdtls for Java, null-ls for everything else
        if vim.bo[bufnr].filetype == "java" then
          return c.name == "jdtls"
        end
        return c.name == "null-ls" or c.name == "none-ls"
      end

      vim.keymap.set("n", "<leader>f", function()
        vim.lsp.buf.format({ bufnr = bufnr, filter = prefer_for_buf })
      end, { buffer = bufnr, desc = "Format buffer" })

      local grp = vim.api.nvim_create_augroup("FormatOnSave", { clear = true })
      vim.api.nvim_clear_autocmds({ group = grp, buffer = bufnr })
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = grp,
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format({ bufnr = bufnr, filter = prefer_for_buf })
        end,
      })
    end
  end,
})

-- Other LSPs installed via mason-lspconfig (not jdtls)
require("mason-lspconfig").setup({
  ensure_installed = { "lua_ls", "ts_ls", "pyright", "bashls", "clangd" },
})

-- Example clangd tweak: disable its formatter so clang-format handles C
local lspconfig = require("lspconfig")
lspconfig.clangd.setup({
  on_attach = function(client, _)
    client.server_capabilities.documentFormattingProvider = false
  end,
})

-- Extra: run clang-format after save for C/C++ headers if you want it external too
local cf_style =
  "{BasedOnStyle: LLVM, IndentWidth: 4, TabWidth: 4, UseTab: Never, ContinuationIndentWidth: 4, AlignAfterOpenBracket: DontAlign, AlignOperands: false, ColumnLimit: 0}"
vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = { "*.c", "*.h" },
  callback = function(args)
    local file = args.match
    vim.system({ "clang-format", "--style=" .. cf_style, "-i", file }, { text = true }, function()
      vim.schedule(function() vim.cmd("edit") end)
    end)
  end,
})

-- Disable Treesitter indent for Java so the formatter wins
pcall(function()
  local ts = require("nvim-treesitter.configs")
  ts.setup({ indent = { enable = true, disable = { "java" } } })
end)

-- Java buffer options
vim.api.nvim_create_autocmd("FileType", {
  pattern = "java",
  callback = function()
    vim.bo.expandtab   = true
    vim.bo.shiftwidth  = 4
    vim.bo.tabstop     = 4
    vim.bo.softtabstop = 4
    vim.bo.cindent     = false
  end,
})
