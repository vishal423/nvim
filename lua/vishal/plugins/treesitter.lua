-- Plugin to configure treesitter
return {
	{
		"nvim-treesitter/nvim-treesitter",
		event = { "BufReadPre", "BufNewFile" },
		build = ":TSUpdate",
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
		},
		config = function()
			local treesitter = require("nvim-treesitter.configs")
			treesitter.setup({
				highlight = {
					enable = true,
				},
				indent = { enable = true },
				autotag = {
					enable = true,
				},
				ensure_installed = {
					"json",
					"yaml",
					"markdown",
					"markdown_inline",
					"bash",
					"lua",
					"vim",
					"gitignore",
					"java",
				},
				incremental_selection = {
					enable = true,
					keymaps = {
						init_selection = "<C-space>",
						node_incremental = "<C-space>",
						scope_incremental = false,
						node_decremental = "<bs>",
					},
				},
			})
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-context",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
		},
		config = true,
	},
	{
		"JoosepAlviste/nvim-ts-context-commentstring",
		config = true,
	},
}
