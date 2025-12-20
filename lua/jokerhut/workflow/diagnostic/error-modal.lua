local function open_diagnostics_modal(opts)
	opts = opts or {}
	local bufnr = opts.bufnr

	local diags = vim.diagnostic.get(bufnr)
	if vim.tbl_isempty(diags) then
		vim.notify("No diagnostics 🎉", vim.log.levels.INFO)
		return
	end

	local lines = {}
	for i, d in ipairs(diags) do
		local fname = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(d.bufnr), ":~:.")
		lines[i] = string.format("%s:%d:%d  %s", fname, d.lnum + 1, d.col + 1, d.message:gsub("\n", " "))
	end

	local preview_ns = vim.api.nvim_create_namespace("snacks_diag_preview")

	Snacks.win({
		title = "Diagnostics",
		border = "rounded",
		width = 0.75,
		height = 0.6,
		ft = "diagnostics",
		keys = {
			q = "close",

			["<CR>"] = function(win)
				local idx = vim.api.nvim_win_get_cursor(win.win)[1]
				local d = diags[idx]
				if not d then
					return
				end

				vim.api.nvim_set_current_buf(d.bufnr)
				vim.api.nvim_win_set_cursor(0, { d.lnum + 1, d.col })
				vim.cmd("normal! zz")
				win:close()
			end,
		},

		on_buf = function(win)
			vim.api.nvim_buf_set_lines(win.buf, 0, -1, false, lines)

			-- live preview on cursor move
			vim.api.nvim_create_autocmd("CursorMoved", {
				buffer = win.buf,
				callback = function()
					local idx = vim.api.nvim_win_get_cursor(win.win)[1]
					local d = diags[idx]
					if not d then
						return
					end

					vim.api.nvim_buf_clear_namespace(d.bufnr, preview_ns, 0, -1)

					vim.api.nvim_buf_add_highlight(d.bufnr, preview_ns, "Visual", d.lnum, 0, -1)

					vim.api.nvim_set_current_buf(d.bufnr)
					vim.api.nvim_win_set_cursor(0, { d.lnum + 1, d.col })
				end,
			})
		end,
	})
end

vim.keymap.set("n", "<leader>de", function()
	open_diagnostics_modal() -- project-wide
end, { desc = "Diagnostics (project)" })

vim.keymap.set("n", "<leader>db", function()
	open_diagnostics_modal({ bufnr = 0 }) -- buffer only
end, { desc = "Diagnostics (buffer)" })
