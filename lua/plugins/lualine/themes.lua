local M = {}

local tokyonight_night_colors = {
  white = "#abb2bf",
  black = "#1e222a",
  grey = "#6f737b",
  green = "#98c379",
  blue = "#81A1C1",
  purple = "#c882e7",
  orange = "#fca2aa",
  statusline_bg = "#22262e",
  lightbg = "#2d3139",
}

M.tokyonight_night = {
  normal = {
    a = { fg = tokyonight_night_colors.black, bg = tokyonight_night_colors.blue },
    b = { fg = tokyonight_night_colors.white, bg = tokyonight_night_colors.lightbg },
    c = { fg = tokyonight_night_colors.grey, bg = tokyonight_night_colors.statusline_bg },

    x = { fg = tokyonight_night_colors.blue, bg = tokyonight_night_colors.statusline_bg },
    y = { fg = tokyonight_night_colors.white, bg = tokyonight_night_colors.lightbg },
    z = { fg = tokyonight_night_colors.black, bg = tokyonight_night_colors.blue },
  },
  insert = { a = { fg = tokyonight_night_colors.black, bg = tokyonight_night_colors.green } },
  visual = { a = { fg = tokyonight_night_colors.black, bg = tokyonight_night_colors.orange } },
  terminal = { a = { fg = tokyonight_night_colors.black, bg = tokyonight_night_colors.purple } },
  replace = { a = { fg = tokyonight_night_colors.black, bg = tokyonight_night_colors.green } },
}

return M
