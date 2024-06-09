-- Plugin to decorate tab window and show diagnostics errors
return {
	"akinsho/bufferline.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	version = "*",
	opts = {
		options = {
			mode = "tabs",
			separator_style = "slant",
			-- diagnostics = "nvim_lsp",
			-- diagnostics_indicator = function(count, level, diagnostics_dict, context)
			-- 	local icon = level:match("error") and " " or " "
			-- 	return " " .. icon .. count
			-- end,
		},
	},
}
