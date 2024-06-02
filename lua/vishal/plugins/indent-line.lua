-- Plugin to show indent guidelines
return {
	"lukas-reineke/indent-blankline.nvim",
	event = { "BufReadPre", "BufNewFile" },
	main = "ibl",
	opts = {},
	-- opts = {
	-- 	indent = { char = "|" },
	-- },
}
