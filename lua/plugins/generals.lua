local custom = require("config").generals

return {
  "nvim-lua/popup.nvim",
  "nvim-lua/plenary.nvim",
  "nvim-tree/nvim-web-devicons",
  "MunifTanjim/nui.nvim",
  { "p00f/nvim-ts-rainbow", lazy = true },
  { "windwp/nvim-ts-autotag", lazy = true },

  {
    "folke/lsp-colors.nvim",
    event = "BufEnter",
  },

  -- Comments
  { "JoosepAlviste/nvim-ts-context-commentstring", lazy = true },
  {
    "numToStr/Comment.nvim",
    event = "VeryLazy",
    opts = {
      hooks = {
        pre = function()
          require("ts_context_commentstring.internal").update_commentstring {}
        end,
      },
    },
    config = function(_, opts)
      require("Comment").setup(opts)
    end,
  },

  -- Higlight words
  {
    "RRethy/vim-illuminate",
    event = "BufReadPost",
    opts = { delay = 200 },
    config = function(_, opts)
      require("illuminate").configure(opts)
    end,
  },

  -- indent guides for Neovim
  {
    "lukas-reineke/indent-blankline.nvim",
    event = "BufReadPre",
    opts = {
      filetype_exclude = { "help", "alpha", "dashboard", "neo-tree", "Trouble", "lazy" },
      show_trailing_blankline_indent = false,
      show_current_context = custom.indent_blankline.show_current_context,
      show_current_context_start = custom.indent_blankline.show_current_context_start,
    },
  },

  -- Terminal
  {
    "akinsho/toggleterm.nvim",
    keys = { [[<c-\>]] },
    opts = {
      size = custom.toggleterm.size,
      open_mapping = [[<c-\>]],
      direction = custom.toggleterm.direction,
      hide_numbers = true,
      shade_filetypes = {},
      shade_terminals = true,
      shading_factor = 2,
      start_in_insert = true,
      insert_mappings = true,
      persist_size = true,
      close_on_exit = true,
      shell = vim.o.shell,
      float_opts = {
        border = "curved",
        winblend = 0,
        highlights = {
          border = "Normal",
          background = "Normal",
        },
      },
    },
    config = function(_, opts)
      require("toggleterm").setup(opts)

      function _G.set_terminal_keymaps()
        local opts = { noremap = true }
        vim.api.nvim_buf_set_keymap(0, "t", "<esc>", [[<C-\><C-n>]], opts)
        vim.api.nvim_buf_set_keymap(0, "t", "<C-h>", [[<C-\><C-n><C-W>h]], opts)
        vim.api.nvim_buf_set_keymap(0, "t", "<C-j>", [[<C-\><C-n><C-W>j]], opts)
        vim.api.nvim_buf_set_keymap(0, "t", "<C-k>", [[<C-\><C-n><C-W>k]], opts)
        vim.api.nvim_buf_set_keymap(0, "t", "<C-l>", [[<C-\><C-n><C-W>l]], opts)
      end

      vim.cmd "autocmd! TermOpen term://* lua set_terminal_keymaps()"
    end,
  },

  -- Autopairs
  {
    "windwp/nvim-autopairs",
    event = "VeryLazy",
    opts = {
      check_ts = true, -- enable treesitter
      ts_config = {
        lua = { "string" }, -- don't add pairs in lua string treesitter nodes
        javascript = { "template_string" }, -- don't add pairs in javscript template_string treesitter nodes
        java = false, -- don't check treesitter on java
      },
      disable_filetype = { "TelescopePrompt", "spectre_panel" },
    },
  },
}
