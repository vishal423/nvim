-- Plugin to toggle (minimize, maximize) a split window
return {
	"szw/vim-maximizer",
	keys = {
		{ "<leader>wm", "<cmd>MaximizerToggle<CR>", desc = "Maximize/minimize a split" },
	},
}
