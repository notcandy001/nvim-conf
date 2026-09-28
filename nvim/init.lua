vim.g.base46_cache = vim.fn.stdpath "data" .. "/base46/"
vim.g.mapleader = " "

-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.rtp:prepend(lazypath)

local lazy_config = require "configs.lazy"

-- load plugins
require("lazy").setup({
  {
    "NvChad/NvChad",
    lazy = false,
    branch = "v2.5",
    import = "nvchad.plugins",
  },

   
   ---terminal-blur
   {
   "typicode/bg.nvim", 
   lazy = false,
   },


  { import = "plugins" },
}, lazy_config)

-- load theme; Base46's generated cache may not exist after a fresh install or
-- when the wallpaper-theme generator has not run yet.
local ok_base46, base46 = pcall(require, "base46")
if ok_base46 then
  local defaults_cache = vim.g.base46_cache .. "defaults"
  local statusline_cache = vim.g.base46_cache .. "statusline"

  -- Compile on every startup so the current Ambxst wallpaper is applied even
  -- when the cache files already exist from a previous wallpaper.
  pcall(base46.compile)

  if vim.fn.filereadable(defaults_cache) == 1 then
    dofile(defaults_cache)
  end
  if vim.fn.filereadable(statusline_cache) == 1 then
    dofile(statusline_cache)
  end
end

require "options"
require "autocmds"

vim.schedule(function()
  require "mappings"
end)

vim.opt.termguicolors = true


local autocmd = vim.api.nvim_create_autocmd

autocmd("Signal", {
  pattern = "SIGUSR1",
  callback = function()
    if _G.reload_ambxst_theme then
      _G.reload_ambxst_theme()
    end
    require('nvchad.utils').reload()
  end
})
