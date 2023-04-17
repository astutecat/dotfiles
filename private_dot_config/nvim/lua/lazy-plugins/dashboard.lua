local header_content = require("headers.neovim")
local is_work_config = require("config_flags").work_config
if is_work_config then
    header_content = require("headers.entelios")
end


return {
    {
        "goolord/alpha-nvim",
        event = "VimEnter",
        opts = function()
            local dashboard = require("alpha.themes.dashboard")
            local logo = header_content
            dashboard.section.header.val = logo
            dashboard.section.buttons.val = {
                dashboard.button("<leader>ff", " " .. " Find file", ":Telescope find_files <CR>"),
                dashboard.button("<leader>fo", " " .. " Recent files", ":Telescope oldfiles <CR>"),
                dashboard.button("<leader>lg", " " .. " Find text", ":Telescope live_grep <CR>"),
                -- dashboard.button("s", "勒" .. " Restore Session", [[:lua require("persistence").load() <cr>]]),
                dashboard.button("l", "鈴" .. " Lazy", ":Lazy<CR>"),
                dashboard.button("q", " " .. " Quit", ":qa<CR>"),
            }
            for _, button in ipairs(dashboard.section.buttons.val) do
                button.opts.hl = "AlphaButtons"
                button.opts.hl_shortcut = "AlphaShortcut"
            end
            dashboard.section.footer.opts.hl = "Type"
            dashboard.section.header.opts.hl = "AlphaHeader"
            dashboard.section.buttons.opts.hl = "AlphaButtons"
            dashboard.opts.layout[1].val = 8
            return dashboard
        end,
        config = function(_, dashboard)
            -- close Lazy and re-open when the dashboard is ready
            if vim.o.filetype == "lazy" then
                vim.cmd.close()
                vim.api.nvim_create_autocmd("User", {
                    pattern = "AlphaReady",
                    callback = function()
                        require("lazy").show()
                    end,
                })
            end

            require("alpha").setup(dashboard.opts)

            vim.api.nvim_create_autocmd("User", {
                pattern = "LazyVimStarted",
                callback = function()
                    local stats = require("lazy").stats()
                    local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
                    dashboard.section.footer.val = "⚡ Neovim loaded " .. stats.count .. " plugins in " .. ms .. "ms"
                    pcall(vim.cmd.AlphaRedraw)
                end,
            })
        end,
    }
}
