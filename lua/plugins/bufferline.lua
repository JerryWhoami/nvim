local utils = require "core.utils"

local config = require "config"
local custom = config.bufferline

local default = {
  diagnostics = "nvim_lsp",
  always_show_bufferline = true,
  buffer_close_icon = "",
  modified_icon = "●",
  close_icon = "",
  left_trunc_marker = "",
  right_trunc_marker = "",
  max_name_length = 18,
  max_prefix_length = 15,
  truncate_names = true,
  tab_size = 18,
  diagnostics_indicator = function(_, _, diagnostics)
    local result = {}
    local symbols = {
      error = "",
      warning = "",
      info = "",
    }

    for name, count in pairs(diagnostics) do
      if symbols[name] and count > 0 then
        table.insert(result, symbols[name] .. " " .. count)
      end
    end

    local formatted_result = table.concat(result, " ")
    return #result > 0 and formatted_result or ""
  end,
  offsets = {
    {
      filetype = "neo-tree",
      text = "Neo-tree",
      highlight = "Directory",
      text_align = "left",
    },
  },
}

local options = utils.merge_tables(default, custom)

return {
  "akinsho/bufferline.nvim",
  lazy = false,
  enabled = function()
    if config.zen_mode then
      return false
    end
    return true
  end,
  opts = {
    options = options,
    highlights = {
      background = {
        italic = true,
      },
      buffer_selected = {
        bold = true,
      },
    },
  },
}
