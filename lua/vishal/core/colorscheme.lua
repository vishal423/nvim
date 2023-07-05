local status, _ = pcall(vim.cmd, "colorscheme nightfly")
if not status then
	print("Colorscheme not found")
	return
end

local api = vim.api

-- play with background to be transparent
api.nvim_set_hl(0, "Normal", { bg = "none" })
api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
