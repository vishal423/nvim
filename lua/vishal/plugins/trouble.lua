return {
	"folke/trouble.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	keys = {
		{ "<leader>xx", "<cmd>TroubleToggle<cr>", desc = "Toggle Trouble view" },
		{
			"<leader>xw",
			"<cmd>TroubleToggle workspace_diagnostics<cr>",
			desc = "Trouble: Toggle workspace diagnostics",
		},
		{ "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>", desc = "Trouble: Toggle document diagnostics" },
		{ "<leader>xq", "<cmd>TroubleToggle quickfix<cr>", desc = "Trouble: Toggle quickfix" },
		{ "<leader>xl", "<cmd>TroubleToggle loclist<cr>", desc = "Trouble: Toggle loclist" },
		{ "gR", "<cmd>TroubleToggle lsp_references<cr>", desc = "Trouble: Toggle LSP references" },
	},
	opts = {
		mode = "document_diagnostics",
	},
}
