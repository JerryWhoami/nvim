local config = require("config")
local custom = config.lualine
local utils = require("core.utils")

local get_theme = function(custom_theme)
	local themes = require("plugins.lualine.themes")

	if config.zen_mode then
		return themes["zen"]
	end

	if utils.contains_key(custom_theme, themes) then
		return themes[custom_theme]
	end

	return "tokyonight"
end

local get_layout = function()
	local layouts = require("plugins.lualine.layouts")

	if config.zen_mode then
		return layouts.zen
	end

	return layouts.default
end

return {
	"nvim-lualine/lualine.nvim",
	event = "VeryLazy",
	opts = {
		options = {
			icons_enabled = true,
			theme = get_theme(custom.theme),
			component_separators = "",
			section_separators = { left = "", right = "" },
			disabled_filetypes = { "dashboard", "NvimTree", "Outline" },
			always_divide_middle = true,
		},
		sections = get_layout(),
		inactive_sections = {
			lualine_a = {},
			lualine_b = {},
			lualine_c = {},
			lualine_x = {},
			lualine_y = {},
			lualine_z = {},
		},
		tabline = {},
		extensions = {},
	},
}
