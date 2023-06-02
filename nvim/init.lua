require "base"
require "plugins"

vim.cmd("colorscheme onedark")

local on_attach = function(client, bufnr)
	local set = vim.keymap.set
	set("n", "gD", vim.lsp.buf.declaration())
	set("n", "gd", vim.lsp.buf.definition())
	set("n", "gi", vim.lsp.buf.implementation())
	set("n", "g]", vim.diagnostic.goto_next())
	set("n", "g[", vim.diagnostic.goto_prev())
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
