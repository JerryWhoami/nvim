local M = {}

M.is_enabled = function(plugin)
  local disabled_plugins = require("config").disabled_plugins

  if M.contains(plugin, disabled_plugins) then
    return false
  end

  return true
end

M.contains = function(element, table)
  for _, value in pairs(table) do
    if element == value then
      return true
    end
  end
  return false
end

M.contains_key = function(element, table)
  for key, _ in pairs(table) do
    if element == key then
      return true
    end
  end
  return false
end

M.filterLspClients = function(client)
  local ft = vim.bo.filetype
  local have_nls = #require("null-ls.sources").get_available(ft, "NULL_LS_FORMATTING") > 0

  if have_nls then
    return client.name == "null-ls"
  end
  return client.name ~= "null-ls"
end

M.formatOnSave = function(client, bufnr)
  local augroup = vim.api.nvim_create_augroup("LspFormatting" .. bufnr, {})
  if client.supports_method "textDocument/formatting" then
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

M.merge_tables = function(table1, table2)
  return vim.tbl_deep_extend("force", table1, table2)
end

M.smart_buffer_close = function()
  local bufnr = vim.api.nvim_get_current_buf()
  local modified = vim.api.nvim_buf_get_option(bufnr, "modified")
  local buffer_to_delete = vim.api.nvim_get_current_buf()

  if modified then
    vim.ui.input({
      prompt = "You have unsaved changes. Quit anyway? (y/n) ",
    }, function(input)
      if input == "Y" or input == "y" then
        vim.cmd("bd! " .. buffer_to_delete)
      end
    end)
  else
    vim.cmd("bd! " .. buffer_to_delete)
  end
end

M.smart_quit = function()
  local bufnr = vim.api.nvim_get_current_buf()
  local modified = vim.api.nvim_buf_get_option(bufnr, "modified")

  if modified then
    vim.ui.input({
      prompt = "You have unsaved changes. Quit anyway? (y/n) ",
    }, function(input)
      if input == "Y" or input == "y" then
        vim.cmd "q!"
      end
    end)
  else
    vim.cmd "q!"
  end
end

return M
