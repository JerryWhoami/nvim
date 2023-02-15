local config = require("config")

return {
	-- Better ui for notifications
	{
		"rcarriga/nvim-notify",
		event = "VeryLazy",
		opts = {
			timeout = 3000,
			level = 2,
			max_height = function()
				return math.floor(vim.o.lines * 0.75)
			end,
			max_width = function()
				return math.floor(vim.o.columns * 0.75)
			end,
		},
		config = function(_, opts)
			local notify = require("notify")
			vim.notify = notify

			notify.setup(opts)
		end,
	},

	-- better vim.ui
	{
		"stevearc/dressing.nvim",
		event = "VeryLazy",
		opts = {
			input = {
				relative = "editor",
				prefer_width = 50,
			},
			i = {
				["<C-k>"] = "HistoryPrev",
				["<C-j>"] = "HistoryNext",
			},
		},
	},

	-- scrollbar
	{
		"petertriho/nvim-scrollbar",
		event = "BufReadPost",
		enabled = function()
			if config.zen_mode then
				return false
			end
			return true
		end,
		config = function()
			local scrollbar = require("scrollbar")
			local colors = require("tokyonight.colors").setup()
			scrollbar.setup({
				handle = { color = colors.bg_highlight },
				excluded_filetypes = { "prompt", "TelescopePrompt", "noice", "notify" },
				marks = {
					Search = { color = colors.orange },
					Error = { color = colors.error },
					Warn = { color = colors.warning },
					Info = { color = colors.info },
					Hint = { color = colors.hint },
					Misc = { color = colors.purple },
				},
			})
		end,
	},
}
