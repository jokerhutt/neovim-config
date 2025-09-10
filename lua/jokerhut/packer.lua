vim.cmd([[packadd packer.nvim]])

return require("packer").startup(function(use)
	use("wbthomason/packer.nvim")

	-- Telescope Config
	use({
		"nvim-telescope/telescope.nvim",
		tag = "0.1.8",
		requires = { { "nvim-lua/plenary.nvim" } },
	})

	-- UI
	use({
		"stevearc/dressing.nvim",
		config = function()
			require("dressing").setup({
				select = {
					backend = { "telescope", "builtin" },
					builtin = { start_in_insert = false },
				},
				input = {
					relative = "editor",
					prefer_width = 50,
					insert_only = false,
				},
			})
		end,
	})

	use({ "goolord/alpha-nvim" })

	use({ "kdheepak/lazygit.nvim" })

	use({ "OXY2DEV/markview.nvim" })

	use({ "MaximilianLloyd/ascii.nvim", requires = {
		"MunifTanjim/nui.nvim",
	} })

	use("nvim-tree/nvim-tree.lua")
	use({ "nvim-tree/nvim-web-devicons" })

	use({ "akinsho/bufferline.nvim", tag = "*" })

	-- Color Theme
	use({ "rose-pine/neovim", as = "rose-pine" })
	use({ "arzg/vim-colors-xcode", as = "xcode" })
	use("Mofiqul/dracula.nvim")
	use({ "catppuccin/nvim", as = "catppuccin" })
	use({
		"projekt0n/github-nvim-theme",
		config = function()
			require("github-theme").setup({})
		end,
	})

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

	use({
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = function()
			require("nvim-autopairs").setup({})
		end,
	})

	-- Formatters
	use({ "nvimtools/none-ls.nvim" })
	use({ "gbprod/none-ls-shellcheck.nvim" })
	use({ "nvimtools/none-ls-extras.nvim" })

	-- TreeSitter
	use("nvim-treesitter/playground")

	-- Harpoon
	use({
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		requires = { "nvim-lua/plenary.nvim" },
	})
	-- Undo Tree
	use("mbbill/undotree")

	-- Vim Fugitive
	use("tpope/vim-fugitive")

	-- Wakatime
	use("wakatime/vim-wakatime")

	-- Vim Be Good
	use("ThePrimeagen/vim-be-good")

	-- LSP
	use("neovim/nvim-lspconfig") -- basic LSP support
	use("williamboman/mason.nvim") -- LSP/DAP/Linter/Formatter installer
	use("williamboman/mason-lspconfig.nvim") -- bridges mason + lspconfig

	-- Java support
	use("mfussenegger/nvim-jdtls")
	use("mfussenegger/nvim-dap")

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

	-- Ensures External Tools install
	use("WhoIsSethDaniel/mason-tool-installer.nvim")

	-- Auto Compiler Stuff
	use({
		"stevearc/overseer.nvim",
		commit = "6271cab7ccc4ca840faa93f54440ffae3a3918bd",
		module = "overseer",
		config = function()
			require("overseer").setup({
				task_list = { direction = "bottom", min_height = 25, max_height = 25, default_detail = 1 },
			})
		end,
	})

	use({
		"Zeioth/compiler.nvim",
		requires = { "stevearc/overseer.nvim", "nvim-telescope/telescope.nvim" },
		after = "overseer.nvim",
		cmd = { "CompilerOpen", "CompilerToggleResults", "CompilerRedo", "CompilerStop" },
		config = function()
			require("compiler").setup({})
		end,
	})

	use("MunifTanjim/nui.nvim")
	use({
		"kawre/leetcode.nvim",
		requires = { "nvim-lua/plenary.nvim", "MunifTanjim/nui.nvim" },
		run = ":TSUpdate html",
		config = function() end,
	})
end)
