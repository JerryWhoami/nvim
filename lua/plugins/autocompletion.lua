local status_cmp, cmp = pcall(require, "cmp")
if not status_cmp then
  return
end

local status_lspkind, lspkind = pcall(require, "lspkind")
if not status_lspkind then
  return
end

local status_luasnip, luasnip = pcall(require, "luasnip")
if not status_luasnip then
  return
end

vim.opt.completeopt = { "menu", "menuone", "noselect" }

local function border(hl_name)
  return {
    { "╭", hl_name },
    { "─", hl_name },
    { "╮", hl_name },
    { "│", hl_name },
    { "╯", hl_name },
    { "─", hl_name },
    { "╰", hl_name },
    { "│", hl_name },
  }
end

local cmp_window = require "cmp.utils.window"

cmp_window.info_ = cmp_window.info
cmp_window.info = function(self)
  local info = self:info_()
  info.scrollable = false
  return info
end

local options = {
  window = {
    completion = {
      border = "rounded",
      -- border = border "CmpBorder",
      -- winhighlight = "Normal:CmpPmenu,CursorLine:PmenuSel,Search:None",
    },
    documentation = {
      border = "rounded",
      -- border = border "CmpDocBorder",
    },
  },
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  formatting = {
    format = lspkind.cmp_format {
      mode = "text_symbol",
      maxwidth = 100,
      ellipsis_char = "...",
    },
  },
  mapping = {
    ["<C-k>"] = cmp.mapping.select_prev_item(),
    ["<C-j>"] = cmp.mapping.select_next_item(),
    ["<C-u>"] = cmp.mapping.scroll_docs(-4),
    ["<C-d>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.abort(),
    ["<CR>"] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = false,
    },
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_locally_jumpable() then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-expand-or-jump", true, true, true), "")
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.locally_jumpable(-1) then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-jump-prev", true, true, true), "")
      else
        fallback()
      end
    end, { "i", "s" }),
  },
  sources = {
    { name = "nvim_lsp" },
    { name = "nvim_lua" },
    { name = "luasnip" },
    { name = "path" },
    { name = "buffer" },
  },
}

require("luasnip.loaders.from_vscode").lazy_load()
luasnip.filetype_extend("blade", { "html" })

-- Remove tab stops after exiting insert mode
local augroup = vim.api.nvim_create_augroup("LuasnipTabstops", {})
vim.api.nvim_create_autocmd("InsertLeave", {
  group = augroup,
  callback = function()
    if luasnip.get_active_snip() then
      luasnip.unlink_current()
    end
  end,
})

cmp.setup(options)
