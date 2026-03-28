local M = {}

local last_normal_win = nil

vim.api.nvim_create_autocmd("WinEnter", {
  callback = function()
    if vim.bo.filetype ~= "neo-tree" then
      last_normal_win = vim.api.nvim_get_current_win()
    end
  end,
})

function M.toggle()
  local nt_win = nil

  for _, win in ipairs(vim.api.nvim_list_wins()) do
    local ft = vim.bo[vim.api.nvim_win_get_buf(win)].filetype
    if ft == "neo-tree" then
      nt_win = win
      break
    end
  end

  if not nt_win then
    vim.cmd("Neotree show filesystem left")
    return
  end

  if vim.api.nvim_get_current_win() == nt_win then
    if last_normal_win and vim.api.nvim_win_is_valid(last_normal_win) then
      vim.api.nvim_set_current_win(last_normal_win)
    else
      vim.cmd("wincmd p")
    end
  else
    vim.api.nvim_set_current_win(nt_win)
  end
end

return M
