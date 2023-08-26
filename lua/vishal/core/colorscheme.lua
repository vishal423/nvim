-- local status, _ = pcall(vim.cmd, "colorscheme nightfly")
local status, _ = pcall(vim.cmd, "colorscheme nightfox")
if not status then
	print("Colorscheme not found")
	return
end
local api = vim.api

-- play with background to be transparent
api.nvim_set_hl(0, "Normal", { bg = "none" })
api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
-- api.nvim_set_hl(0, "DiffAdd", { bg = "#B2F5EA", fg = "#234E52" })
-- api.nvim_set_hl(0, "DiffDelete", { bg = "#FED7D7", fg = "#742A2A" })
-- api.nvim_set_hl(0, "DiffChange", { bg = "#FED7E2", fg = "#702459" })
-- api.nvim_set_hl(0, "DiffText", { bg = "#BEE3F8", fg = "#2A4365" })
-- api.nvim_set_hl(0, "Whitespace", { fg = "#d3c7bb" })
