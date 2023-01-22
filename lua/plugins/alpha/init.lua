local utils = require("core.utils")

local custom = require("config").alpha

local footerOpts = {
  fortune = function ()
    local handle = io.popen "fortune -n 50"
    local fortune = handle:read "*a"
    handle:close()
    return fortune
  end,
  lazy = function()
    local stats = require("lazy").stats()
    local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
    local lazy = "⚡ Neovim loaded " .. stats.count .. " plugins in " .. ms .. "ms"
    return lazy
  end,
}

return {
  "goolord/alpha-nvim",
  event = "VimEnter",
  opts = function ()
    local status_ok, alpha = pcall(require, "alpha")
    if not status_ok then
      return
    end

    local dashboard = require "alpha.themes.dashboard"
    local themes = require("plugins.alpha.themes")

    dashboard.section.header.val = themes[custom.theme]

    dashboard.section.buttons.val = {
      dashboard.button("f", "  Find file", ":Telescope find_files<CR>"),
      dashboard.button("r", "  Recently used files", ":Telescope oldfiles<CR>"),
      dashboard.button("t", "  Find text", ":Telescope live_grep <CR>"),
      dashboard.button("c", "  Configuration", ":e ~/.config/nvim/lua/config.lua <CR>"),
      dashboard.button("q", "  Quit Neovim", ":qa<CR>"),
    }

    dashboard.section.footer.opts.hl = "Type"
    dashboard.section.header.opts.hl = "Include"
    dashboard.section.buttons.opts.hl = "Keyword"

    return dashboard
  end,
  config = function (_, dashboard)
    vim.b.miniindentscope_disable = true

    -- close Lazy and re-open when the dashboard is ready
    if vim.o.filetype == "lazy" then
      vim.cmd.close()
      vim.api.nvim_create_autocmd("User", {
        pattern = "AlphaReady",
        callback = function()
          require("lazy").show()
        end,
      })
    end

    require("alpha").setup(dashboard.opts)

    vim.api.nvim_create_autocmd("User", {
      pattern = "LazyVimStarted",
      callback = function ()
        local footer = footerOpts[custom.footer]

        dashboard.section.footer.val = footer
        pcall(vim.cmd.AlphaRedraw)
      end,
    })
  end
}
