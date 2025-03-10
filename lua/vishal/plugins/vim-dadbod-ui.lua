-- Plugin to execute databse queries
return {
	"kristijanhusak/vim-dadbod-ui",
	dependencies = {
		"tpope/vim-dotenv",
		{ "tpope/vim-dadbod", lazy = true },
		{ "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true },
	},
	cmd = {
		"DBUI",
		"DBUIToggle",
		"DBUIAddConnection",
		"DBUIFindBuffer",
	},
	init = function()
		-- DBUI configuration
		vim.g.db_ui_use_nerd_fonts = 1
		vim.g.db_ui_winwidth = 20
		vim.g.db_ui_save_location = "db"
	end,
}
