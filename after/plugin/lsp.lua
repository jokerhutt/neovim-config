local lspconfig = require("lspconfig")
local caps = require("cmp_nvim_lsp").default_capabilities()


lspconfig.lua_ls.setup({
  capabilities = caps,
  settings = { Lua = { diagnostics = { globals = { "vim" } }, workspace = { checkThirdParty = false } } },
})

lspconfig.ts_ls.setup({ capabilities = caps })
lspconfig.pyright.setup({ capabilities = caps })
lspconfig.bashls.setup({ capabilities = caps })
lspconfig.clangd.setup({ capabilities = caps })
