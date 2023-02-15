return {
	"nvim-treesitter/nvim-treesitter",
	dependencies = {
		"p00f/nvim-ts-rainbow",
		"windwp/nvim-ts-autotag",
		"JoosepAlviste/nvim-ts-context-commentstring",
	},
	version = false, -- last release is way too old and doesn't work on Windows
	build = ":TSUpdate",
	event = "BufReadPost",
	opts = {
		ensure_installed = "all",
		sync_install = false,
		ignore_install = { "" }, -- List of parsers to ignore installing
		indent = { enable = false, disable = { "yaml" } },
		autopairs = {
			enable = true,
		},
		autotag = {
			enable = true,
			filetypes = {
				"html",
				"blade",
				"javascript",
				"typescript",
				"javascriptreact",
				"typescriptreact",
				"svelte",
				"vue",
				"tsx",
				"jsx",
				"rescript",
				"xml",
				"php",
				"markdown",
				"glimmer",
				"handlebars",
				"hbs",
			},
		},
		context_commentstring = {
			enable = true,
			enable_autocmd = false,
		},
		highlight = {
			enable = true, -- false will disable the whole extension
			disable = { "" }, -- list of language that will be disabled
			additional_vim_regex_highlighting = true,
		},
		rainbow = {
			enable = true,
			-- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
			extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
			max_file_lines = nil, -- Do not enable for files with more than n lines, int
			-- colors = {}, -- table of hex strings
			-- termcolors = {} -- table of colour name strings
		},
	},
	config = function(_, opts)
		local parser = require("nvim-treesitter.parsers").filetype_to_parsername
		parser.blade = "html"

		require("nvim-treesitter.configs").setup(opts)
	end,
}
