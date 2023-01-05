local status, which_key = pcall(require, "which-key")
if not status then
  return
end

local utils = require "core.utils"

local setup = {
  active = true,
  on_config_done = nil,
  plugins = {
    marks = false, -- shows a list of your marks on ' and `
    registers = false, -- shows your registers on " in NORMAL or <C-r> in INSERT mode

    spelling = {
      enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
      suggestions = 20, -- how many suggestions should be shown in the list?
    },

    presets = {
      operators = false, -- adds help for operators like d, y, ... and registers them for motion / text object completion
      motions = false, -- adds help for motions
      text_objects = false, -- help for text objects triggered after entering an operator
      windows = false, -- default bindings on <c-w>
      nav = false, -- misc bindings to work with windows
      z = false, -- bindings for folds, spelling and others prefixed with z
      g = false, -- bindings for prefixed with g
    },
  },

  icons = {
    breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
    separator = "", -- symbol used between a key and it's label
    group = "+", -- symbol prepended to a group
  },

  popup_mappings = {
    scroll_down = "<c-d>", -- binding to scroll down inside the popup
    scroll_up = "<c-u>", -- binding to scroll up inside the popup
  },

  window = {
    border = "rounded", -- none, single, double, shadow
    position = "bottom", -- bottom, top
    margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
    padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
    winblend = 0,
  },

  layout = {
    height = { min = 4, max = 25 }, -- min and max height of the columns
    width = { min = 20, max = 50 }, -- min and max width of the columns
    spacing = 15, -- spacing between columns
    align = "center", -- align columns left, center or right
  },

  ignore_missing = true, -- enable this to hide mappings for which you didn't specify a label
  hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
  show_help = true, -- show help message on the command line when the popup is visible
  show_keys = true, -- show the currently pressed key and its label as a message in the command line
  triggers = { "<leader>", "g" }, -- or specify a list manually

  triggers_blacklist = {
    -- list of mode / prefixes that should never be hooked by WhichKey
    i = { "j", "k" },
    v = { "j", "k" },
  },

  disable = {
    buftypes = {},
    filetypes = { "TelescopePrompt" },
  },
}

local mappings = {
  [";"] = { "<cmd>Alpha<CR>", "Dashboard" },
  ["e"] = { ":NvimTreeToggle<cr>", "Explorer" },
  ["w"] = { "<cmd>w!<CR>", "Save" },
  ["q"] = { utils.smart_quit, "Quit" },
  ["x"] = { utils.smartBufferClose, "Close Buffer" },
  f = {
    name = "Find",
    c = { "<cmd>Telescope colorscheme<cr>", "Colorscheme" },
    p = {
      "<cmd>lua require('telescope.builtin').colorscheme({enable_preview = true})<cr>",
      "Colorscheme with Preview",
    },
    f = { "<cmd>Telescope find_files<cr>", "Find Files" },
    a = { "<cmd>Telescope find_files hidden=true no_ignore=true<cr>", "Find All" },
    w = { "<cmd>Telescope live_grep<cr>", "Find Text" },
    l = { "<cmd>Telescope resume<cr>", "Last Search" },
    r = { "<cmd>Telescope oldfiles hidden=true no_ignore=true<cr>", "Recent File" },
    k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
    C = { "<cmd>Telescope commands<cr>", "Commands" },
    h = { "<cmd>Telescope help_tags<cr>", "Help Tags" },
  },
  l = {
    name = "LSP",
    d = { "<cmd>Telescope diagnostics<cr>", "Diagnostics" },
    f = { "<cmd>lua vim.lsp.buf.format({ async = true })<cr>", "Format" },
    i = { "<cmd>LspInfo<cr>", "Info" },
    I = { "<cmd>Mason<cr>", "Mason Info" },
    H = { "<cmd>IlluminationToggle<cr>", "Toggle Doc Higlighting" },
    l = { vim.lsp.codelens.run, "CodeLens Action" },
    q = { vim.diagnostic.setloclist, "Quickfix" },
    s = { "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols" },
    R = { utils.restartLsp, "Restart Lsp" },
  },
  b = {
    name = "Buffers",
    s = { "<cmd>BufferLinePick<cr>", "Jump" },
    f = { "<cmd>Telescope buffers<cr>", "Find" },
    b = { "<cmd>BufferLineCyclePrev<cr>", "Previous" },
    n = { "<cmd>BufferLineCycleNext<cr>", "Next" },
    W = { "<cmd>noautocmd w<cr>", "Save without formatting (noautocmd)" },
    e = { "<cmd>BufferLinePickClose<cr>", "Pick which buffer to close" },
    h = { "<cmd>BufferLineCloseLeft<cr>", "Close all to the left" },
    l = { "<cmd>BufferLineCloseRight<cr>", "Close all to the right" },
    D = { "<cmd>BufferLineSortByDirectory<cr>", "Sort by directory" },
    L = { "<cmd>BufferLineSortByExtension<cr>", "Sort by language" },
  },
  s = {
    name = "Splits",
    v = { "<cmd>vsplit<cr>", "Split Vertically" },
    h = { "<cmd>split<cr>", "Split Horizontally" },
    x = { "<cmd>close<cr>", "Close Splits" },
    e = { "<C-w>=", "Reset Splits" },
  },
  p = {
    name = "Packer",
    c = { "<cmd>PackerCompile<cr>", "Compile" },
    i = { "<cmd>PackerInstall<cr>", "Install" },
    r = { "<cmd>lua require('lvim.plugin-loader').recompile()<cr>", "Re-compile" },
    s = { "<cmd>PackerSync<cr>", "Sync" },
    S = { "<cmd>PackerStatus<cr>", "Status" },
    u = { "<cmd>PackerUpdate<cr>", "Update" },
  },
}

local gmappings = {
  d = { vim.lsp.buf.definition, "Go to Definition" },
  D = { vim.lsp.buf.declaration, "Go to Declaration" },
  r = { "<cmd>Telescope lsp_references<cr>", "Find References" },
  i = { vim.lsp.buf.implementation, "Find Implementations" },
  s = { vim.lsp.buf.signature_help, "Show Signature Help" },
  h = { vim.lsp.buf.hover, "Hover" },
  l = { "<cmd>lua vim.diagnostic.open_float()<cr>", "Show Line Diagnostics" },
  j = { vim.diagnostic.goto_next, "Next Diagnostic" },
  k = { vim.diagnostic.goto_prev, "Previous Diagnostic" },
}

local opts = {
  mode = "n", -- NORMAL mode
  prefix = "<leader>",
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = true, -- use `nowait` when creating keymaps
}

local gopts = {
  mode = "n", -- NORMAL mode
  prefix = "g",
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = true, -- use `nowait` when creating keymaps
}

which_key.setup(setup)
which_key.register(mappings, opts)
-- which_key.register(gmappings, gopts)
