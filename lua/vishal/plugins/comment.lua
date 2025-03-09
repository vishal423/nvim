-- Plugin to generate file-type specific comment blocks
return {
	"numToStr/Comment.nvim",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"JoosepAlviste/nvim-ts-context-commentstring",
	},
	config = function()
		require("Comment").setup({
			pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
		})

		-- Override to support plsql file types
		local ft = require("Comment.ft")
		ft.plsql = { "--%s", "/*%s*/" }
	end,
}
