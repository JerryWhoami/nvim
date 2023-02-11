local config = require "config"

vim.g.mapleader = config.leader_key
vim.g.maplocalleader = config.leader_key

-- Setup plugin manager
require "core.lazy"

-- Keymaps
local keymapConfig = require "core.keymaps"
for mode, mode_mappings in pairs(keymapConfig.keymaps) do
  local opts = (mode == "t") and keymapConfig.options.term_opts or keymapConfig.options.default
  for keymap, command in pairs(mode_mappings) do
    vim.api.nvim_set_keymap(mode, keymap, command, opts)
  end
end

-- Options
local options = require "core.options"
for index, value in pairs(options) do
  vim.opt[index] = value
end

vim.opt.shortmess:append "c" -- don't show redundant messages from ins-completion-menu
vim.opt.whichwrap:append "<,>,[,],h,l" -- for line wrapping
if config.include_hyphen_in_word then
  vim.opt.iskeyword:append "-" -- Include - as part of a word
end

-- Require globals
require "core.globals"

-- Colorscheme
vim.cmd "colorscheme tokyonight-night"
vim.cmd "colorscheme tokyonight-night"

-- Disable providers
vim.g.loaded_python3_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_node_provider = 0

require "core.globals"
