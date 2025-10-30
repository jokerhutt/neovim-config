local cmp = require("cmp")

cmp.setup({
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end,
	},
	mapping = cmp.mapping.preset.insert({
		["<C-Space>"] = cmp.mapping.complete(), -- trigger completion
		["<CR>"] = cmp.mapping.confirm({ select = true }), -- confirm selection
		["<Tab>"] = cmp.mapping.select_next_item(), -- tab to next suggestion
		["<S-Tab>"] = cmp.mapping.select_prev_item(), -- shift-tab to previous
	}),
	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
		{ name = "buffer" },
		{ name = "path" },
	}),
})
