vim.cmd([[packadd packer.nvim]])

return require("packer").startup(function(use)
	use("wbthomason/packer.nvim")

	-- Telescope Config
	use({
		"nvim-telescope/telescope.nvim",
		tag = "0.1.8",
		requires = { { "nvim-lua/plenary.nvim" } },
	})

	-- Color Theme
	use({ "rose-pine/neovim", as = "rose-pine" })
	use("nvim-treesitter/nvim-treesitter", { run = ":TSUpdate" })

	-- Toggle Term
	use({
		"akinsho/toggleterm.nvim",
		tag = "*",
		config = function()
			require("toggleterm").setup({
				size = 15,
				open_mapping = [[<C-\>]],
				shade_terminals = true,
				direction = "horizontal",
			})
		end,
	})

	-- Formatters
	use({ "nvimtools/none-ls.nvim" })
	use({ "jay-babu/mason-null-ls.nvim" })

	-- TreeSitter
	use("nvim-treesitter/playground")

	-- Harpoon
	use("theprimeagen/harpoon")

	-- Undo Tree
	use("mbbill/undotree")

	-- Vim Fugitive
	use("tpope/vim-fugitive")

	-- Wakatime
	use("wakatime/vim-wakatime")

	-- LSP
	use("neovim/nvim-lspconfig") -- basic LSP support
	use("williamboman/mason.nvim") -- LSP/DAP/Linter/Formatter installer
	use("williamboman/mason-lspconfig.nvim") -- bridges mason + lspconfig

	-- CMP
	use({
		"hrsh7th/nvim-cmp",
		requires = {
			"hrsh7th/cmp-nvim-lsp", -- LSP source
			"hrsh7th/cmp-buffer", -- buffer source
			"hrsh7th/cmp-path", -- filesystem paths
			"hrsh7th/cmp-cmdline", -- cmdline completions
			"L3MON4D3/LuaSnip", -- snippet engine
			"saadparwaiz1/cmp_luasnip", -- snippet completions
		},
	})
end)
