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
	use({ "wbthomason/packer.nvim", commit = "64ae65fea395d8dc461e3884688f340dd43950ba" })

	-- lua functions that many plugins use
	use({ "nvim-lua/plenary.nvim", commit = "4b7e52044bbb84242158d977a50c4cbcd85070c7" })

	use("bluz71/vim-nightfly-guicolors") -- preferred colorscheme
	use({ "christoomey/vim-tmux-navigator", commit = "41ea9d23b814014c8d8daf8b44fa0cd827a0e5f4" }) -- tmux and split window navigation
	use({ "szw/vim-maximizer", commit = "2e54952fe91e140a2e69f35f22131219fcd9c5f1" }) -- maximizes and restores current window

	-- essential plugins
	use({ "tpope/vim-surround", commit = "3d188ed2113431cf8dac77be61b842acb64433d9" }) -- ys w " to surround with double quotes and ds " -- delete double quotes, cs " ' -- replace with single quotes
	use({ "inkarkat/vim-ReplaceWithRegister", commit = "aad1e8fa31cb4722f20fe40679caa56e25120032" }) -- gw to copy a word and grw to replace the current word with copied

	-- commenting with gc
	use({ "numToStr/Comment.nvim", commit = "5f01c1a89adafc52bf34e3bf690f80d9d726715d" }) -- gcc to comment current line, gc9j to comment 9 lines

	-- file explorer
	use({ "nvim-tree/nvim-tree.lua", commit = "0cd8ac4751c39440a1c28c6be4704f3597807d29" })

	-- icons
	use({ "nvim-tree/nvim-web-devicons", commit = "05e1072f63f6c194ac6e867b567e6b437d3d4622" })

	-- status line
	use({ "nvim-lualine/lualine.nvim", commit = "bfa0d99ba6f98d077dd91779841f1c88b7b5c165" })

	-- fuzzy finding
	use({
		"nvim-telescope/telescope-fzf-native.nvim",
		run = "make",
		commit = "ae9d95da9ff5669eb8e35f758fbf385b3e2fb7cf",
	})
	use({ "nvim-telescope/telescope.nvim", branch = "0.1.x", commit = "0b1c41ad8052badca6e72eafa4bc5481152e483e" })

	-- auto completion
	use({ "hrsh7th/nvim-cmp", commit = "8bbaeda725d5db6e4e1be2867a64b43bf547cf06" })
	use({ "hrsh7th/cmp-buffer", commit = "3022dbc9166796b644a841a02de8dd1cc1d311fa" })
	use({ "hrsh7th/cmp-path", commit = "91ff86cd9c29299a64f968ebb45846c485725f23" })

	-- snippets
	use({ "L3MON4D3/LuaSnip", commit = "8b25e74761eead3dc47ce04b5e017fd23da7ad7e" })
	use({ "saadparwaiz1/cmp_luasnip", commit = "18095520391186d634a0045dacaa346291096566" })
	use({ "rafamadriz/friendly-snippets", commit = "2379c6245be10fbf0ebd057f0d1f89fe356bf8bc" })

	-- managing and installing LSP servers
	use({ "williamboman/mason.nvim", commit = "2668bbd9427d9edddcaf42b0fd06be3a3cf373d8" })
	use({ "williamboman/mason-lspconfig.nvim", commit = "e8bd50153b94cc5bbfe3f59fc10ec7c4902dd526" })

	-- configuring the lsp servers
	use({ "neovim/nvim-lspconfig", commit = "cbf8762f15fac03a51eaa2c6f983d4a5045c95b4" })
	use({ "hrsh7th/cmp-nvim-lsp", commit = "59224771f91b86d1de12570b4070fe4ad7cd1eeb" })
	use({ "glepnir/lspsaga.nvim", branch = "main", commit = "b7b4777369b441341b2dcd45c738ea4167c11c9e" })
	-- use("jose-elias-alvarez/typescript.nvim")
	use({ "onsails/lspkind.nvim", commit = "c68b3a003483cf382428a43035079f78474cd11e" })

	-- formatting & linting
	use({ "jose-elias-alvarez/null-ls.nvim", commit = "5d8e925d31d8ef8462832308c016ac4ace17597a" }) -- configure formatters & linters
	use({ "jayp0521/mason-null-ls.nvim", commit = "0fcc40394b8d0f525a8be587268cbfac3e70a5bc" }) -- bridges gap b/w mason & null-ls

	-- treesitter configuration
	use({
		"nvim-treesitter/nvim-treesitter",
		commit = "507527711fdd8f701544024aeb1a9a068f986d89",
		run = function()
			local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
			ts_update()
		end,
	})

	-- auto closing
	use({ "windwp/nvim-autopairs", commit = "9fa996123031b4cad100bd5afad04384a622c8a7" }) -- autoclose parens, brackets, quotes, etc...
	use({ "windwp/nvim-ts-autotag", after = "nvim-treesitter" }) -- autoclose tags

	-- git integration
	use({ "lewis6991/gitsigns.nvim", commit = "683187285385a0dde6c62e2e6b16e325effdcf04" }) -- show line modifications on left hand side

	-- jdtls extensions
	use({ "mfussenegger/nvim-jdtls", commit = "69ad133ef7296b26f6f05ed5d0960628fbb15a83" })

	-- Debugger support
	use({ "mfussenegger/nvim-dap", commit = "68d96871118a13365f3c33e4838990030fff80ec" })
	-- use("nvim-telescope/telescope-ui-select.nvim")
	use({
		"rcarriga/nvim-dap-ui",
		commit = "54365d2eb4cb9cfab0371306c6a76c913c5a67e3",
		requires = { "mfussenegger/nvim-dap" },
	})
	if packer_bootstrap then
		require("packer").sync()
	end
end)
