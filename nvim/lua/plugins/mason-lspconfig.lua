return {
	"williamboman/mason-lspconfig.nvim",
	dependencies = { "williamboman/mason.nvim", "neovim/nvim-lspconfig" },
	config = function()
		require("mason-lspconfig").setup({
			automatic_enable = true,
			ensure_installed = {
				"cssls",
				"cssmodules_ls",
				"gopls",
				"html",
				"jsonls",
				"ltex",
				"lua_ls",
				"protols",
				"pyright",
				"rust_analyzer",
				"stylelint_lsp",
				"tailwindcss",
				"vtsls",
			},
		})
	end,
}
