local config = require "config"
local custom = config.lualine
local utils = require "core.utils"

local get_theme = function(custom_theme)
  local themes = require "plugins.lualine.themes"

  if utils.contains_key(custom_theme, themes) then
    return themes[custom_theme]
  end

  return "tokyonight"
end

local components = require "plugins.lualine.components"

return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  enabled = function()
    if config.zen_mode then
      return false
    end
    return true
  end,
  opts = {
    options = {
      icons_enabled = true,
      theme = get_theme(custom.theme),
      component_separators = "",
      section_separators = { left = "", right = "" },
      disabled_filetypes = { "dashboard", "NvimTree", "Outline" },
      always_divide_middle = true,
    },
    sections = {
      lualine_a = { components.mode },
      lualine_b = { components.fileInfo },
      lualine_c = { components.git },
      -- lualine_x = { "encoding", "fileformat", "filetype" },
      lualine_x = { components.diagnostics },
      lualine_y = { components.filetype },
      lualine_z = { components.cursor_position },
    },
    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = {},
      lualine_x = {},
      lualine_y = {},
      lualine_z = {},
    },
    tabline = {},
    extensions = {},
  },
}
