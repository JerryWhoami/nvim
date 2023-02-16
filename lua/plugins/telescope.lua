local utils = require "core.utils"

local custom = require("config").telescope

local default = {
  defaults = {
    prompt_prefix = "   ",
    selection_caret = " ",
    entry_prefix = "  ",
    selection_strategy = "reset",
    sorting_strategy = "ascending",
    layout_strategy = "horizontal",
    layout_config = {
      horizontal = {
        prompt_position = "top",
        preview_width = 0.55,
        results_width = 0.8,
      },
      vertical = {
        mirror = false,
      },
      width = 0.87,
      height = 0.80,
      preview_cutoff = 120,
    },
    file_ignore_patterns = { "node_modules" },
    mappings = {
      n = {
        ["q"] = function(...)
          require("telescope.actions").close(...)
        end,
      },
      i = {
        ["<S-Tab>"] = function(...)
          require("telescope.actions").move_selection_previous(...)
        end,
        ["<Tab>"] = function(...)
          require("telescope.actions").move_selection_next(...)
        end,
        ["<C-k>"] = function(...)
          require("telescope.actions").move_selection_previous(...)
        end,
        ["<C-j>"] = function(...)
          require("telescope.actions").move_selection_next(...)
        end,
        ["<a-i>"] = function()
          require("telescope.builtin").find_files { no_ignore = true }
        end,
        ["<a-h>"] = function()
          require("telescope.builtin").find_files { hidden = true }
        end,
        ["<a-a>"] = function()
          require("telescope.builtin").find_files { hidden = true, no_ignore = true }
        end,
        ["<C-Down>"] = function(...)
          return require("telescope.actions").cycle_history_next(...)
        end,
        ["<C-Up>"] = function(...)
          return require("telescope.actions").cycle_history_prev(...)
        end,
      },
    },
  },
}

local options = utils.merge_tables(default, custom)

return {
  { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-telescope/telescope-fzf-native.nvim" },
    cmd = "Telescope",
    opts = options,
    config = function(_, opts)
      local telescope_setup, telescope = pcall(require, "telescope")
      if not telescope_setup then
        return
      end

      telescope.setup(opts)
      telescope.load_extension "notify"
      telescope.load_extension "fzf"
    end,
  },
}
