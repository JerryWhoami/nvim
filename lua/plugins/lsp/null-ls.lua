local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
  return
end

local utils = require "core.utils"

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local diagnostics = null_ls.builtins.diagnostics
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/code_actions
local code_actions = null_ls.builtins.code_actions

local sources = {
  -- formatting
  -- formatting.prettier.with { extra_args = { "--no-semi", "--single-quote", "--jsx-single-quote" } },
  -- formatting.black.with { extra_args = { "--fast" } },
  formatting.blade_formatter,
  -- formatting.clang_format,
  formatting.stylua,
  -- formatting.rustywind,

  -- diagnostics
  -- diagnostics.clang_check,
  -- diagnostics.flake8,

  -- code_actions
  -- code_actions.eslint,
}

null_ls.setup {
  debug = false,
  sources = sources,
  on_attach = function(client, bufnr)
    utils.formatOnSave(client, bufnr)
  end,
}
