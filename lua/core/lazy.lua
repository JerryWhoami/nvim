-- Add lazy plugin manager if it has not been downloaded
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

local config = require "config"
local status, lazy = pcall(require, "lazy")
if not status then
  return
end

lazy.setup {
  spec = {
    { import = "plugins" },
  },
  defaults = { lazy = true },
  install = {
    colorscheme = { "palenightfall" },
  },
  dev = { path = config.plugin_development_dir },
  checker = { enabled = true },
  diff = {
    cmd = "terminal_git",
  },
  performance = {
    cache = {
      enabled = true,
    },
    rtp = {},
  },
}
