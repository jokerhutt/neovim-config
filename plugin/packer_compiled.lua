-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

_G._packer = _G._packer or {}
_G._packer.inside_compile = true

local time
local profile_info
local should_profile = false
if should_profile then
  local hrtime = vim.loop.hrtime
  profile_info = {}
  time = function(chunk, start)
    if start then
      profile_info[chunk] = hrtime()
    else
      profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
    end
  end
else
  time = function(chunk, start) end
end

local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end
  if threshold then
    table.insert(results, '(Only showing plugins that took longer than ' .. threshold .. ' ms ' .. 'to load)')
  end

  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "/Users/davidglogowski/.cache/nvim/packer_hererocks/2.1.1753364724/share/lua/5.1/?.lua;/Users/davidglogowski/.cache/nvim/packer_hererocks/2.1.1753364724/share/lua/5.1/?/init.lua;/Users/davidglogowski/.cache/nvim/packer_hererocks/2.1.1753364724/lib/luarocks/rocks-5.1/?.lua;/Users/davidglogowski/.cache/nvim/packer_hererocks/2.1.1753364724/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/Users/davidglogowski/.cache/nvim/packer_hererocks/2.1.1753364724/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s), name, _G.packer_plugins[name])
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  LuaSnip = {
    loaded = true,
    path = "/Users/davidglogowski/.local/share/nvim/site/pack/packer/start/LuaSnip",
    url = "https://github.com/L3MON4D3/LuaSnip"
  },
  ["alpha-nvim"] = {
    loaded = true,
    path = "/Users/davidglogowski/.local/share/nvim/site/pack/packer/start/alpha-nvim",
    url = "https://github.com/goolord/alpha-nvim"
  },
  ["ascii.nvim"] = {
    loaded = true,
    path = "/Users/davidglogowski/.local/share/nvim/site/pack/packer/start/ascii.nvim",
    url = "https://github.com/MaximilianLloyd/ascii.nvim"
  },
  catppuccin = {
    loaded = true,
    path = "/Users/davidglogowski/.local/share/nvim/site/pack/packer/start/catppuccin",
    url = "https://github.com/catppuccin/nvim"
  },
  ["cmp-buffer"] = {
    loaded = true,
    path = "/Users/davidglogowski/.local/share/nvim/site/pack/packer/start/cmp-buffer",
    url = "https://github.com/hrsh7th/cmp-buffer"
  },
  ["cmp-cmdline"] = {
    loaded = true,
    path = "/Users/davidglogowski/.local/share/nvim/site/pack/packer/start/cmp-cmdline",
    url = "https://github.com/hrsh7th/cmp-cmdline"
  },
  ["cmp-nvim-lsp"] = {
    loaded = true,
    path = "/Users/davidglogowski/.local/share/nvim/site/pack/packer/start/cmp-nvim-lsp",
    url = "https://github.com/hrsh7th/cmp-nvim-lsp"
  },
  ["cmp-path"] = {
    loaded = true,
    path = "/Users/davidglogowski/.local/share/nvim/site/pack/packer/start/cmp-path",
    url = "https://github.com/hrsh7th/cmp-path"
  },
  cmp_luasnip = {
    loaded = true,
    path = "/Users/davidglogowski/.local/share/nvim/site/pack/packer/start/cmp_luasnip",
    url = "https://github.com/saadparwaiz1/cmp_luasnip"
  },
  ["compiler.nvim"] = {
    commands = { "CompilerOpen", "CompilerToggleResults", "CompilerRedo", "CompilerStop" },
    config = { "\27LJ\2\nv\0\0\5\1\4\0\17-\0\0\0009\0\0\0005\2\1\0B\0\2\2\21\1\0\0)\2\0\0\1\2\1\0X\1\a€-\1\0\0009\1\2\1:\3\1\0'\4\3\0B\1\3\1+\1\2\0L\1\2\0+\1\1\0L\1\2\0\0À\frestart\15run_action\1\0\1\vunique\2\15list_tasks%\0\0\2\1\0\0\a-\0\0\0B\0\1\2\15\0\0\0X\1\2€+\0\1\0L\0\2\0K\0\1\0\1À›\1\1\0\a\0\n\0\0166\0\0\0'\2\1\0B\0\2\0023\1\2\0006\2\0\0'\4\3\0B\2\2\0029\2\4\0025\4\b\0005\5\6\0003\6\5\0=\6\a\5=\5\t\4B\2\2\0012\0\0€K\0\1\0\nhooks\1\0\1\nhooks\0\19before_compile\1\0\1\19before_compile\0\0\nsetup\rcompiler\0\roverseer\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/davidglogowski/.local/share/nvim/site/pack/packer/opt/compiler.nvim",
    url = "https://github.com/Zeioth/compiler.nvim"
  },
  dracula = {
    loaded = true,
    path = "/Users/davidglogowski/.local/share/nvim/site/pack/packer/start/dracula",
    url = "https://github.com/Mofiqul/dracula.nvim"
  },
  ["dressing.nvim"] = {
    config = { "\27LJ\2\n÷\1\0\0\5\0\f\0\0156\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\b\0005\3\4\0005\4\3\0=\4\5\0035\4\6\0=\4\a\3=\3\t\0025\3\n\0=\3\v\2B\0\2\1K\0\1\0\ninput\1\0\3\17prefer_width\0032\rrelative\veditor\16insert_only\1\vselect\1\0\2\ninput\0\vselect\0\fbuiltin\1\0\1\20start_in_insert\1\fbackend\1\0\2\fbackend\0\fbuiltin\0\1\3\0\0\14telescope\fbuiltin\nsetup\rdressing\frequire\0" },
    loaded = true,
    path = "/Users/davidglogowski/.local/share/nvim/site/pack/packer/start/dressing.nvim",
    url = "https://github.com/stevearc/dressing.nvim"
  },
  ["edgy.nvim"] = {
    loaded = true,
    path = "/Users/davidglogowski/.local/share/nvim/site/pack/packer/start/edgy.nvim",
    url = "https://github.com/folke/edgy.nvim"
  },
  github = {
    loaded = true,
    path = "/Users/davidglogowski/.local/share/nvim/site/pack/packer/start/github",
    url = "https://github.com/projekt0n/github-nvim-theme"
  },
  harpoon = {
    loaded = true,
    path = "/Users/davidglogowski/.local/share/nvim/site/pack/packer/start/harpoon",
    url = "https://github.com/ThePrimeagen/harpoon"
  },
  ["lazygit.nvim"] = {
    loaded = true,
    path = "/Users/davidglogowski/.local/share/nvim/site/pack/packer/start/lazygit.nvim",
    url = "https://github.com/kdheepak/lazygit.nvim"
  },
  ["leetcode.nvim"] = {
    config = { "\27LJ\2\n\v\0\0\1\0\0\0\1K\0\1\0\0" },
    loaded = true,
    path = "/Users/davidglogowski/.local/share/nvim/site/pack/packer/start/leetcode.nvim",
    url = "https://github.com/kawre/leetcode.nvim"
  },
  ["lualine.nvim"] = {
    loaded = true,
    path = "/Users/davidglogowski/.local/share/nvim/site/pack/packer/start/lualine.nvim",
    url = "https://github.com/nvim-lualine/lualine.nvim"
  },
  ["markview.nvim"] = {
    loaded = true,
    path = "/Users/davidglogowski/.local/share/nvim/site/pack/packer/start/markview.nvim",
    url = "https://github.com/OXY2DEV/markview.nvim"
  },
  ["mason-lspconfig.nvim"] = {
    loaded = true,
    path = "/Users/davidglogowski/.local/share/nvim/site/pack/packer/start/mason-lspconfig.nvim",
    url = "https://github.com/williamboman/mason-lspconfig.nvim"
  },
  ["mason-tool-installer.nvim"] = {
    loaded = true,
    path = "/Users/davidglogowski/.local/share/nvim/site/pack/packer/start/mason-tool-installer.nvim",
    url = "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim"
  },
  ["mason.nvim"] = {
    loaded = true,
    path = "/Users/davidglogowski/.local/share/nvim/site/pack/packer/start/mason.nvim",
    url = "https://github.com/williamboman/mason.nvim"
  },
  ["neo-tree.nvim"] = {
    loaded = true,
    path = "/Users/davidglogowski/.local/share/nvim/site/pack/packer/start/neo-tree.nvim",
    url = "https://github.com/nvim-neo-tree/neo-tree.nvim"
  },
  ["none-ls-extras.nvim"] = {
    loaded = true,
    path = "/Users/davidglogowski/.local/share/nvim/site/pack/packer/start/none-ls-extras.nvim",
    url = "https://github.com/nvimtools/none-ls-extras.nvim"
  },
  ["none-ls-shellcheck.nvim"] = {
    loaded = true,
    path = "/Users/davidglogowski/.local/share/nvim/site/pack/packer/start/none-ls-shellcheck.nvim",
    url = "https://github.com/gbprod/none-ls-shellcheck.nvim"
  },
  ["none-ls.nvim"] = {
    loaded = true,
    path = "/Users/davidglogowski/.local/share/nvim/site/pack/packer/start/none-ls.nvim",
    url = "https://github.com/nvimtools/none-ls.nvim"
  },
  nordic = {
    loaded = true,
    path = "/Users/davidglogowski/.local/share/nvim/site/pack/packer/start/nordic",
    url = "https://github.com/AlexvZyl/nordic.nvim"
  },
  ["nui.nvim"] = {
    loaded = true,
    path = "/Users/davidglogowski/.local/share/nvim/site/pack/packer/start/nui.nvim",
    url = "https://github.com/MunifTanjim/nui.nvim"
  },
  ["nvim-autopairs"] = {
    config = { "\27LJ\2\n@\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\19nvim-autopairs\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/davidglogowski/.local/share/nvim/site/pack/packer/opt/nvim-autopairs",
    url = "https://github.com/windwp/nvim-autopairs"
  },
  ["nvim-cmp"] = {
    loaded = true,
    path = "/Users/davidglogowski/.local/share/nvim/site/pack/packer/start/nvim-cmp",
    url = "https://github.com/hrsh7th/nvim-cmp"
  },
  ["nvim-lspconfig"] = {
    loaded = true,
    path = "/Users/davidglogowski/.local/share/nvim/site/pack/packer/start/nvim-lspconfig",
    url = "https://github.com/neovim/nvim-lspconfig"
  },
  ["nvim-treesitter"] = {
    loaded = true,
    path = "/Users/davidglogowski/.local/share/nvim/site/pack/packer/start/nvim-treesitter",
    url = "https://github.com/nvim-treesitter/nvim-treesitter"
  },
  ["nvim-web-devicons"] = {
    loaded = true,
    path = "/Users/davidglogowski/.local/share/nvim/site/pack/packer/start/nvim-web-devicons",
    url = "https://github.com/nvim-tree/nvim-web-devicons"
  },
  ["overseer.nvim"] = {
    config = { "\27LJ\2\nš\1\0\0\4\0\6\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\2B\0\2\1K\0\1\0\rstrategy\1\0\1\rstrategy\0\1\2\3\0\15toggleterm\18close_on_exit\1\18open_on_start\2\14direction\15horizontal\nsetup\roverseer\frequire\0" },
    loaded = true,
    path = "/Users/davidglogowski/.local/share/nvim/site/pack/packer/start/overseer.nvim",
    url = "https://github.com/stevearc/overseer.nvim"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/Users/davidglogowski/.local/share/nvim/site/pack/packer/start/packer.nvim",
    url = "https://github.com/wbthomason/packer.nvim"
  },
  playground = {
    loaded = true,
    path = "/Users/davidglogowski/.local/share/nvim/site/pack/packer/start/playground",
    url = "https://github.com/nvim-treesitter/playground"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/Users/davidglogowski/.local/share/nvim/site/pack/packer/start/plenary.nvim",
    url = "https://github.com/nvim-lua/plenary.nvim"
  },
  ["rose-pine"] = {
    loaded = true,
    path = "/Users/davidglogowski/.local/share/nvim/site/pack/packer/start/rose-pine",
    url = "https://github.com/rose-pine/neovim"
  },
  ["telescope.nvim"] = {
    loaded = true,
    path = "/Users/davidglogowski/.local/share/nvim/site/pack/packer/start/telescope.nvim",
    url = "https://github.com/nvim-telescope/telescope.nvim"
  },
  ["toggleterm.nvim"] = {
    config = { "\27LJ\2\nT\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\1\14direction\15horizontal\nsetup\15toggleterm\frequire\0" },
    loaded = true,
    path = "/Users/davidglogowski/.local/share/nvim/site/pack/packer/start/toggleterm.nvim",
    url = "https://github.com/akinsho/toggleterm.nvim"
  },
  undotree = {
    loaded = true,
    path = "/Users/davidglogowski/.local/share/nvim/site/pack/packer/start/undotree",
    url = "https://github.com/mbbill/undotree"
  },
  ["vim-be-good"] = {
    loaded = true,
    path = "/Users/davidglogowski/.local/share/nvim/site/pack/packer/start/vim-be-good",
    url = "https://github.com/ThePrimeagen/vim-be-good"
  },
  ["vim-fugitive"] = {
    loaded = true,
    path = "/Users/davidglogowski/.local/share/nvim/site/pack/packer/start/vim-fugitive",
    url = "https://github.com/tpope/vim-fugitive"
  },
  ["vim-wakatime"] = {
    loaded = true,
    path = "/Users/davidglogowski/.local/share/nvim/site/pack/packer/start/vim-wakatime",
    url = "https://github.com/wakatime/vim-wakatime"
  },
  xcode = {
    loaded = true,
    path = "/Users/davidglogowski/.local/share/nvim/site/pack/packer/start/xcode",
    url = "https://github.com/arzg/vim-colors-xcode"
  }
}

time([[Defining packer_plugins]], false)
-- Config for: toggleterm.nvim
time([[Config for toggleterm.nvim]], true)
try_loadstring("\27LJ\2\nT\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\1\14direction\15horizontal\nsetup\15toggleterm\frequire\0", "config", "toggleterm.nvim")
time([[Config for toggleterm.nvim]], false)
-- Config for: overseer.nvim
time([[Config for overseer.nvim]], true)
try_loadstring("\27LJ\2\nš\1\0\0\4\0\6\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\2B\0\2\1K\0\1\0\rstrategy\1\0\1\rstrategy\0\1\2\3\0\15toggleterm\18close_on_exit\1\18open_on_start\2\14direction\15horizontal\nsetup\roverseer\frequire\0", "config", "overseer.nvim")
time([[Config for overseer.nvim]], false)
-- Config for: leetcode.nvim
time([[Config for leetcode.nvim]], true)
try_loadstring("\27LJ\2\n\v\0\0\1\0\0\0\1K\0\1\0\0", "config", "leetcode.nvim")
time([[Config for leetcode.nvim]], false)
-- Config for: dressing.nvim
time([[Config for dressing.nvim]], true)
try_loadstring("\27LJ\2\n÷\1\0\0\5\0\f\0\0156\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\b\0005\3\4\0005\4\3\0=\4\5\0035\4\6\0=\4\a\3=\3\t\0025\3\n\0=\3\v\2B\0\2\1K\0\1\0\ninput\1\0\3\17prefer_width\0032\rrelative\veditor\16insert_only\1\vselect\1\0\2\ninput\0\vselect\0\fbuiltin\1\0\1\20start_in_insert\1\fbackend\1\0\2\fbackend\0\fbuiltin\0\1\3\0\0\14telescope\fbuiltin\nsetup\rdressing\frequire\0", "config", "dressing.nvim")
time([[Config for dressing.nvim]], false)

-- Command lazy-loads
time([[Defining lazy-load commands]], true)
pcall(vim.api.nvim_create_user_command, 'CompilerStop', function(cmdargs)
          require('packer.load')({'compiler.nvim'}, { cmd = 'CompilerStop', l1 = cmdargs.line1, l2 = cmdargs.line2, bang = cmdargs.bang, args = cmdargs.args, mods = cmdargs.mods }, _G.packer_plugins)
        end,
        {nargs = '*', range = true, bang = true, complete = function()
          require('packer.load')({'compiler.nvim'}, {}, _G.packer_plugins)
          return vim.fn.getcompletion('CompilerStop ', 'cmdline')
      end})
pcall(vim.api.nvim_create_user_command, 'CompilerOpen', function(cmdargs)
          require('packer.load')({'compiler.nvim'}, { cmd = 'CompilerOpen', l1 = cmdargs.line1, l2 = cmdargs.line2, bang = cmdargs.bang, args = cmdargs.args, mods = cmdargs.mods }, _G.packer_plugins)
        end,
        {nargs = '*', range = true, bang = true, complete = function()
          require('packer.load')({'compiler.nvim'}, {}, _G.packer_plugins)
          return vim.fn.getcompletion('CompilerOpen ', 'cmdline')
      end})
pcall(vim.api.nvim_create_user_command, 'CompilerToggleResults', function(cmdargs)
          require('packer.load')({'compiler.nvim'}, { cmd = 'CompilerToggleResults', l1 = cmdargs.line1, l2 = cmdargs.line2, bang = cmdargs.bang, args = cmdargs.args, mods = cmdargs.mods }, _G.packer_plugins)
        end,
        {nargs = '*', range = true, bang = true, complete = function()
          require('packer.load')({'compiler.nvim'}, {}, _G.packer_plugins)
          return vim.fn.getcompletion('CompilerToggleResults ', 'cmdline')
      end})
pcall(vim.api.nvim_create_user_command, 'CompilerRedo', function(cmdargs)
          require('packer.load')({'compiler.nvim'}, { cmd = 'CompilerRedo', l1 = cmdargs.line1, l2 = cmdargs.line2, bang = cmdargs.bang, args = cmdargs.args, mods = cmdargs.mods }, _G.packer_plugins)
        end,
        {nargs = '*', range = true, bang = true, complete = function()
          require('packer.load')({'compiler.nvim'}, {}, _G.packer_plugins)
          return vim.fn.getcompletion('CompilerRedo ', 'cmdline')
      end})
time([[Defining lazy-load commands]], false)

vim.cmd [[augroup packer_load_aucmds]]
vim.cmd [[au!]]
  -- Event lazy-loads
time([[Defining lazy-load event autocommands]], true)
vim.cmd [[au InsertEnter * ++once lua require("packer.load")({'nvim-autopairs'}, { event = "InsertEnter *" }, _G.packer_plugins)]]
time([[Defining lazy-load event autocommands]], false)
vim.cmd("augroup END")

_G._packer.inside_compile = false
if _G._packer.needs_bufread == true then
  vim.cmd("doautocmd BufRead")
end
_G._packer.needs_bufread = false

if should_profile then save_profiles() end

end)

if not no_errors then
  error_msg = error_msg:gsub('"', '\\"')
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
