local M = {}
local utils = require "core.utils"

M.getTheme = function(type)
  local path = "highlights.themes." .. vim.g.colorscheme

  local exists, theme = pcall(require, path)
  if not exists then
    return "No colorscheme found!"
  end

  return theme[type]
end

M.getHighlightGroups = function()
  local highlights = {}

  -- Get path to our integrations directory
  local path = "/home/jwhoami/.config/nvim/lua/highlights/integrations/"
  -- Get a list of all file names in the directory
  local highlightFiles = vim.fn.readdir(path)

  -- Merge all highlight groups into one single table
  for i = 1, #highlightFiles do
    local integration = require("highlights.integrations." .. vim.fn.fnamemodify(highlightFiles[i], ":r"))
    highlights = utils.mergeTables(highlights, integration)
  end

  -- Load theme extra highlights if any
  local extraHl = M.getTheme "polish_hl"
  if extraHl then
    highlights = utils.mergeTables(highlights, extraHl)
  end

  return highlights
end

M.loadTheme = function()
  local highlights = M.getHighlightGroups()

  -- Load highlights
  for hlGroup, value in pairs(highlights) do
    vim.api.nvim_set_hl(0, hlGroup, value)
  end
end

return M
