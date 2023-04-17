local header_content = require("headers.neovim")
local is_work_config = require("config_flags").work_config
if is_work_config then
    header_content = require("headers.entelios")
end

return {
    {
        "startup-nvim/startup.nvim",
        dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
        opts = {},
        config = function(_, _)
            require("startup").setup {
                -- every line should be same width without escaped \
                header = {
                    type = "text",
                    oldfiles_directory = false,
                    align = "center",
                    fold_section = false,
                    title = "Header",
                    margin = 0,
                    content = header_content,
                    highlight = "Type",
                    default_color = "",
                    oldfiles_amount = 0,
                },
                -- name which will be displayed and command
                body = {
                    type = "mapping",
                    oldfiles_directory = false,
                    align = "center",
                    fold_section = false,
                    title = "Basic Commands",
                    margin = 0,
                    content = {
                        { " Find File",    "Telescope find_files",            "<leader>ff" },
                        { " Find Word",    "Telescope live_grep",             "<leader>lg" },
                        { " Recent Files", "Telescope oldfiles",              "<leader>fo" },
                        { " File Browser", "Neotree toggle",                  "<leader>ee" },
                        { " New File",     "lua require'startup'.new_file()", "<leader>nf" },
                    },
                    highlight = "String",
                    default_color = "",
                    oldfiles_amount = 0,
                },

                dir_files = {
                    type = "oldfiles",
                    content = "",
                    oldfiles_directory = true,
                    align = "center",
                    fold_section = false,
                    title = "",
                    margin = 0,
                    highlight = "TSString",
                    default_color = "#FFFFFF",
                    oldfiles_amount = 10,
                },

                options = {
                    mapping_keys = true,
                    cursor_column = 0.5,
                    empty_lines_between_mappings = true,
                    disable_statuslines = true,
                    paddings = { 1, 1, 1, 1 },
                    after = function()
                        require("startup.utils").oldfiles_mappings()
                    end,
                },
                mappings = {
                    execute_command = "<CR>",
                    open_file = "o",
                    open_file_split = "<c-o>",
                    open_section = "<TAB>",
                    open_help = "?",
                },
                colors = {
                    background = "#1f2227",
                    folded_section = "#56b6c2",
                },
                parts = { "header", "body", "dir_files" },
            }
        end
    }
}
