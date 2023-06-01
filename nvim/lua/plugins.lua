vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
	use { "wbthomason/packer.nvim", opt = true }
	use {
		"rstacruz/vim-closer",
	}
end)

