return {
	leader_key = " ",
	colorscheme = "tokyonight-night",
	include_hyphen_in_word = true,
	plugin_development_dir = "~/Dev/Nvim",

	options = {
		relativenumber = true, -- set relative numbered lines
		cmdheight = 1, -- more space in the neovim command line for displaying messages
		shiftwidth = 2, -- the number of spaces inserted for each indentation
		tabstop = 2, -- insert 2 spaces for a tab
		timeoutlen = 500, -- time to wait for a mapped sequence to complete (in milliseconds)
		wrap = false, -- display lines as one long line, or true to wrap within screen
		cursorline = true, -- highlight the current line
	},

	lsp = {
		servers = {
			"sumneko_lua",
			"pyright",
			"jsonls",
			"intelephense",
			"html",
			"cssls",
			"tailwindcss",
			"tsserver",
			"emmet_ls",
		},
		servers_with_formatting_capabilities = {
			"intelephense",
			"tsserver",
		},
		options = {
			virtual_text = false,
			update_in_insert = true,
			underline = true,
			severity_sort = true,
			float = {
				focusable = false,
				border = "rounded",
				source = "always",
				header = "",
				prefix = "",
			},
		},
	},

	generals = {
		toggleterm = {
			size = 12,
			direction = "horizontal",
		},
		indent_blankline = {
			show_current_context = true,
			show_current_context_start = false,
		},
	},

	alpha = {
		theme = "toxic", -- dragon, toxic, lambda, initials, empty
		footer = "lazy", -- lazy, fortune
	},

	lualine = {
		theme = "tokyonight_night",
	},

	neo_tree = {
		floating_window = true,
		popup_border_style = "rounded",
		filesystem = {
			window = {
				position = "left",
				width = "25%",
			},
		},
	},

	auto_completion = {
		window = {
			completion = {
				border = "rounded",
			},
			documentation = {
				border = "rounded",
			},
		},
	},

	bufferline = {
		always_show_bufferline = true,
	},

	which_key = {
		window = {
			border = "rounded", -- none, single, double, shadow
			position = "bottom", -- bottom, top
		},
		layout = {
			height = { min = 4, max = 25 }, -- min and max height of the columns
			width = { min = 20, max = 50 }, -- min and max width of the columns
			spacing = 15, -- spacing between columns
			align = "center", -- align columns left, center or right
		},
		disable = {
			filetypes = { "TelescopePrompt" },
		},
	},

	telescope = {
		selection_strategy = "reset",
		sorting_strategy = "ascending",
		layout_strategy = "horizontal",
		file_ignore_patterns = { "node_modules" },
	},
}
