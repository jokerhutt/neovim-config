local ok_mason, mason = pcall(require, "mason")
if ok_mason then
	mason.setup()
end

local ok_bridge, mason_null_ls = pcall(require, "mason-null-ls")
if ok_bridge then
	mason_null_ls.setup({
		ensure_installed = {
			"prettier", -- JS/TS/CSS/HTML/JSON/YAML/Markdown
			"stylua", -- Lua
			"google-java-format", -- Java
			"autopep8", -- Python,
			"shellcheck",
			"shfmt",
			"clang-format",
			"cppcheck",
			"cpplint",
		},
		automatic_installation = true,
	})
end

local null_ls = require("null-ls")

-- register the formatters
null_ls.setup({
	sources = {
		-- Web
		null_ls.builtins.formatting.prettier,
		-- Lua
		null_ls.builtins.formatting.stylua,
		-- Java
		null_ls.builtins.formatting.google_java_format,
		-- Python
		null_ls.builtins.formatting.autopep8,
		null_ls.builtins.diagnostics.shellcheck, -- lints .sh / bash
		null_ls.builtins.formatting.shfmt.with({ -- formats shell scripts
			extra_args = { "-i", "4", "-ci" }, -- 4-space indent, indent switch cases
		}),
	},

	-- PEREFER NULL LS WHEN FORMATTING
	on_attach = function(client, bufnr)
		if client.supports_method("textDocument/formatting") then
			-- <leader>f to format current buffer with null-ls
			vim.keymap.set("n", "<leader>f", function()
				vim.lsp.buf.format({
					bufnr = bufnr,
					filter = function(c)
						return c.name == "null-ls"
					end,
				})
			end, { buffer = bufnr, desc = "Format buffer" })

			-- FORMAT ON SAVE OPTION
			local grp = vim.api.nvim_create_augroup("FormatOnSave", { clear = false })
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = grp,
				buffer = bufnr,
				callback = function()
					vim.lsp.buf.format({
						bufnr = bufnr,
						filter = function(c)
							return c.name == "null-ls"
						end,
					})
				end,
			})
		end
	end,
})
