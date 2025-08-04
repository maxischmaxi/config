local function file_exists(filepath)
    local f = io.open(filepath, "r")
    if f ~= nil then
        io.close(f)
        return true
    else
        return false
    end
end

return {
    "mhartington/formatter.nvim",
    config = function()
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
                    require("formatter.filetypes.html").htmlbeautifier,
                },
                javascript = {
                    require("formatter.filetypes.javascript").prettierd,
                    require("formatter.filetypes.javascript").eslint_d,
                },
                typescript = {
                    require("formatter.filetypes.typescript").prettierd,
                    require("formatter.filetypes.typescript").eslint_d,
                },
                javascriptreact = {
                    require("formatter.filetypes.javascriptreact").prettierd,
                    require("formatter.filetypes.javascriptreact").eslint_d,
                },
                typescriptreact = {
                    require("formatter.filetypes.typescriptreact").prettierd,
                    require("formatter.filetypes.typescriptreact").eslint_d,
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
