return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    event = "BufEnter",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
      "folke/snacks.nvim",
    },
    opts = {
      enable_git_status = true,
      source_selector = {
        winbar = true,
        sources = {
          { source = "filesystem", display_name = "  󰉓  " },
          { source = "buffers", display_name = "  󱔘  " },
          { source = "git_status", display_name = " 󰊢  " },
        },
      },
      window = {
        width = 30,
        mappings = {
          ["Y"] = function(state)
            local node = state.tree:get_node()
            local filepath = node:get_id()
            local filename = node.name
            local modify = vim.fn.fnamemodify

            local results = {
              filepath,
              modify(filepath, ":."),
              modify(filepath, ":~"),
              filename,
              modify(filename, ":r"),
              modify(filename, ":e"),
            }

            vim.ui.select({
              "1. Absolute path: " .. results[1],
              "2. Path relative to CWD: " .. results[2],
              "3. Path relative to HOME: " .. results[3],
              "4. Filename: " .. results[4],
              "5. Filename without extension: " .. results[5],
              "6. Extension of the filename: " .. results[6],
            }, { prompt = "Choose to copy to clipboard:" }, function(choice)
              local i = tonumber(choice:sub(1, 1))
              local result = results[i]
              vim.fn.setreg('"', result)
              vim.notify("Copied: " .. result)
            end)
          end,
        },
      },
      filesystem = {
        group_empty_dirs = true,
        use_libuv_file_watcher = true,
        filtered_items = {
          hide_gitignored = false,
          always_show = {
            ".gitignore",
            ".envrc",
            ".pre-commit-config.yaml",
            ".editorconfig",
            ".envrc",
            ".tool-versions",
            ".moon",
            ".chezmoiremove",
            ".chezmoiignore",
            ".chezmoiexternal.toml",
            ".chezmoidata",
            ".chezmoitemplates",
            ".gitlint",
            ".envrc",
            ".editorconfig",
            ".ignore",
            ".github",
          },
        },
      },
      buffers = {
        group_empty_dirs = false,
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
          StaticMethod = { icon = "󰠄 ", hl = "Function" },
        },
      },
      default_component_configs = {
        icon = {
          folder_empty = "󰜌",
          folder_empty_open = "󰜌",
          default = "",
        },
        git_status = {
          symbols = {
            renamed = "󰁕",
            unstaged = "󰄱",
          },
        },
        modified = {
          symbol = "",
        },
      },
      event_handlers = {
        {
          event = "neo_tree_window_after_open",
          handler = function(_)
            pcall(vim.cmd([[wincmd =]]))
          end,
        },
        {
          event = "neo_tree_window_after_close",
          handler = function(_)
            pcall(vim.cmd([[wincmd =]]))
          end,
        },
      },
    },
    config = function(_, opts)
      vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])

      local mappings = {
        {
          "<leader>ee",
          "<cmd>Neotree toggle<cr>",
          mode = { "n" },
          description = "Neotree: Toggle (left split)",
        },
        {
          "<leader>ew",
          "<cmd>Neotree toggle position=current<cr>",
          mode = { "n" },
          description = "Neotree: Toggle netrw style",
        },
        {
          "<leader>err",
          "<cmd>Neotree reveal<cr>",
          mode = { "n" },
          description = "Neotree: Reveal File",
        },
        {
          "<leader>erw",
          "<cmd>Neotree reveal position=current<cr>",
          mode = { "n" },
          description = "Neotree: Reveal File netrw style",
        },
      }
      require("legendary").keymaps(mappings)
      local wk = require("which-key")
      wk.add({ "<Leader>e", group = "explore" })
      require("neo-tree").setup(opts)
    end,
  },
}
