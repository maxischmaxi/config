return {
	cmd = { "vscode-eslint-language-server", "--stdio" },
	filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "vue", "svelte" },
	root_markers = { ".eslintrc", ".eslintrc.js", ".eslintrc.json", ".eslintrc.cjs", "package.json", ".git" }
}
