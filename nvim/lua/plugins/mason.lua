return {
    "williamboman/mason.nvim",
    config = function()
        require("mason").setup({
            ui = {
                icons = {
                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = "✗",
                },
            },
            install_root_dir = vim.fn.stdpath("data") .. "/mason",
            PATH = "prepend",
            log_level = vim.log.levels.INFO,
            max_concurrent_installers = 4,
            registries = { "github:mason-org/mason-registry" },
            providers = {
                "mason.providers.registry-api",
                "mason.providers.client",
            },
            github = {
                download_url_template = "https://github.com/%s/releases/download/%s/%s",
            },
            pip = { upgrade_pip = false, install_args = {} },
            diagnostic = { refreshSupport = true },
        })
    end,
}
