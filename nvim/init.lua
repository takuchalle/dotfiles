require "base"
require "plugins"

vim.cmd("colorscheme onedark")

local on_attach = function(client, bufnr)
	local set = vim.keymap.set
	set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>")
	set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>")
	set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>")
	set("n", "g]", "<cmd>lua vim.diagnostic.goto_next()<CR>")
	set("n", "g[", "<cmd>lua vim.diagnostic.goto_prev()<CR>")
	set("n", "K", vim.lsp.buf.hover)
	set("n", "<space>f", function()
		vim.lsp.buf.format { async = true }
	end)
end

local capabilities = require('cmp_nvim_lsp').default_capabilities()

require("cmp").setup()
require("mason").setup()
require("mason-lspconfig").setup()
require("mason-lspconfig").setup_handlers {
	function(server_name)
		require("lspconfig")[server_name].setup {
			on_attach = on_attach,
			capabilites = capabilities
		}
	end
}
