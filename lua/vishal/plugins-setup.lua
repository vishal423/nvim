local ensure_packer = function()
	local fn = vim.fn
	local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
		vim.cmd([[packadd packer.nvim]])
		return true
	end
	return false
end

local packer_bootstrap = ensure_packer() -- bootstrap packer

-- reload neovim whenever you save this file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins-setup.lua source <afile> | PackerSync
  augroup end
]])

local status, packer = pcall(require, "packer")
if not status then
	return
end

return packer.startup(function(use)
	use({ "wbthomason/packer.nvim" })

	-- lua functions that many plugins use
	use({ "nvim-lua/plenary.nvim" })

	use("bluz71/vim-nightfly-guicolors") -- preferred colorscheme
	use({ "christoomey/vim-tmux-navigator" }) -- tmux and split window navigation
	use({ "szw/vim-maximizer" }) -- maximizes and restores current window

	-- essential plugins
	use({ "tpope/vim-surround" }) -- ys w " to surround with double quotes and ds " -- delete double quotes, cs " ' -- replace with single quotes
	use({ "inkarkat/vim-ReplaceWithRegister" }) -- gw to copy a word and grw to replace the current word with copied

	-- commenting with gc
	use({ "numToStr/Comment.nvim" }) -- gcc to comment current line, gc9j to comment 9 lines

	-- file explorer
	use({ "nvim-tree/nvim-tree.lua" })

	-- icons
	use({ "nvim-tree/nvim-web-devicons" })

	-- status line
	use({ "nvim-lualine/lualine.nvim" })

	-- fuzzy finding
	use({
		"nvim-telescope/telescope-fzf-native.nvim",
		run = "make",
	})
	use({ "nvim-telescope/telescope.nvim" })

	-- auto completion
	use({ "hrsh7th/nvim-cmp" })
	use({ "hrsh7th/cmp-buffer" })
	use({ "hrsh7th/cmp-path" })

	-- snippets
	use({ "L3MON4D3/LuaSnip" })
	use({ "saadparwaiz1/cmp_luasnip" })
	use({ "rafamadriz/friendly-snippets" })

	-- managing and installing LSP servers
	use({ "williamboman/mason.nvim" })
	use({ "williamboman/mason-lspconfig.nvim" })

	-- configuring the lsp servers
	use({ "neovim/nvim-lspconfig" })
	use({ "hrsh7th/cmp-nvim-lsp" })
	use({ "glepnir/lspsaga.nvim", branch = "main" })
	-- use("jose-elias-alvarez/typescript.nvim")
	use({ "onsails/lspkind.nvim" })

	-- formatting & linting
	use({ "jose-elias-alvarez/null-ls.nvim" }) -- configure formatters & linters
	use({ "jayp0521/mason-null-ls.nvim" }) -- bridges gap b/w mason & null-ls

	-- treesitter configuration
	use({
		"nvim-treesitter/nvim-treesitter",
		run = function()
			local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
			ts_update()
		end,
	})

	-- auto closing
	use({ "windwp/nvim-autopairs" }) -- autoclose parens, brackets, quotes, etc...
	use({ "windwp/nvim-ts-autotag", after = "nvim-treesitter" }) -- autoclose tags

	-- git integration
	use({ "lewis6991/gitsigns.nvim" }) -- show line modifications on left hand side
	use({ "tpope/vim-fugitive" }) -- git operations within neovim

	-- jdtls extensions
	use({ "mfussenegger/nvim-jdtls" })

	-- Debugger support
	use({ "mfussenegger/nvim-dap" })
	-- use("nvim-telescope/telescope-ui-select.nvim")
	use({
		"rcarriga/nvim-dap-ui",
		requires = { "mfussenegger/nvim-dap" },
	})
	if packer_bootstrap then
		require("packer").sync()
	end
end)
