return {
	"nvim-lualine/lualine.nvim",
	opts = {
		tabline = {
			lualine_a = { "mode" },
			lualine_b = { "branch", "diff" },
			lualine_c = { "buffers" },
			lualine_x = { "diagnostics", "filetype" },
			lualine_y = { "progress" },
			lualine_z = { "location" },
		},
    sections = {},
	},
}
