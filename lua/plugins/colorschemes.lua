local colorscheme = require("config").colorscheme

return {
	{ "JoosepAlviste/palenightfall.nvim" },
	{
		"folke/tokyonight.nvim",
		opts = {
			sidebars = {
				"qf",
				"vista_kind",
				"terminal",
				"spectre_panel",
				"startuptime",
				"Outline",
			},
			on_highlights = function(hl, colors)
				local prompt = "#2d3149"
				hl.CursorLineNr = { fg = colors.orange, bold = true }
				hl.LineNr = { fg = colors.orange, bold = true }
				hl.LineNrAbove = { fg = colors.fg_gutter }
				hl.LineNrBelow = { fg = colors.fg_gutter }
				hl.TelescopeNormal = { bg = colors.bg_dark, fg = colors.fg_dark }
				hl.TelescopeBorder = { bg = colors.bg_dark, fg = colors.bg_dark }
				hl.TelescopePromptNormal = { bg = prompt }
				hl.TelescopePromptBorder = { bg = prompt, fg = prompt }
				hl.TelescopePromptTitle = { bg = colors.fg_gutter, fg = colors.orange }
				hl.TelescopePreviewTitle = { bg = colors.bg_dark, fg = colors.bg_dark }
				hl.TelescopeResultsTitle = { bg = colors.bg_dark, fg = colors.bg_dark }
				hl.TelescopePromptPrefix = { bg = colors.prompt, fg = colors.orange }
				hl.TelescopeSelection = { bg = colors.fg_gutter, fg = colors.fg }
			end,
		},
	},
	{ "LunarVim/lunar.nvim" },
}
