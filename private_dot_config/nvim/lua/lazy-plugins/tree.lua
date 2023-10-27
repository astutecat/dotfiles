return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    event = "BufEnter",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    opts = {
      enable_git_status = true,
      source_selector = {
        winbar = true,
        sources = {
          { source = "filesystem", display_name = "  󰉓  " },
          { source = "buffers",    display_name = "  󱔘  " },
          { source = "git_status", display_name = " 󰊢  " },
        },
      },
      window = {
        width = 30
      },
      filesystem = {
        group_empty_dirs = true,
        use_libuv_file_watcher = true,
        filtered_items = {
          always_show = {
            ".gitignore",
            ".envrc",
            ".pre-commit-config.yaml",
            ".editorconfig",
            ".envrc",
            ".tool-versions",
            ".moon"
          },
        }
      },
      buffers = {
        group_empty_dirs = true
      },
      document_symbols = {
        kinds = {
          File = { icon = "󰈙", hl = "Tag" },
          Namespace = { icon = "󰌗", hl = "Include" },
          Package = { icon = "󰏖", hl = "Label" },
          Class = { icon = "󰌗", hl = "Include" },
          Property = { icon = "󰆧", hl = "@property" },
          Enum = { icon = "󰒻", hl = "@number" },
          Function = { icon = "󰊕", hl = "Function" },
          String = { icon = "󰀬", hl = "String" },
          Number = { icon = "󰎠", hl = "Number" },
          Array = { icon = "󰅪", hl = "Type" },
          Object = { icon = "󰅩", hl = "Type" },
          Key = { icon = "󰌋", hl = "" },
          Struct = { icon = "󰌗", hl = "Type" },
          Operator = { icon = "󰆕", hl = "Operator" },
          TypeParameter = { icon = "󰊄", hl = "Type" },
          StaticMethod = { icon = '󰠄 ', hl = 'Function' },
        }
      },
      default_component_configs = {
        icon = {
          folder_empty = "󰜌",
          folder_empty_open = "󰜌",
          default = '',
        },
        git_status = {
          symbols = {
            renamed  = "󰁕",
            unstaged = "󰄱",
          },
        },
        modified = {
          symbol = '',
        }
      },
      event_handlers = {
        {
          event = "neo_tree_window_after_open",
          handler = function(_)
            pcall(vim.cmd [[wincmd =]])
          end
        },
        {
          event = "neo_tree_window_after_close",
          handler = function(_)
            pcall(vim.cmd [[wincmd =]])
          end
        }
      }
    },
    config = function(_, opts)
      vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])

      local mappings = {
        {
          "<leader>ee",
          "<cmd>Neotree toggle<cr>",
          mode = { 'n' },
          description = "Neotree: Toggle (left split)"
        },
        {
          "<leader>ew",
          "<cmd>Neotree toggle position=current<cr>",
          mode = { 'n' },
          description = "Neotree: Toggle netrw style"
        },
        {
          "<leader>err",
          "<cmd>Neotree reveal<cr>",
          mode = { 'n' },
          description = "Neotree: Reveal File"
        },
        {
          "<leader>erw",
          "<cmd>Neotree reveal position=current<cr>",
          mode = { 'n' },
          description = "Neotree: Reveal File netrw style"
        }
      }
      require('legendary').keymaps(mappings)

      vim.fn.sign_define("DiagnosticSignError",
        { text = " ", texthl = "DiagnosticSignError" })
      vim.fn.sign_define("DiagnosticSignWarn",
        { text = " ", texthl = "DiagnosticSignWarn" })
      vim.fn.sign_define("DiagnosticSignInfo",
        { text = " ", texthl = "DiagnosticSignInfo" })
      vim.fn.sign_define("DiagnosticSignHint",
        { text = "󰌵", texthl = "DiagnosticSignHint" })
      require("neo-tree").setup(opts)
    end
  },

}
