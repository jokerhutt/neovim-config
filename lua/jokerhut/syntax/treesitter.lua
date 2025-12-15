require("nvim-treesitter.configs").setup({
	ensure_installed = {
		"c",
		"diff",
		"html",
		"luadoc",
		"markdown_inline",
		"vim",
		"vimdoc",
		"markdown",
		"query",
		"yaml",
		"json",
		"toml",
		"lua",
		"java",
		"javascript",
		"python",
		"typescript",
		"rust",
		"bash",
	},

	modules = {},
	sync_install = false,
	ignore_install = {},

	auto_install = true,

	highlight = {
		enable = true,
		additional_vim_regex_highlighting = { "ruby" },
	},
	indent = { enable = true, disable = { "ruby" } },
})

-- Tell NVim to treat .env files as shell
vim.filetype.add({
	extension = {
		env = "sh",
	},
	filename = {
		[".env"] = "sh",
		[".env.local"] = "sh",
	},
})
