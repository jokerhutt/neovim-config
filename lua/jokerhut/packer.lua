-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'

-- Telescope Config
use {
  'nvim-telescope/telescope.nvim', tag = '0.1.8',
  requires = { {'nvim-lua/plenary.nvim'} }
}

-- Xcode Theme
use ({
  'rose-pine/neovim',
  as = "rose-pine",
  config = function()
	  vim.cmd('colorscheme rose-pine')  
  end
})



    use (
        'nvim-treesitter/nvim-treesitter',
	{run = ':TSUpdate'}
    )
use ('nvim-treesitter/playground')
use ('theprimeagen/harpoon')

use('mbbill/undotree')
use('tpope/vim-fugitive')
use ('wakatime/vim-wakatime')

use 'neovim/nvim-lspconfig'         -- basic LSP support
use 'williamboman/mason.nvim'       -- LSP/DAP/Linter/Formatter installer
use 'williamboman/mason-lspconfig.nvim' -- bridges mason + lspconfig

use {
  'hrsh7th/nvim-cmp',
  requires = {
    'hrsh7th/cmp-nvim-lsp', -- LSP source
    'hrsh7th/cmp-buffer',   -- buffer source
    'hrsh7th/cmp-path',     -- filesystem paths
    'hrsh7th/cmp-cmdline',  -- cmdline completions
    'L3MON4D3/LuaSnip',     -- snippet engine
    'saadparwaiz1/cmp_luasnip' -- snippet completions
  }
}



end)


