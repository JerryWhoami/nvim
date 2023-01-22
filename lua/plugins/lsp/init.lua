local custom = require("config").lsp
local utils = require("core.utils")

return {
	-- tools
	{
		"williamboman/mason.nvim",
		opts = {
			ui = {
				icons = {
					package_pending = " ",
					package_installed = " ",
					package_uninstalled = " ﮊ",
				},

				keymaps = {
					toggle_server_expand = "<CR>",
					install_server = "i",
					update_server = "u",
					check_server_version = "c",
					update_all_servers = "U",
					check_outdated_servers = "C",
					uninstall_server = "X",
					cancel_installation = "<C-c>",
				},
			},
			log_level = vim.log.levels.INFO,
			max_concurrent_installers = 4,
		},
	},

	{
		"williamboman/mason-lspconfig.nvim",
		event = "BufReadPre",
		dependencies = { "williamboman/mason.nvim" },
		opts = {
			ensure_installed = custom.servers,
			automatic_installation = true,
		},
	},

	-- lsp servers
	{
		"neovim/nvim-lspconfig",
		event = "BufReadPre",
		config = function()
			local lspconfig = require("lspconfig")
			local handlers = require("plugins.lsp.handlers")
			handlers.setup()

			for _, server in pairs(custom.servers) do
				local opts = {
					on_attach = handlers.on_attach,
					capabilities = handlers.capabilities,
				}

				local status, custom_opts = pcall(require, "plugins.lsp.settings." .. server)
				if status then
					opts = utils.merge_tables(opts, custom_opts)
				end

				lspconfig[server].setup(opts)
			end
		end,
	},

	-- null-ls
	{
		"jose-elias-alvarez/null-ls.nvim",
		event = "BufReadPre",
		opts = function()
			local null_ls = require("null-ls")
			local formatting = null_ls.builtins.formatting
			local diagnostics = null_ls.builtins.diagnostics
			local code_actions = null_ls.builtins.code_actions

			return {
				debug = false,
				sources = {
					-- formatting
					formatting.blade_formatter,
					formatting.stylua,
					-- formatting.rustywind,

					-- diagnostics
					-- diagnostics.clang_check,
					-- diagnostics.flake8,

					-- code_actions
					-- code_actions.eslint,
				},
				on_attach = function(client, bufnr)
					utils.formatOnSave(client, bufnr)
				end,
			}
		end,
	},
}
