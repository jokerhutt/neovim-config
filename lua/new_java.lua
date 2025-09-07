local M = {}
local KINDS = { "class", "interface", "enum", "record" }

local function template(kind, name, pkg)
  local header = pkg and ("package " .. pkg .. ";\n\n") or ""
  local body = ({
    class     = "public class %s { }\n",
    interface = "public interface %s { }\n",
    enum      = "public enum %s { ; }\n",
    record    = "public record %s() { }\n",
  })[kind]:format(name)
  return header .. body
end

function M.project_root()
  local bufdir = vim.fn.expand("%:p:h")
  if bufdir ~= "" and vim.fn.isdirectory(bufdir) == 1 then return bufdir end
  return vim.fn.getcwd()
end

function M.new_java()
  vim.ui.select(KINDS, { prompt = "Java kind:" }, function(kind)
    if not kind then return end

    vim.ui.input({ prompt = "File name (pkg.Class or Class):" }, function(input)
      if not input or input == "" then return end

      local pkg, cls = input:match("^(.*)%.([%w_]+)$")
      local name = cls or input

      local dir = M.project_root()
      if pkg and #pkg > 0 then
        dir = dir .. "/" .. pkg:gsub("%.", "/")
        vim.fn.mkdir(dir, "p")
      end

      local path = string.format("%s/%s.java", dir, name)

      if vim.fn.filereadable(path) == 1 then
        vim.cmd.edit(path)
        vim.notify("Opened existing: " .. path, vim.log.levels.INFO)
        return
      end

      vim.cmd.edit(path)
      local lines = vim.split(template(kind, name, pkg), "\n", { plain = true })
      vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
      vim.cmd.write()
      vim.notify("Created: " .. path, vim.log.levels.INFO)
    end)
  end)
end

return M
