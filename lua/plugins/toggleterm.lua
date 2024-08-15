return {
	"akinsho/toggleterm.nvim",
	version = "*",
	opts = {
		size = 10,
		insert_mappings = true,
		terminal_mappings = true,
		direction = "float",
		auto_scroll = true,
		shading_factor = 2,
		float_opts = {
			border = "curved",
		},
	},
	keys = {
		{ "<C-'>", "<cmd>ToggleTerm<cr>", desc = "Toggle floating terminal" },
	},
}
