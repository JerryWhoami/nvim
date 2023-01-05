local M = {}

M.contains = function(element, table)
  for _, value in pairs(table) do
    if element == value then
      return true
    end
  end
  return false
end

M.filterLspClients = function(client)
  local configs = require "plugins.lsp.formatting"
  if vim.bo.filetype == "php" then
    return M.contains(client.name, configs.php)
  end
  return client.name == "null-ls"
end

M.formatOnSave = function(client, bufnr)
  local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
  if client.supports_method "textDocument/formatting" then
    vim.api.nvim_clear_autocmds { group = augroup, buffer = bufnr }
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = augroup,
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.format {
          bufnr = bufnr,
          filter = M.filterLspClients,
        }
      end,
    })
  end
end

M.restartLsp = function()
  vim.cmd "lua vim.lsp.stop_client(vim.lsp.get_active_clients())"
end

M.mergeTables = function(table1, table2)
  return vim.tbl_deep_extend("force", table1, table2)
end

M.smartBufferClose = function()
  local bufnr = vim.api.nvim_get_current_buf()
  local modified = vim.api.nvim_buf_get_option(bufnr, "modified")
  if modified then
    vim.ui.input({
      prompt = "You have unsaved changes. Quit anyway? (Y/n) ",
    }, function(input)
      if input == "Y" or input == "y" or input == nil then
        M.bufferClose()
      end
    end)
  else
    M.bufferClose()
  end
end

M.bufferClose = function()
  local treeView = require "nvim-tree.view"
  local bufferline = require "bufferline"

  -- check if NvimTree window was open
  local explorerWindow = treeView.get_winnr() or -1
  local wasExplorerOpen = vim.api.nvim_win_is_valid(explorerWindow)

  local bufferToDelete = vim.api.nvim_get_current_buf()

  if wasExplorerOpen then
    -- switch to previous buffer (tracked by bufferline)
    bufferline.cycle(-1)
  end

  -- delete initially open buffer
  vim.cmd("bd! " .. bufferToDelete)
end

M.smart_quit = function()
  local bufnr = vim.api.nvim_get_current_buf()
  local modified = vim.api.nvim_buf_get_option(bufnr, "modified")

  -- check if NvimTree window was open
  local treeView = require "nvim-tree.view"
  local explorerWindow = treeView.get_winnr() or -1
  local wasExplorerOpen = vim.api.nvim_win_is_valid(explorerWindow)

  if modified then
    vim.ui.input({
      prompt = "You have unsaved changes. Quit anyway? (Y/n) ",
    }, function(input)
      if input == "Y" or input == "y" or input == nil then
        if wasExplorerOpen then
          vim.cmd "NvimTreeToggle"
        end
        vim.cmd "q!"
      end
    end)
  else
    if wasExplorerOpen then
      vim.cmd "NvimTreeToggle"
    end
    vim.cmd "q!"
  end
end

return M
