return {
	"neovim/nvim-lspconfig",
	opts = {
		servers = {
			cssls = { filetypes = { "css", "scss", "less", "sass", "html" } },
			cssmodules_ls = {
				filetypes = { "css", "scss", "less", "sass", "html" },
			},
			gopls = {},
			html = { filetypes = { "html", "twig", "hbs" } },
			jsonls = { filetypes = { "json", "jsonc" } },
			ltex = { ltex = { enabled = { "tex" }, language = "de-DE" } },
			lua_ls = {
				cmd = { "lua-language-server" },
				filetypes = { "lua" },
				root_markers = {
					".luarc.json",
					".luarc.jsonc",
					".luacheckrc",
					".stylua.toml",
					"stylua.toml",
					"selene.toml",
					"selene.yml",
					".git",
				},
				settings = {
					Lua = {
						telemetry = { enable = false },
						runtime = { version = "LuaJIT" },
						diagnostics = { globals = { "vim" } },
						workspace = {
							library = vim.api.nvim_get_runtime_file("", true),
							checkThirdParty = false,
						},
					},
				},
			},
			protols = { filetypes = "proto" },
			pyright = {
				cmd = { "pyright-langserver", "--stdio" },
				settings = { python = { analysis = { autoSearchPaths = true, useLibraryCodeForTypes = true } } },
				filetypes = { "python" },
			},
			rust_analyzer = { diagnostics = { refreshSupport = false } },
			stylelint_lsp = {
				filetypes = { "css", "scss", "less", "sass", "html" },
			},
			tailwindcss = {
				filetypes = {
					"html",
					"typescriptreact",
					"javascriptreact",
					"css",
				},
			},
			vtsls = {
				cmd = { "vtsls", "--stdio" },
				filetypes = {
					"javascript",
					"javascriptreact",
					"javascript.jsx",
					"typescript",
					"typescriptreact",
					"typescript.tsx",
				},
				single_file_support = true,
			},
		},
	},
	config = function(_, opts)
		local lspconfig = require("lspconfig")
		for server, config in pairs(opts.servers) do
			lspconfig[server].setup(config)
		end
	end,
}
