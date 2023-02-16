local config = require "config"
local zen = require "core.zen-mode"
local utils = require "core.utils"

local default = {
  laststatus = 3, -- global statusline
  backup = false, -- creates a backup file
  clipboard = "unnamedplus", -- allows neovim to access the system clipboard
  completeopt = { "menu", "menuone", "noselect" }, -- mostly just for cmp
  conceallevel = 3, -- so that `` is visible in markdown files
  confirm = true,
  hlsearch = false, -- highlight all matches on previous search pattern
  ignorecase = true, -- ignore case in search patterns
  mouse = "a", -- allow the mouse to be used in neovim
  mousemoveevent = true,
  hidden = true, -- Enable modified buffers in background
  pumblend = 10, -- Popup blend
  pumheight = 10, -- pop up menu height
  showmode = false, -- we don't need to see things like -- INSERT -- anymore
  showtabline = 2, -- always show tabs
  smartcase = true, -- smart case
  smartindent = true, -- make indenting smarter again
  splitbelow = true, -- force all horizontal splits to go below current window
  splitright = true, -- force all vertical splits to go to the right of current window
  swapfile = false, -- creates a swapfile
  termguicolors = true, -- set term gui colors (most terminals support this)
  undofile = true, -- enable persistent undo
  updatetime = 300, -- faster completion (4000ms default)
  writebackup = false, -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
  expandtab = true, -- convert tabs to spaces
  cursorline = true, -- highlight the current line
  number = true, -- set numbered lines
  numberwidth = 2, -- set number column width to 2 {default 4}
  signcolumn = "yes", -- always show the sign column, otherwise it would shift the text each time
  scrolloff = 8, -- is one of my fav
  sidescrolloff = 8,
  showcmd = false,
  grepprg = "rg --vimgrep --no-heading --smart-case",
  grepformat = "%f:%l:%c:%m",
  inccommand = "nosplit", -- preview incremental substitute
  joinspaces = false, -- No double spaces with join after a dot
  list = true, -- Show some invisible characters (tabs...
  relativenumber = true, -- set relative numbered lines
  cmdheight = 1, -- more space in the neovim command line for displaying messages
  shiftwidth = 2, -- the number of spaces inserted for each indentation
  tabstop = 2, -- insert 2 spaces for a tab
  timeoutlen = 500, -- time to wait for a mapped sequence to complete (in milliseconds)
  wrap = false, -- display lines as one long line, or true to wrap within screen
}

local options = utils.merge_tables(default, config.options)
if config.zen_mode then
  options = utils.merge_tables(options, zen.opts)
end

return options
