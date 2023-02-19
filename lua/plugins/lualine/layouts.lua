local M = {}

local components = require("plugins.lualine.components")

M.default = {
	lualine_a = { components.mode },
	lualine_b = { components.fileInfo },
	lualine_c = { components.git },
	lualine_x = { components.diagnostics },
	lualine_y = { components.filetype },
	lualine_z = { components.cursor_position },
}

M.zen = {
	lualine_a = { components.fileInfo },
	lualine_b = {},
	lualine_c = {},
	lualine_x = {},
	lualine_y = {},
	lualine_z = { "location" },
}

return M
