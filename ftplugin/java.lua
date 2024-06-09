local opt = vim.opt_local
opt.shiftwidth = 4
opt.tabstop = 4
opt.cmdheight = 1
opt.colorcolumn = "100"
opt.wildignore = "*.class"

local home = os.getenv("HOME")
WORKSPACE_PATH = home .. "/workspace/"

local jdtls = require("jdtls")
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local workspace_dir = WORKSPACE_PATH .. project_name

-- Find project root
local root_markers = { ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }
local root_dir = require("jdtls.setup").find_root(root_markers)
if root_dir == "" then
	print("Project root directory not found")
	return
end

local extendedClientCapabilities = jdtls.extendedClientCapabilities
extendedClientCapabilities.resolveAdditionalTextEditsSupport = true

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

local cmd = {
	home .. "/.sdkman/candidates/java/17.0.5-amzn/bin/java",
	"-Declipse.application=org.eclipse.jdt.ls.core.id1",
	"-Dosgi.bundles.defaultStartLevel=4",
	"-Declipse.product=org.eclipse.jdt.ls.core.product",
	"-Dlog.protocol=true",
	"-Dlog.level=ALL",
	"-javaagent:" .. home .. "/.local/share/nvim/mason/packages/jdtls/lombok.jar",
	"-Xms1g",
	"-Xmx2g",
	"--add-modules=ALL-SYSTEM",
	"--add-opens",
	"java.base/java.util=ALL-UNNAMED",
	"--add-opens",
	"java.base/java.lang=ALL-UNNAMED",
	"-jar",
	vim.fn.glob(home .. "/.local/share/nvim/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_*.jar"),
	"-configuration",
	home .. "/.local/share/nvim/mason/packages/jdtls/config_linux",
	"-data",
	workspace_dir,
}

local config = {
	autostart = true,
	cmd = cmd,
	capabilities = capabilities,
	root_dir = root_dir,
	settings = {
		java = {
			eclipse = {
				downloadSources = true,
			},
			maven = {
				downloadSources = true,
			},
			implementationsCodeLens = {
				enabled = true,
			},
			referencesCodeLens = {
				enabled = true,
			},
			references = {
				includeDecompiledSources = true,
			},
			inlayHints = {
				parameterNames = {
					enabled = "all", -- literals, all, none
				},
			},
			format = {
				enabled = false,
			},
			configuration = {

				updateBuildConfiguration = "interactive",
				runtimes = {
					-- {
					-- 	name = "JavaSE-1.8",
					-- 	path = "/opt/jdk1.8.0_202/",
					-- },
					{
						name = "JavaSE-17",
						path = home .. "/.sdkman/candidates/java/17.0.5-amzn/",
					},
				},
			},
			signatureHelp = { enabled = true },
			completion = {
				favoriteStaticMembers = {
					"org.mockito.Mockito.*",
					"org.junit.jupiter.api.Assertions.*",
					"java.util.Objects.requireNonNull",
					"java.util.Objects.requireNonNullElse",
				},
				filteredTypes = {
					"com.sun.*",
					"io.micrometer.shaded.*",
					"java.awt.*",
					"jdk.*",
					"sun.*",
				},
				importOrder = {
					"com",
					"org",
					"javax",
					"java",
				},
			},
			contentProvider = { preferred = "fernflower" },
		},
		extendedClientCapabilities = extendedClientCapabilities,
		sources = {
			organizeImports = {
				starThreshold = 5,
				staticStarThreshold = 3,
			},
		},
		codeGeneration = {
			toString = {
				template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
			},
			hashCodeEquals = {
				useJava7Objects = true,
			},
			useBlocks = true,
		},
	},
	flags = {
		allow_incremental_sync = true,
	},
}

-- configure java debugger
local bundles = {}

vim.list_extend(bundles, vim.split(vim.fn.glob(home .. "/.config/java-dap/vscode-java-test/server/*.jar"), "\n"))
vim.list_extend(
	bundles,
	vim.split(
		vim.fn.glob(
			home
				.. "/.config/java-dap/java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar",
			1
		),
		"\n"
	)
)

config["init_options"] = {
	bundles = bundles,
	extendedClientCapabilities = extendedClientCapabilities,
}

-- register java debugger
config["on_attach"] = function(_, bufnr)
	require("vishal.plugins.lsp.lspconfig").on_attach(_, bufnr)
	require("vishal.plugins.dap").on_attach(_, bufnr)

	local keymap = vim.keymap -- for conciseness
	local opts = { noremap = true, silent = true, buffer = bufnr }

	opts.desc = "Java: Organize imports"
	keymap.set("n", "<leader>oi", "<cmd>lua require'jdtls'.organize_imports()<CR>", opts)

	opts.desc = "Java: Extract Variable"
	keymap.set("n", "<leader>ev", "<cmd>lua require'jdtls'.extract_variable()<CR>", opts)

	opts.desc = "Java: Extract Constant"
	keymap.set("n", "<leader>ec", "<cmd>lua require'jdtls'.extract_constant()<CR>", opts)

	opts.desc = "Java: Extract Method"
	keymap.set("n", "<leader>em", "<cmd>lua require'jdtls'.extract_method()<CR>", opts)

	opts.desc = "Java: Run all tests"
	keymap.set("n", "<leader>df", "<cmd>lua require'jdtls'.test_class()<CR>", opts)

	opts.desc = "Java: Run test near to cursor"
	keymap.set(
		"n",
		"<leader>dn",
		"<cmd>lua require'jdtls'.test_nearest_method({ config_overrides = { vmArgs = \"--add-exports=java.base/com.sun.crypto.provider=ALL-UNNAMED --add-opens=java.base/java.util=ALL-UNNAMED\" } })<CR>",
		opts
	)

	opts.desc = "Java: Generate Test Class"
	keymap.set("n", "<leader>gtc", "<cmd>lua require'jdtls.tests'.generate()<CR>", opts)

	opts.desc = "Java: Toggle between Implementation and Tests"
	keymap.set("n", "<leader>ti", "<cmd>lua require'jdtls.tests'.goto_subjects()<CR>", opts)

	require("jdtls").setup_dap({ hotcodereplace = "auto" })
	require("jdtls.dap").setup_dap_main_class_configs()
end

jdtls.start_or_attach(config)
