-- Configure sonarlint for Java applications
return {
	"https://gitlab.com/schrieveslaach/sonarlint.nvim",
	dependencies = { "vishal423/nvim-jdtls", branch="junit-diag-feedback" },
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		require("sonarlint").setup({
			server = {
				cmd = {
					"sonarlint-language-server",
					"-stdio",
					"-analyzers",
					vim.fn.expand("$MASON/share/sonarlint-analyzers/sonarjava.jar"),
				},
			},
			filetypes = {
				"java",
			},
		})
	end,
}
