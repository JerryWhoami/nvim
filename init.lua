-- Colorscheme
vim.g.colorscheme = "tokyonight-night"

require "plugins.impatient"

require "plugins-setup"
require "core"

require "plugins.lsp"
require "plugins.telescope"
require "plugins.whichkey"
require "plugins.autocompletion"
require "plugins.nvim-tree"

require "plugins.comment"
require "plugins.alpha"
require "plugins.tresitter"
require "plugins.autopairs"
require "plugins.illuminate"
require "plugins.indentline"
require "plugins.colorizer"
require "plugins.toggleterm"
require "plugins.lualine"
require "plugins.vim-sync"
require "plugins.bufferline"

require("highlights").loadTheme()
