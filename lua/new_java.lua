local M = {}
local KINDS = { "class", "interface", "enum", "record" }

-- set your source root(s) here
local SRC_ROOTS = { "src/main/java", "src" }

local function detect_package(dir)
	-- find the nearest matching source root
	for _, root in ipairs(SRC_ROOTS) do
		local idx = dir:find(root, 1, true)
		if idx then
			local rel = dir:sub(idx + #root + 1) -- skip root + '/'
			return rel:gsub("/", ".") -- replace slashes with dots
		end
	end
	return nil
end

local function template(kind, name, pkg)
	local header = pkg and ("package " .. pkg .. ";\n\n") or ""
	local body = ({
		class = [[public class %s {
    
}]],
		interface = [[public interface %s {
    
}]],
		enum = [[public enum %s {
    
}]],
		record = [[public record %s() {
    
}]],
	})[kind]:format(name)
	return header .. body
end

local function dir_from_tree()
	local ok, api = pcall(require, "nvim-tree.api")
	if not ok then
		return nil
	end
	local node = api.tree.get_node_under_cursor()
	if not node then
		return nil
	end
	if node.type == "directory" then
		return node.absolute_path
	elseif node.type == "file" then
		return vim.fn.fnamemodify(node.absolute_path, ":h")
	end
end

function M.project_root()
	local bufdir = vim.fn.expand("%:p:h")
	if bufdir ~= "" and vim.fn.isdirectory(bufdir) == 1 then
		return bufdir
	end
	return vim.fn.getcwd()
end

function M.new_java()
	vim.ui.select(KINDS, { prompt = "Java kind:" }, function(kind)
		if not kind then
			return
		end

		vim.ui.input({ prompt = "File name (ClassName only):" }, function(input)
			if not input or input == "" then
				return
			end

			local name = input
			local base = dir_from_tree() or M.project_root()
			local dir = base

			vim.fn.mkdir(dir, "p")
			local path = string.format("%s/%s.java", dir, name)

			-- auto-detect package name
			local pkg = detect_package(dir)

			if vim.fn.filereadable(path) == 1 then
				vim.cmd.edit(path)
				vim.notify("Opened existing: " .. path, vim.log.levels.INFO)
				return
			end

			vim.cmd.edit(path)
			local lines = vim.split(template(kind, name, pkg), "\n", { plain = true })
			vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
			vim.cmd.write()
			vim.notify(("Created: %s"):format(path), vim.log.levels.INFO)
		end)
	end)
end

return M
