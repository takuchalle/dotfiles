vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
	use { "wbthomason/packer.nvim", opt = true }
	use "rstacruz/vim-closer"

	-- LSP
	use 'neovim/nvim-lspconfig'
	use {
		'williamboman/mason.nvim',
		run = ":MasonUpdate"
	}
	use 'williamboman/mason-lspconfig.nvim'

	use "hrsh7th/nvim-cmp"
	use "hrsh7th/cmp-nvim-lsp"
	use "hrsh7th/vim-vsnip"

	use "olimorris/onedarkpro.nvim"
end)

