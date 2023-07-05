local status, telescope = pcall(require, "telescope")
if not status then
	return
end

local actions_setup, actions = pcall(require, "telescope.actions")
if not actions_setup then
	return
end

telescope.setup({
	defaults = {
		dynamic_preview_title = true,
		layout_strategy = "vertical",
		layout_config = {
			vertical = {
				width = 0.95,
				height = 0.95,
				preview_height = 0.4,
				prompt_position = "bottom",
			},
		},
		mappings = {
			i = {
				["<C-k>"] = actions.move_selection_previous,
				["<C-j>"] = actions.move_selection_next,
				["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
			},
		},
	},
	-- extensions = {
	-- 	["ui-select"] = {
	-- 		themes.get_dropdown({
	-- 			-- even more opts
	-- 		}),
	--
	-- 		-- pseudo code / specification for writing custom displays, like the one
	-- 		-- for "codeactions"
	-- 		-- specific_opts = {
	-- 		--   [kind] = {
	-- 		--     make_indexed = function(items) -> indexed_items, width,
	-- 		--     make_displayer = function(widths) -> displayer
	-- 		--     make_display = function(displayer) -> function(e)
	-- 		--     make_ordinal = function(e) -> string
	-- 		--   },
	-- 		--   -- for example to disable the custom builtin "codeactions" display
	-- 		--      do the following
	-- 		--   codeactions = false,
	-- 		-- }
	-- 	},
	-- },
})

telescope.load_extension("fzf")
-- telescope.load_extension("ui-select")
