local M = {}

function M.create_make_file()
	local ok, manager = pcall(require, "neo-tree.sources.manager")
	if not ok then
		print("Neo-tree not available")
		return
	end

	local state = manager.get_state("filesystem")
	if not state or not state.tree then
		print("No Neo-tree state")
		return
	end

	local node = state.tree:get_node()
	if not node or not node.path then
		print("No file selected")
		return
	end

	local path = node.path
	local filename = vim.fn.fnamemodify(path, ":t") -- loops.c
	local name = vim.fn.fnamemodify(path, ":t:r") -- loops
	local dir = vim.fn.fnamemodify(path, ":h") -- directory

	local content = string.format(
		[[
run:
	gcc %s -o %s && ./%s
]],
		filename,
		name,
		name
	)

	local makefile_path = dir .. "/Makefile"

	if vim.fn.filereadable(makefile_path) == 1 then
		print("Makefile already exists in " .. dir)
		return
	end

	local f = io.open(makefile_path, "w")
	if f then
		f:write(content)
		f:close()
		print("Makefile created for " .. filename)
	else
		print("Failed to create Makefile")
	end
end

return M
