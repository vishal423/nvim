local M

local attach_to_debug = function()
	local dap = require("dap")
	dap.configurations.java = {
		{
			type = "java",
			request = "attach",
			name = "Attach to Java Application",
			hostName = "localhost",
			port = "5005",
		},
	}
	dap.continue()
end

local launch_to_debug = function()
	local dap = require("dap")
	dap.configurations.java = {
		{
			type = "java",
			request = "launch",
			name = "Launch Java Application",
			vmArgs = "-Dspring.profiles.active=local",
		},
	}
	dap.continue()
end

local launch_to_debug17 = function()
	local dap = require("dap")
	dap.configurations.java = {
		{
			type = "java",
			request = "launch",
			name = "Launch Java Application",
			vmArgs = "--add-exports=java.base/com.sun.crypto.provider=ALL-UNNAMED -Dspring.profiles.active=local",
		},
	}
	dap.continue()
end

local on_attach = function(_, bufnr)
	local keymap = vim.keymap -- for conciseness
	local opts = { noremap = true, silent = true, buffer = bufnr }

	opts.desc = "Debug: Attach debugger"
	keymap.set("n", "<leader>da", attach_to_debug, opts)

	opts.desc = "Debug: Launch debugger"
	keymap.set("n", "<F5>", launch_to_debug, opts)

	opts.desc = "Debug: Launch debugger JRE 17"
	keymap.set("n", "<leader>ds", launch_to_debug17, opts)

	opts.desc = "Debug: Toggle breakpoint"
	keymap.set("n", "<leader>db", "<cmd>lua require'dap'.toggle_breakpoint()<CR>", opts)

	opts.desc = "Debug: Continue execution"
	keymap.set("n", "<F9>", "<cmd>lua require'dap'.continue()<CR>", opts)

	opts.desc = "Debug: Step into method"
	keymap.set("n", "<F7>", "<cmd>lua require'dap'.step_into()<CR>", opts)

	opts.desc = "Debug: Step over method"
	keymap.set("n", "<F8>", "<cmd>lua require'dap'.step_over()<CR>", opts)

	opts.desc = "Debug: Step out method"
	keymap.set("n", "<F10>", "<cmd>lua require'dap'.step_out()<CR>", opts)

	opts.desc = "Debug: Toggle REPL"
	keymap.set("n", "<leader>dr", "<cmd>lua require'dap'.repl.toggle()<CR>", opts)

	opts.desc = "Java: Run last"
	keymap.set("n", "<leader>dl", "<cmd>lua require'dap'.run_last()<CR>", opts)

	opts.desc = "Java: Toggle DAP UI"
	keymap.set("n", "<leader>du", "<cmd>lua require'dapui'.toggle()<CR>", opts)

	opts.desc = "Java: Terminate debug session"
	keymap.set("n", "<leader>dx", "<cmd>lua require'dap'.terminate()<CR>", opts)
end

M = {
	"mfussenegger/nvim-dap",
	event = { "BufReadPre", "BufNewFile" },
	ft = "java",
	dependencies = {
		"rcarriga/nvim-dap-ui",
	},
	config = function()
		local dap = require("dap")
		local dapui = require("dapui")

		dapui.setup({
			icons = { expanded = "▾", collapsed = "▸" },
			mappings = {
				-- Use a table to apply multiple mappings
				expand = { "<CR>", "<2-LeftMouse>" },
				open = "o",
				remove = "d",
				edit = "e",
				repl = "r",
				toggle = "t",
			},
			expand_lines = vim.fn.has("nvim-0.7"),
			layouts = {
				{
					elements = {
						-- Elements can be strings or table with id and size keys.
						{ id = "scopes", size = 0.25 },
						-- "breakpoints",
						-- "stacks",
						-- "watches",
					},
					size = 30, -- 30 columns
					position = "right",
				},
				{
					elements = {
						{ id = "repl", size = 0.25 },
						"console",
					},
					size = 0.25, -- 25% of total lines
					position = "bottom",
				},
			},
			floating = {
				max_height = nil, -- These can be integers or a float between 0 and 1.
				max_width = nil, -- Floats will be treated as percentage of your screen.
				border = "single", -- Border style. Can be "single", "double" or "rounded"
				mappings = {
					close = { "q", "<Esc>" },
				},
			},
			windows = { indent = 1 },
			render = {
				max_type_length = nil, -- Can be integer or nil.
			},
		})

		dap.listeners.after.event_initialized["dapui_config"] = function()
			dapui.open({})
		end
		dap.listeners.before.event_terminated["dapui_config"] = function()
			dapui.close({})
		end
		dap.listeners.before.event_exited["dapui_config"] = function()
			dapui.close({})
		end
	end,
}

M.on_attach = on_attach
return M
