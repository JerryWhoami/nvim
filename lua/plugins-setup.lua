local fn = vim.fn

vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#1e222a" })

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins-setup.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

-- Install your plugins here
return packer.startup(function(use)
  -- My plugins here
  use "wbthomason/packer.nvim" -- Have packer manage itself

  -- Generals
  use "nvim-lua/popup.nvim" -- An implementation of the Popup API from vim in Neovim
  use "nvim-lua/plenary.nvim" -- Useful lua functions used ny lots of plugins
  use "RRethy/vim-illuminate" -- Highlighting improvements
  use "numToStr/Comment.nvim" -- Easily comment stuff
  use "folke/which-key.nvim" -- mapping reminder
  use "akinsho/bufferline.nvim" -- support for buffers
  use "lukas-reineke/indent-blankline.nvim" -- indent lines
  use "windwp/nvim-autopairs" -- autoclose parens, brackets, quotes, etc...
  use "nvim-lualine/lualine.nvim" -- Status line
  use "akinsho/toggleterm.nvim" -- Terminal integration
  use "lewis6991/impatient.nvim" -- Reduce startup time
  use "goolord/alpha-nvim" -- Nvim Dashboard
  use "folke/trouble.nvim" -- List of diagnostics and errors
  use "folke/neodev.nvim"
  use "mg979/vim-visual-multi"

  -- SFTP server
  use "eshion/vim-sync"

  -- colorscheme
  use "LunarVim/lunar.nvim"
  use "folke/tokyonight.nvim"

  -- autocompletion
  use "hrsh7th/nvim-cmp" -- The completion plugin
  use "hrsh7th/cmp-buffer" -- buffer completions
  use "hrsh7th/cmp-path" -- path completions
  use "hrsh7th/cmp-cmdline" -- cmdline completions
  use "saadparwaiz1/cmp_luasnip" -- snippet completions
  use "hrsh7th/cmp-nvim-lsp"
  use "hrsh7th/cmp-nvim-lua"
  use "onsails/lspkind.nvim" -- vscode icons

  -- snippets
  use "L3MON4D3/LuaSnip" --snippet engine
  use "rafamadriz/friendly-snippets" -- a bunch of snippets to use

  -- LSP
  use "neovim/nvim-lspconfig" -- enable LSP
  use "williamboman/mason.nvim" -- simple to use language server installer
  use "williamboman/mason-lspconfig.nvim" -- simple to use language server installer
  use "jose-elias-alvarez/null-ls.nvim" -- LSP diagnostics and code actions
  -- use({ "glepnir/lspsaga.nvim", branch = "main" })

  -- fuzzy finding w/ telescope
  use {
    "nvim-telescope/telescope-fzf-native.nvim",
    run = "make",
  } -- dependency for better sorting performance
  use {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
  } -- fuzzy finder

  -- Treesitter
  use {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
  }
  use "JoosepAlviste/nvim-ts-context-commentstring"
  use "p00f/nvim-ts-rainbow"
  use { "windwp/nvim-ts-autotag", after = "nvim-treesitter" } -- autoclose tags

  -- nvim tree
  use "kyazdani42/nvim-web-devicons"
  use "kyazdani42/nvim-tree.lua"

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
