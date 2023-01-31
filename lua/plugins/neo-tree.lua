local utils = require "core.utils"

local custom = require("config").neo_tree

local default = {
  floating_window = false,
  popup_border_style = "rounded",
  filesystem = {
    window = {
      position = "right",
      width = "25%",
      popup = {
        position = { col = "100%", row = "2" },
        size = function(state)
          local root_name = vim.fn.fnamemodify(state.path, ":~")
          local root_len = string.len(root_name) + 4
          return {
            width = math.max(root_len, 40),
            height = vim.o.lines - 6,
          }
        end,
      },
    },
    follow_current_file = true,
    filtered_items = {
      hide_dotfiles = false,
      hide_gitignored = false,
      hide_by_name = {},
      hide_by_pattern = {},
    },
  },
}

local options = utils.merge_tables(default, custom)

return {
  "nvim-neo-tree/neo-tree.nvim",
  cmd = "Neotree",
  init = function()
    vim.g.neo_tree_remove_legacy_commands = 1
    if vim.fn.argc() == 1 then
      local stat = vim.loop.fs_stat(vim.fn.argv(0))
      if stat and stat.type == "directory" then
        require "neo-tree"
      end
    end
  end,
  opts = options,
}
