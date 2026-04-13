return {
    {
        "nvim-treesitter/nvim-treesitter",
        lazy = false,
        build = ":TSUpdate",
        config = function()
            require("nvim-treesitter.config").setup({

                languages = {
                    "c", "diff", "html", "luadoc", "markdown_inline", "vim", "vimdoc",
                    "markdown", "query", "yaml", "json", "toml", "lua", "java",
                    "javascript", "python", "typescript", "rust", "bash",
                },

                highlight = { enable = true },
                indent = { enable = true },

                additional_vim_regex_highlighting = { "ruby" },
            })
        end,
    },

    {
        "sphamba/smear-cursor.nvim",

        opts = {
            stiffness = 0.8,
            trailing_stiffness = 0.5,
            distance_stop_animating = 0.5,
            cursor_color = "#ffffff",
        },
    },


    -- Telescope
    {
        "nvim-telescope/telescope.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
    },

    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons",
            "MunifTanjim/nui.nvim",
        },
        config = function()
            -- disable netrw
            vim.g.loaded_netrw = 1
            vim.g.loaded_netrwPlugin = 1

            require("neo-tree").setup({
                close_if_last_window = false,
                enable_git_status = true,
                enable_diagnostics = false,

                default_component_configs = {
                    indent = {
                        indent_size = 2,
                        padding = 1,
                        with_markers = true,
                        indent_marker = "│",
                        last_indent_marker = "└",
                    },
                },

                window = {
                    winbar = false,
                    mappings = {
                        ["<cr>"] = function(state)
                            local node = state.tree:get_node()

                            if node.path == state.path then
                                local parent = vim.fn.fnamemodify(state.path, ":h")
                                vim.cmd("Neotree reveal_force_cwd dir=" .. vim.fn.fnameescape(parent))
                                vim.cmd("cd " .. vim.fn.fnameescape(parent))
                                return
                            end

                            require("neo-tree.sources.filesystem.commands").open(state)
                        end,

                        ["|"] = "open_vsplit",
                        ["-"] = "open_split",
                        ["<bs>"] = "navigate_up",
                    },
                },

                filesystem = {
                    follow_current_file = { enabled = true, leave_dirs_open = false },
                    filtered_items = { hide_dotfiles = false },
                    group_empty_dirs = false,
                    hijack_netrw_behavior = "open_default",
                    use_libuv_file_watcher = true,
                },
            })
        end,
    },

    {
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
    },
    {
        "folke/snacks.nvim",
        opts = {}
    },
    {
        "folke/which-key.nvim",
        opts = {},
    },

    {
        "folke/todo-comments.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {},
    },
    {
        "folke/edgy.nvim",
        dependencies = {
            "akinsho/toggleterm.nvim",
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons",
        },
        config = function()
            require("config.edgy")
        end,
    },

    {
        "OXY2DEV/markview.nvim",
        lazy = false,
        config = function()
            require("config.markview")
        end,
    },

    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("config.lualine")
        end,
    },

    {
        "kdheepak/lazygit.nvim",
        cmd = { "LazyGit", "LazyGitConfig", "LazyGitCurrentFile" },
    },

    {
        "sindrets/diffview.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
    },

    -- Highlighters
    {
        "HiPhish/rainbow-delimiters.nvim",
        config = function()
            require("config.rainbow").setup()
        end,
    },

    -- Colors
    {
        "rose-pine/neovim",
        name = "rose-pine",
    },

    {
        "arzg/vim-colors-xcode",
        name = "xcode",
    },

    {
        "Mofiqul/dracula.nvim",
        name = "dracula",
    },

    {
        "catppuccin/nvim",
        name = "catppuccin",
    },

    {
        "marko-cerovac/material.nvim",
        name = "material",
    },

    {
        "vague-theme/vague.nvim",
        config = function()
            require("vague").setup({})
        end,
    },

    {
        "AlexvZyl/nordic.nvim",
        name = "nordic",
    },

    {
        "projekt0n/github-nvim-theme",
        name = "github",
    },

    {
        "martinsione/darkplus.nvim",
        name = "darkplus",
    },

    {
        "folke/tokyonight.nvim",
        name = "tokyonight",
    },

    {
        "Mofiqul/vscode.nvim",
        lazy = false,
    },

    {
        "akinsho/toggleterm.nvim",
        version = "*",
        config = function()
            require("toggleterm").setup({
                size = function(term)
                    if term.direction == "vertical" then return 80 end
                    if term.direction == "horizontal" then return 15 end
                end,
                shade_terminals = false,
            })
        end,
    },

    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        opts = {},
    },

    -- Formatters
    {
        "nvimtools/none-ls.nvim",
        dependencies = {
            "nvimtools/none-ls-extras.nvim",
            "gbprod/none-ls-shellcheck.nvim",
            "williamboman/mason.nvim",
        },
        config = function()
            require("config.none_ls")
        end,
    },


    {
        "nvim-treesitter/nvim-treesitter-context",
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        config = function()
            require("treesitter-context").setup({
                enable = true,
                max_lines = 4,
                trim_scope = "outer",
                mode = "cursor",
            })
        end,
    },

    -- Harpoon
    {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            require("config.harpoon")
        end,
    },
    -- Misc
    { "mbbill/undotree" },
    { "tpope/vim-fugitive" },
    { "wakatime/vim-wakatime" },
    { "ThePrimeagen/vim-be-good" },

    -- LSP
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "hrsh7th/cmp-nvim-lsp",
        },
        config = function()
            require("config.lsp")
        end,
    },

    {
        "nvimdev/lspsaga.nvim",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
            "nvim-lua/plenary.nvim",
        },
        config = function()
            require("lspsaga").setup({
                lightbulb = { enable = false },
            })
        end,
    },

    -- Linter
    { "mfussenegger/nvim-lint" },

    -- CMP
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
            "L3MON4D3/LuaSnip",
            "saadparwaiz1/cmp_luasnip",
        },
        config = function()
            require("config.cmp")
        end,
    },

    -- Mason tools
    { "WhoIsSethDaniel/mason-tool-installer.nvim" },

    { "MunifTanjim/nui.nvim" },

    {
        "obsidian-nvim/obsidian.nvim",
        version = "*",
        dependencies = { "nvim-lua/plenary.nvim" },

        opts = {
            legacy_commands = false,
            workspaces = {
                { name = "c",        path = vim.fn.expand("~/vaults/c") },
                { name = "personal", path = vim.fn.expand("~/vaults/personal") },
            },
        },

        keys = {
            {
                "<leader>oo",
                function()
                    local workspaces = {
                        { name = "c",        path = vim.fn.expand("~/vaults/c") },
                        { name = "personal", path = vim.fn.expand("~/vaults/personal") },
                    }

                    vim.ui.select(workspaces, {
                        prompt = "Select vault",
                        format_item = function(item) return item.name end,
                    }, function(choice)
                        if choice then
                            vim.cmd("Obsidian workspace " .. choice.name)
                            vim.cmd("Obsidian quick_switch")
                        end
                    end)
                end,
            },
        },
    }

}
