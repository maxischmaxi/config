vim.g.mapleader = " "
vim.g.loaded_perl_provider = 0
vim.g.maplocalleader = " "

local vimOptions = {
	wrap = true,
	expandtab = true,
	hlsearch = true,
	mouse = "a",
	breakindent = true,
	undofile = true,
	ignorecase = true,
	smartcase = true,
	updatetime = 250,
	timeoutlen = 300,
	completeopt = "menuone,noselect",
	scrolloff = 12,
	fillchars = { fold = " " },
	foldmethod = "indent",
	foldenable = false,
	foldlevel = 99,
	cursorline = false,
	termguicolors = true,
	clipboard = "unnamedplus",
	tabstop = 4,
	shiftwidth = 4,
	softtabstop = 4,
	autoindent = true,
	smartindent = false,
}

local windowOptions = {
	number = true,
	signcolumn = "yes",
	relativenumber = false,
}

for k, v in pairs(vimOptions) do
	vim.opt[k] = v
end

for k, v in pairs(windowOptions) do
	vim.wo[k] = v
end

vim.diagnostic.config({
	underline = true,
	virtual_text = { source = "if_many", spacing = 2 },
	signs = true,
	update_in_insert = false,
	severity_sort = true,
})
