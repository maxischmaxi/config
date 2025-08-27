local uv = vim.uv or vim.loop

local function file_exists(filepath)
	return filepath and uv.fs_stat(filepath) ~= nil
end

local function get_root()
	local buf = vim.api.nvim_get_current_buf()
	for _, client in pairs(vim.lsp.get_clients({ bufnr = buf })) do
		local ws = client.config.workspace_folders
		if ws and ws[1] and ws[1].name then
			return ws[1].name
		end
		if client.config.root_dir then
			return client.config.root_dir
		end
	end
	return vim.fn.getcwd()
end

local function has_eslint_config(root)
	if not root or root == "" then
		return false
	end
	local candidates = {
		".eslintrc",
		".eslintrc.js",
		".eslintrc.cjs",
		".eslintrc.mjs",
		".eslintrc.json",
		".eslintrc.yaml",
		".eslintrc.yml",
	}
	for _, name in ipairs(candidates) do
		if file_exists(root .. "/" .. name) then
			return true
		end
	end

	local pkg = root .. "/package.json"
	if file_exists(pkg) then
		local ok, lines = pcall(vim.fn.readfile, pkg)
		if ok then
			local content = table.concat(lines, "\n")
			local okj, json = pcall(vim.json.decode, content)
			if okj and type(json) == "table" and json.eslintConfig ~= nil then
				return true
			end
		end
	end
	return false
end

return {
	"mhartington/formatter.nvim",
	config = function()
		local eslint_ft_js = require("formatter.filetypes.javascript").eslint_d
		local eslint_ft_ts = require("formatter.filetypes.typescript").eslint_d
		local prettier_ft_js = require("formatter.filetypes.javascript").prettierd
		local prettier_ft_ts = require("formatter.filetypes.typescript").prettierd
		local react_ft_js = require("formatter.filetypes.javascriptreact").eslint_d
		local react_ft_ts = require("formatter.filetypes.typescriptreact").eslint_d
		local prettier_ft_reactjs = require("formatter.filetypes.javascriptreact").prettierd
		local prettier_ft_reactts = require("formatter.filetypes.typescriptreact").prettierd

		require("formatter").setup({
			logging = true,
			log_level = vim.log.levels.WARN,
			filetype = {
				lua = {
					require("formatter.filetypes.lua").stylua,
				},
				rust = {
					require("formatter.filetypes.rust").rustfmt,
				},
				xhtml = {
					require("formatter.filetypes.xhtml").tidy,
				},
				html = {
					require("formatter.filetypes.html").prettierd,
				},
				javascript = {
					prettier_ft_js,
					function()
						if has_eslint_config(get_root()) then
							return eslint_ft_js()
						end
						return nil
					end,
				},
				typescript = {
					prettier_ft_ts,
					function()
						if has_eslint_config(get_root()) then
							return eslint_ft_ts()
						end
						return nil
					end,
				},
				javascriptreact = {
					prettier_ft_reactjs,
					function()
						if has_eslint_config(get_root()) then
							return react_ft_js()
						end
						return nil
					end,
				},
				typescriptreact = {
					prettier_ft_reactts,
					function()
						if has_eslint_config(get_root()) then
							return react_ft_ts()
						end
						return nil
					end,
				},
				go = {
					require("formatter.filetypes.go").gofmt,
					require("formatter.filetypes.go").goimports,
				},
				css = {
					function()
						if file_exists("stylelint.config.mjs") then
							return {
								exe = "stylelint",
								try_node_modules = true,
								no_append = false,
								args = {
									"--config",
									"stylelint.config.mjs",
									"--fix",
								},
								stdin = true,
							}
						end

						return nil
					end,
					require("formatter.filetypes.css").prettierd,
				},
				json = {
					require("formatter.filetypes.json").jq,
					require("formatter.filetypes.json").prettierd,
				},
			},
		})
		local augroup = vim.api.nvim_create_augroup
		local autocmd = vim.api.nvim_create_autocmd

		augroup("__formatter__", { clear = true })
		autocmd("BufWritePost", {
			group = "__formatter__",
			callback = function()
				if not vim.fn.expand("%"):match("^oil://") and not vim.fn.expand("%"):match("^fugitive://") then
					vim.cmd("FormatWrite")
				end
			end,
		})
		autocmd("BufWritePre", {
			pattern = "*",
			command = [[:%s/\u00a0/ /ge]],
		})
	end,
}
