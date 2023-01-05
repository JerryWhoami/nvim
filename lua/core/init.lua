-- Require globals
require "core.globals"

-- Colorscheme
local status_ok, _ = pcall(vim.cmd, "colorscheme " .. vim.g.colorscheme)
if not status_ok then
  vim.notify("colorscheme " .. vim.g.colorscheme .. " not found!")
  return
end

local options = require "core.options"
for index, value in pairs(options) do
  vim.opt[index] = value
end

vim.opt.iskeyword:append "-" -- Include - as part of a word
vim.opt.shortmess:append "c" -- don't show redundant messages from ins-completion-menu
vim.opt.whichwrap:append "<,>,[,],h,l" -- for line wrapping

-- Set keymappings
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local config = require "core.keymaps"
for mode, mode_mappings in pairs(config.keymaps) do
  local opts = (mode == "t") and config.options.term_opts or config.options.default
  for keymap, command in pairs(mode_mappings) do
    vim.api.nvim_set_keymap(mode, keymap, command, opts)
  end
end

-- Autocommands
local autocmd = vim.api.nvim_create_autocmd

-- Dont list quickfix buffers
autocmd("FileType", {
  pattern = "qf",
  callback = function()
    vim.opt_local.buflisted = false
  end,
})
-- Set Blade filetype
autocmd("BufEnter", {
  pattern = { "*.blade.php" },
  command = "setlocal filetype=blade",
})
