-- This file needs to have same structure as nvconfig.lua 
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :( 

---@type ChadrcConfig
local M = {}

local function read_ambxst_palette()
  local path = vim.fn.expand "~/.cache/ambxst/colors.json"
  if vim.fn.filereadable(path) == 0 then
    return nil
  end

  local ok, palette = pcall(vim.json.decode, table.concat(vim.fn.readfile(path), "\n"))
  return ok and type(palette) == "table" and palette or nil
end

local function ambxst_theme()
  local p = read_ambxst_palette() or {}
  local get = function(name, fallback)
    return p[name] or fallback
  end

  local base_30 = {
    white = get("overBackground", "#f1dfdb"),
    darker_black = get("surfaceContainerLowest", "#140c0b"),
    black = get("background", "#120c0b"),
    black2 = get("surfaceContainerLow", "#231918"),
    one_bg = get("surfaceContainer", "#271d1c"),
    one_bg2 = get("surfaceContainerHigh", "#322826"),
    one_bg3 = get("surfaceContainerHighest", "#3d3230"),
    grey = get("outline", "#a08c89"),
    grey_fg = get("surfaceVariant", "#534340"),
    grey_fg2 = get("outlineVariant", "#534340"),
    light_grey = get("overSurfaceVariant", "#d8c2be"),
    red = get("error", "#ffb4ab"),
    baby_pink = get("lightRed", "#ffcac1"),
    pink = get("magenta", "#fcb0d5"),
    line = get("outlineVariant", "#534340"),
    green = get("green", "#b7d085"),
    vibrant_green = get("lightGreen", "#c2d797"),
    nord_blue = get("lightBlue", "#e1d6fe"),
    blue = get("blue", "#cebdfe"),
    yellow = get("yellow", "#dec56e"),
    sun = get("lightYellow", "#e3cd83"),
    purple = get("magenta", "#fcb0d5"),
    dark_purple = get("magentaContainer", "#6c3353"),
    teal = get("cyan", "#84d5c4"),
    orange = get("tertiary", "#ddc48c"),
    cyan = get("cyan", "#84d5c4"),
    statusline_bg = get("surfaceContainer", "#271d1c"),
    lightbg = get("surfaceContainerHigh", "#322826"),
    pmenu_bg = get("primaryContainer", "#73342a"),
    folder_bg = get("blue", "#cebdfe"),
    lavender = get("lightBlue", "#e1d6fe"),
  }

  return {
    base_30 = base_30,
    base_16 = {
      base00 = get("background", "#120c0b"),
      base01 = get("surfaceContainerLow", "#231918"),
      base02 = get("surfaceContainer", "#271d1c"),
      base03 = get("outlineVariant", "#534340"),
      base04 = get("outline", "#a08c89"),
      base05 = get("overSurfaceVariant", "#d8c2be"),
      base06 = get("overSurface", "#f1dfdb"),
      base07 = get("overBackground", "#f1dfdb"),
      base08 = get("error", "#ffb4ab"),
      base09 = get("tertiary", "#ddc48c"),
      base0A = get("yellow", "#dec56e"),
      base0B = get("green", "#b7d085"),
      base0C = get("cyan", "#84d5c4"),
      base0D = get("blue", "#cebdfe"),
      base0E = get("magenta", "#fcb0d5"),
      base0F = get("primary", "#ffb4a7"),
    },
  }
end

M.base46 = {
	theme = "catppuccin",
	changed_themes = { catppuccin = ambxst_theme() },

	-- hl_override = {
	-- 	Comment = { italic = true },
	-- 	["@comment"] = { italic = true },
	-- },
}

M.ui = {
  -- Compact VS Code-like sections: mode, file, git/LSP info, and position.
  statusline = {
    enabled = true,
    theme = "default",
    separator_style = "round",
  },
}

-- Called by the Ambxst colors.json watcher after a wallpaper changes.
_G.reload_ambxst_theme = function()
  local ok, theme = pcall(ambxst_theme)
  if not ok then return end

  local ok_config, nvconfig = pcall(require, "nvconfig")
  if not ok_config then return end

  nvconfig.base46.changed_themes = nvconfig.base46.changed_themes or {}
  nvconfig.base46.changed_themes.catppuccin = theme
  package.loaded["base46.themes.catppuccin"] = nil

  local ok_base46, base46 = pcall(require, "base46")
  if ok_base46 then
    base46.load_all_highlights()
  end
end

-- M.nvdash = { load_on_startup = true }
-- M.ui = {
--       tabufline = {
--          lazyload = false
--      }
-- }

return M
