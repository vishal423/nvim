local lspconfig_status, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status then
	return
end

local cmp_nvim_lsp_status, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not cmp_nvim_lsp_status then
	return
end

-- local typescript_setup, typescript = pcall(require, "typescript")
-- if not typescript_setup then
-- 	return
-- end

local module = {}
-- enable keybind for available lsp server
local on_attach = function(client, bufnr)
	local opts = { noremap = true, silent = false, buffer = bufnr }

	local keymap = vim.keymap
	-- set keybinds
	keymap.set("n", "gf", "<cmd>Lspsaga lsp_finder<CR>", opts)
	keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
	keymap.set("n", "gd", "<cmd>Lspsaga peek_definition<CR>", opts)
	keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
	keymap.set("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", opts)
	keymap.set("n", "<leader>rn", "<cmd>Lspsaga rename<CR>", opts)
	keymap.set("n", "<leader>D", "<cmd>Lspsaga show_line_diagnostics<CR>", opts)
	keymap.set("n", "<leader>d", "<cmd>Lspsaga show_cursor_diagnostics<CR>", opts)
	keymap.set("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts)
	keymap.set("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts)
	keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>", opts)
	keymap.set("n", "<leader>o", "<cmd>Lspsaga LSoutlineToggle<CR>", opts)

	-- if client.name == "tsserver" then
	-- 	keymap.set("n", "<leader>rf", ":TypescriptRenameFile<CR>")
	-- 	keymap.set("n", "<leader>oi", ":TypescriptOrganizeImports<CR>") -- organize imports (not in youtube nvim video)
	-- 	keymap.set("n", "<leader>ru", ":TypescriptRemoveUnused<CR>") -- remove unused variables (not in youtube nvim video)
	-- end
	print(client.name)
	if client.name == "jdtls" then
		keymap.set("n", "<A-o>", "<cmd>lua require'jdtls'.organize_imports()<CR>", opts)
		keymap.set("n", "crv", "<cmd>lua require'jdtls'.extract_variable()<CR>", opts)
		keymap.set("n", "crc", "<cmd>lua require'jdtls'.extract_constant()<CR>", opts)
		keymap.set("n", "crm", "<cmd>lua require'jdtls'.extract_method()<CR>", opts)

		keymap.set("n", "<leader>db", "<cmd>lua require'dap'.toggle_breakpoint()<CR>", opts)
		keymap.set("n", "<leader>dc", "<cmd>lua require'dap'.continue()<CR>", opts)
		keymap.set("n", "<leader>di", "<cmd>lua require'dap'.step_into()<CR>", opts)
		keymap.set("n", "<leader>do", "<cmd>lua require'dap'.step_over()<CR>", opts)
		keymap.set("n", "<leader>dO", "<cmd>lua require'dap'.step_out()<CR>", opts)
		keymap.set("n", "<leader>dr", "<cmd>lua require'dap'.repl.toggle()<CR>", opts)
		keymap.set("n", "<leader>dl", "<cmd>lua require'dap'.run_last()<CR>", opts)
		keymap.set("n", "<leader>du", "<cmd>lua require'dapui'.toggle()<CR>", opts)
		keymap.set("n", "<leader>dx", "<cmd>lua require'dap'.terminate()<CR>", opts)

		keymap.set("n", "<leader>df", "<cmd>lua require'jdtls'.test_class()<CR>", opts)
		keymap.set("n", "<leader>dn", "<cmd>lua require'jdtls'.test_nearest_method()<CR>", opts)

		require("jdtls").setup_dap({ hotcodereplace = "auto" })
		require("jdtls.dap").setup_dap_main_class_configs()
	end
end

module.on_attach = on_attach

local capabilities = cmp_nvim_lsp.default_capabilities()

-- lspconfig["html"].setup({
-- 	capabilities = capabilities,
-- 	on_attach = on_attach,
-- })
--
-- typescript.setup({
-- 	server = {
-- 		capabilities = capabilities,
-- 		on_attach = on_attach,
-- 	},
-- })
--
-- lspconfig["cssls"].setup({
-- 	capabilities = capabilities,
-- 	on_attach = on_attach,
-- })
--
-- lspconfig["tailwindcss"].setup({
-- 	capabilities = capabilities,
-- 	on_attach = on_attach,
-- })

-- configure emmet language server
lspconfig["emmet_ls"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
	filetypes = { "javascript" },
})

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

return module
