local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
  return
end

local colors = require("plugins.lualine.themes").darkMode

-- Customized table or one of the available themes of lualine
local preferred_theme = {
  normal = {
    a = { fg = colors.black, bg = colors.nord_blue },
    b = { fg = colors.white, bg = colors.lightbg },
    c = { fg = colors.grey_fg2, bg = colors.statusline_bg },

    x = { fg = colors.nord_blue, bg = colors.statusline_bg },
    y = { fg = colors.white, bg = colors.lightbg },
    z = { fg = colors.black, bg = colors.nord_blue },
  },
  insert = { a = { fg = colors.black, bg = colors.green } },
  visual = { a = { fg = colors.black, bg = colors.orange } },
  terminal = { a = { fg = colors.black, bg = colors.dark_purple } },
  replace = { a = { fg = colors.black, bg = colors.green } },
}

local components = require "plugins.lualine.components"

lualine.setup {
  options = {
    icons_enabled = true,
    theme = preferred_theme,
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
}
