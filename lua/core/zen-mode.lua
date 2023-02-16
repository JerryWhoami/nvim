local M = {}

M.opts = {
  laststatus = 3,
  showtabline = 0,
  number = false,
  relativenumber = false,
  foldcolumn = "8",
}

M.setup = function()
  vim.cmd [[hi WinSeparator guifg=bg guibg=bg gui=none]]
  vim.cmd [[hi statusline guifg=fg guibg=bg gui=none]]
end

return M
