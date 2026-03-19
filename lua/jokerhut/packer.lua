vim.cmd([[packadd packer.nvim]])

return require("packer").startup(function(use)
	use("wbthomason/packer.nvim")

	-- Telescope
	use({
		"nvim-telescope/telescope.nvim",
		tag = "0.1.8",
		requires = { { "nvim-lua/plenary.nvim" } },
	})

	-- Neo Tree

	use({
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		requires = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
		},
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

	use({
		"folke/snacks.nvim",
		opts = {},
	})

	use({
		"folke/which-key.nvim",
		config = function()
			require("which-key").setup({})
		end,
	})

	use({
		"folke/todo-comments.nvim",
		requires = { "nvim-lua/plenary.nvim" },
		config = function()
			require("todo-comments").setup({})
		end,
	})

	use({
		"folke/edgy.nvim",
		requires = {
			"akinsho/toggleterm.nvim",
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
		},
	})

	use({
		"nvim-lualine/lualine.nvim",
		requires = { "nvim-tree/nvim-web-devicons" },
	})

	use({ "goolord/alpha-nvim" })

	use({ "kdheepak/lazygit.nvim" })

	use({ "sindrets/diffview.nvim" })

	use({ "OXY2DEV/markview.nvim" })

	use({ "MaximilianLloyd/ascii.nvim", requires = {
		"MunifTanjim/nui.nvim",
	} })

	use({ "nvim-tree/nvim-web-devicons" })

	-- Color Theme
	use({ "rose-pine/neovim", as = "rose-pine" })
	use({ "arzg/vim-colors-xcode", as = "xcode" })
	use({ "Mofiqul/dracula.nvim", as = "dracula" })
	use({ "catppuccin/nvim", as = "catppuccin" })
	use({
		"marko-cerovac/material.nvim",
		as = "material",
	})
	use({
		"vague-theme/vague.nvim",
		config = function()
			require("vague").setup({})
		end,
	})
	use({ "AlexvZyl/nordic.nvim", as = "nordic" })
	use({ "projekt0n/github-nvim-theme", as = "github" })
	use({ "martinsione/darkplus.nvim", as = "darkplus" })
	use({ "folke/tokyonight.nvim", as = "tokyonight" })
	use({
		"Mofiqul/vscode.nvim",
		opt = false,
	})

	use("nvim-treesitter/nvim-treesitter", { run = ":TSUpdate" })

	-- Toggle Term
	use({
		"akinsho/toggleterm.nvim",
		tag = "*",
		config = function()
			require("toggleterm").setup({
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

	use({
		"nvim-treesitter/nvim-treesitter-context",
		requires = { "nvim-treesitter/nvim-treesitter" },
		config = function()
			require("treesitter-context").setup({
				enable = true,
				max_lines = 4,
				trim_scope = "outer",
				mode = "cursor",
			})
		end,
	})

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

	use({
		"stevearc/overseer.nvim",
		commit = "6271cab7ccc4ca840faa93f54440ffae3a3918bd",
		config = function()
			require("overseer").setup({
				strategy = {
					"toggleterm",
					direction = "horizontal",
					open_on_start = true,
					close_on_exit = false,
				},
				templates = { "builtin" },
			})
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
