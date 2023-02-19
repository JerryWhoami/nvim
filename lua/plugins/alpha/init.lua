local utils = require("core.utils")

local config = require("config")
local custom = config.alpha

local footerOpts = {
	fortune = function()
		local handle = io.popen("fortune -n 50")
		local fortune = handle:read("*a")
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

local themes = require("plugins.alpha.themes")

local padding = function()
	local window = vim.api.nvim_get_current_win()
	local win_height = vim.api.nvim_win_get_height(window)

	local logo_height = #themes[config.alpha.theme]

	return vim.fn.floor((win_height - logo_height) * 0.5)
end

return {
	"goolord/alpha-nvim",
	event = "VimEnter",
	opts = {
		layout = {
			{ type = "padding", val = padding() },
			{
				type = "text",
				val = themes[config.alpha.theme],
				opts = { hl = "AlphaLogo", position = "center" },
			},
		},
		opts = {},
	},
}
