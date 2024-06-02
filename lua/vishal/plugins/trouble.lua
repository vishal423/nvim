-- Plugin to view diagnostics, LSP references
return {
	"folke/trouble.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	keys = {
		{ "<leader>xw", "<cmd>Trouble diagnostics toggle<cr>", desc = "Trouble: Toggle diagnostics" },
		{ "<leader>xd", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Trouble: Buffer diagnostics" },
		{ "<leader>xq", "<cmd>Trouble qflist toggle<cr>", desc = "Trouble: Toggle quickfix" },
	},
	opts = {
		modes = {
			diagnostics = {
				mode = "diagnostics",
				preview = {
					type = "split",
					relative = "win",
					position = "right",
					size = 0.3,
				},
			},
		},
	},
}
