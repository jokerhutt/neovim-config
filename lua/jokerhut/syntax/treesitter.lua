require("nvim-treesitter.configs").setup({
	ensure_installed = { "c", "lua", "java", "javascript", "python", "typescript", "rust", "bash" },

	sync_install = false,

	auto_install = true,

	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},
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
