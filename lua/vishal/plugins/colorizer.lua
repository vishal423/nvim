-- Plugin to show colours from hex colour codes within nvim editor
return {
	"NvChad/nvim-colorizer.lua",
	event = { "BufReadPre", "BufNewFile" },
	config = true,
}
