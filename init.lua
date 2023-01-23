require "core"

vim.api.nvim_create_autocmd("BufEnter", {
  pattern = { "*.php" },
  callback = function()
    vim.opt.shiftwidth = 2
    vim.opt.tabstop = 2
    vim.opt.expandtab = true
  end,
})

vim.api.nvim_create_autocmd("BufEnter", {
  pattern = { "*.blade.php" },
  callback = function()
    vim.cmd "setlocal filetype=blade"
    require("luasnip").filetype_extend("blade", { "html" })
  end,
})
