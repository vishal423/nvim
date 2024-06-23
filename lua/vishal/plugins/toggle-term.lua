-- Plugin to improve terminal experience within neovim
return {
	"akinsho/toggleterm.nvim",
	version = "*",
	config = function()
		local term = require("toggleterm")
		term.setup({
			open_mapping = [[tt]],
			direction = "float",
		})
	end,
}
