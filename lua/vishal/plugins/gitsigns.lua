-- Plugin to show git file modifications (add, delete) gutter signs
return {
	"lewis6991/gitsigns.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = true,
}
