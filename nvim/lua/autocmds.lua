require "nvchad.autocmds"
-- Reload NvChad colors when matugen/chadwal updates base46 file
vim.o.autoread = true

vim.api.nvim_create_autocmd({ "BufWritePost", "FileChangedShellPost" }, {
  pattern = "base46-dark.lua",
  callback = function()
    vim.schedule(function()
      package.loaded["base46"] = nil
      require("base46").load_all_highlights()
      vim.notify("🎨 base46 reloaded from matugen", vim.log.levels.INFO)
    end)
  end,
})

-- Ambxst replaces ~/.cache/ambxst/colors.json whenever a new wallpaper is
-- loaded. Recompile NvChad/Base46 from that palette without restarting Nvim.
local uv = vim.uv or vim.loop
local ambxst_dir = vim.fn.expand "~/.cache/ambxst"
local ambxst_timer = uv.new_timer()
local ambxst_watcher = uv.new_fs_event()

if ambxst_watcher and vim.fn.isdirectory(ambxst_dir) == 1 then
  ambxst_watcher:start(ambxst_dir, {}, vim.schedule_wrap(function(err, filename)
    if not err and filename == "colors.json" and _G.reload_ambxst_theme then
      ambxst_timer:stop()
      ambxst_timer:start(150, 0, vim.schedule_wrap(_G.reload_ambxst_theme))
    end
  end))
end
