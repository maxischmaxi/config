return {
	"olimorris/codecompanion.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
	},
	config = function()
		require("codecompanion").setup({
			opts = {
				log_level = "DEBUG",
			},
			strategies = {
				agent = { adapter = "openai" },
				chat = { adapter = "openai" },
				inline = { adapter = "openai" },
			},
			adapters = {
				openai = function()
					return require("codecompanion.adapters").extend("openai", {
						schema = {
							model = {
								default = "gpt-4o",
							},
						},
					})
				end,
			},
		})

		vim.keymap.set({ "n", "v" }, "<C-f>", "<cmd>CodeCompanionActions<cr>", { noremap = true, silent = true })
		vim.keymap.set(
			{ "n", "v" },
			"<LocalLeader>a",
			"<cmd>CodeCompanionChat Toggle<cr>",
			{ noremap = true, silent = true }
		)
		vim.keymap.set("v", "ga", "<cmd>CodeCompanionChat Add<cr>", { noremap = true, silent = true })
	end,
}
