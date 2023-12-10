return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		"mfussenegger/nvim-jdtls",
		{ "antosha417/nvim-lsp-file-operations", config = true },
	},
	config = function()
		-- import lspconfig plugin
		local lspconfig = require("lspconfig")

		-- import cmp-nvim-lsp plugin
		local cmp_nvim_lsp = require("cmp_nvim_lsp")

		local keymap = vim.keymap -- for conciseness

		local opts = { noremap = true, silent = true }
		local on_attach = function(client, bufnr)
			opts.buffer = bufnr

			-- set keybinds
			opts.desc = "Show LSP references"
			keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts) -- show definition, references

			opts.desc = "Go to declaration"
			keymap.set("n", "gD", vim.lsp.buf.declaration, opts) -- go to declaration

			opts.desc = "Show LSP definitions"
			keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts) -- show lsp definitions

			opts.desc = "Show LSP implementations"
			keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts) -- show lsp implementations

			opts.desc = "Show LSP type definitions"
			keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts) -- show lsp type definitions

			opts.desc = "See available code actions"
			keymap.set({ "n", "v" }, "<leader>ca", "<cmd>Lspsaga code_action<CR>", opts) -- see available code actions, in visual mode will apply to selection

			opts.desc = "Smart rename"
			keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts) -- smart rename

			opts.desc = "Show buffer diagnostics"
			keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts) -- show  diagnostics for file

			opts.desc = "Show line diagnostics"
			keymap.set("n", "<leader>d", "<cmd>Lspsaga show_line_diagnostics<CR>", opts) -- show diagnostics for line

			opts.desc = "Go to previous diagnostic"
			keymap.set("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts) -- jump to previous diagnostic in buffer

			opts.desc = "Go to next diagnostic"
			keymap.set("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts) -- jump to next diagnostic in buffer

			opts.desc = "Show documentation for what is under cursor"
			keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>", opts) -- show documentation for what is under cursor

			opts.desc = "Restart LSP"
			keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts) -- mapping to restart lsp if necessary

			if client.name == "jdtls" then
				opts.desc = "Java: Organize imports"
				keymap.set("n", "<A-o>", "<cmd>lua require'jdtls'.organize_imports()<CR>", opts)

				opts.desc = "Java: Extract Variable"
				keymap.set("n", "crv", "<cmd>lua require'jdtls'.extract_variable()<CR>", opts)

				opts.desc = "Java: Extract Constant"
				keymap.set("n", "crc", "<cmd>lua require'jdtls'.extract_constant()<CR>", opts)

				opts.desc = "Java: Extract Method"
				keymap.set("n", "crm", "<cmd>lua require'jdtls'.extract_method()<CR>", opts)

				opts.desc = "Debug: Toggle breakpoint"
				keymap.set("n", "<leader>db", "<cmd>lua require'dap'.toggle_breakpoint()<CR>", opts)

				opts.desc = "Debug: Continue execution"
				keymap.set("n", "<leader>dc", "<cmd>lua require'dap'.continue()<CR>", opts)

				opts.desc = "Debug: Step into method"
				keymap.set("n", "<leader>di", "<cmd>lua require'dap'.step_into()<CR>", opts)

				opts.desc = "Debug: Step over method"
				keymap.set("n", "<leader>do", "<cmd>lua require'dap'.step_over()<CR>", opts)

				opts.desc = "Debug: Step out method"
				keymap.set("n", "<leader>dO", "<cmd>lua require'dap'.step_out()<CR>", opts)

				opts.desc = "Debug: Toggle REPL"
				keymap.set("n", "<leader>dr", "<cmd>lua require'dap'.repl.toggle()<CR>", opts)

				opts.desc = "Java: Run last"
				keymap.set("n", "<leader>dl", "<cmd>lua require'dap'.run_last()<CR>", opts)

				opts.desc = "Java: Run all tests"
				keymap.set("n", "<leader>du", "<cmd>lua require'dapui'.toggle()<CR>", opts)

				opts.desc = "Java: Run all tests"
				keymap.set("n", "<leader>dx", "<cmd>lua require'dap'.terminate()<CR>", opts)

				opts.desc = "Java: Run all tests"
				keymap.set("n", "<leader>df", "<cmd>lua require'jdtls'.test_class()<CR>", opts)

				opts.desc = "Java: Run test near to cursor"
				keymap.set("n", "<leader>dn", "<cmd>lua require'jdtls'.test_nearest_method()<CR>", opts)
			end
		end

		-- used to enable autocompletion (assign to every lsp server config)
		local capabilities = cmp_nvim_lsp.default_capabilities()

		-- Change the Diagnostic symbols in the sign column (gutter)
		-- (not in youtube nvim video)
		local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
		for type, icon in pairs(signs) do
			local hl = "DiagnosticSign" .. type
			vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
		end

		-- configure html server
		lspconfig["html"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
		})

		-- configure css server
		lspconfig["cssls"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
		})

		-- configure tailwindcss server
		lspconfig["tailwindcss"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
		})

		-- configure svelte server
		lspconfig["svelte"].setup({
			capabilities = capabilities,
			on_attach = function(client, bufnr)
				on_attach(client, bufnr)

				vim.api.nvim_create_autocmd("BufWritePost", {
					pattern = { "*.js", "*.ts" },
					callback = function(ctx)
						if client.name == "svelte" then
							client.notify("$/onDidChangeTsOrJsFile", { uri = ctx.file })
						end
					end,
				})
			end,
		})

		-- configure emmet language server
		lspconfig["emmet_ls"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
			filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "svelte" },
		})

		-- configure lua server (with special settings)
		lspconfig["lua_ls"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
			settings = { -- custom settings for lua
				Lua = {
					-- make the language server recognize "vim" global
					diagnostics = {
						globals = { "vim" },
					},
					workspace = {
						-- make language server aware of runtime files
						library = {
							[vim.fn.expand("$VIMRUNTIME/lua")] = true,
							[vim.fn.stdpath("config") .. "/lua"] = true,
						},
					},
				},
			},
		})
		return on_attach
	end,
}
