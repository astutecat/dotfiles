{ pkgs, workConfig ? false, ... }:
with pkgs;
with lib;
let
  inherit (lib) optionalString optionals;
  withBeam = !workConfig;

  maybe_elixir_config = optionalString withBeam ''
    nvim_lsp.erlangls.setup({
      on_attach = on_attach,
      capabilities = capabilities,
    })
    nvim_lsp.elixirls.setup({
      on_attach = on_attach,
      capabilities = capabilities,
      cmd = { "${elixir_ls.out}/bin/elixir-ls" },
    })
  '';

  maybe_work_mappings =
    lib.optionalString workConfig "${builtins.readFile ./mappings_work.vim}";

  de_utf8_spell_file = builtins.fetchurl {
    url = "http://ftp.vim.org/vim/runtime/spell/de.utf-8.spl";
    sha256 = "1ld3hgv1kpdrl4fjc1wwxgk4v74k8lmbkpi1x7dnr19rldz11ivk";
  };

  my_plugins = import ./my_plugins.nix pkgs;

in
{

  home.file.".config/nvim/spell/de.utf-8.spl".source = de_utf8_spell_file;

  home.packages = with pkgs;
    [
      shellcheck
      rnix-lsp
      nodePackages.markdownlint-cli
      rust-analyzer
      nodePackages.vscode-css-languageserver-bin
      yaml-language-server
      statix
      yamllint
      ripgrep
      fd
      fzy
      tree-sitter
      yamllint
      dprint
      nixfmt
      universal-ctags
      proselint
      par
      curl
    ] ++ optionals stdenv.isLinux [ gcc ] ++ optionals stdenv.isDarwin [ ]
    ++ optionals withBeam [ elixir_ls erlang-ls ];

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    withNodeJs = true;

    plugins = with pkgs.vimPlugins;
      with my_plugins;
      [
        # Themes
        nightfox-nvim

        {
          plugin = indent-blankline-nvim;
          type = "lua";
          config = builtins.readFile ./indent-blankline.lua;
        }

        {
          plugin = vim-vsnip;
          config = builtins.readFile ./vsnip.vim;
        }

        vim-vsnip-integ

        cmp-buffer
        cmp-nvim-lsp
        cmp-path
        cmp-vsnip
        cmp-nvim-tags
        cmp-treesitter
        cmp-cmdline
        cmp-latex-symbols
        lspkind-nvim
        lsp-status-nvim
        {
          plugin = lsp_lines-nvim;
          type = "lua";
          config = builtins.readFile ./lsplines.lua;
        }
        {
          plugin = nvim-cmp;
          type = "lua";
          config = builtins.readFile ./cmp.lua;
        }
        {
          # plugin = nvim-treesitter.withPlugins (plugins:
          #   with plugins; [
          #     nix
          #     python
          #     bash
          #     elixir
          #     erlang
          #     lua
          #     rust
          #     yaml
          #     css
          #     html
          #     json
          #     vim
          #     hcl
          #     toml
          #     make
          #     regex
          #     ocaml
          #     r
          #     cpp
          #     javascript
          #   ]);
          plugin = nvim-treesitter.withAllGrammars;
          type = "lua";
          config = builtins.readFile ./treesitter.lua;
        }
        {
          plugin = nvim-lspconfig;
          type = "lua";
          config = ''
            ${builtins.readFile ./lspconfig.lua}
            ${maybe_elixir_config}
            nvim_lsp.rnix.setup({
              on_attach = on_attach,
              capabilities = capabilities,
              cmd = { "${pkgs.rnix-lsp.out}/bin/rnix-lsp" },
            })
            nvim_lsp.cssls.setup({
              on_attach = on_attach,
              capabilities = capabilities,
              cmd = { "${pkgs.nodePackages.vscode-css-languageserver-bin.out}/bin/css-languageserver" }
            })
          '';
        }
        {
          plugin = nvim-navic;
          type = "lua";
          config = builtins.readFile ./navic.lua;
        }

        {
          plugin = null-ls-nvim;
          type = "lua";
          config = ''
            local null_ls = require("null-ls")
            local builtins = null_ls.builtins
            local markdownlint = builtins.diagnostics.markdownlint.with({
              extra_args = {"--disable", "MD013"},
            })
              null_ls.setup({
                sources = {
                  builtins.code_actions.gitrebase,
                  builtins.code_actions.shellcheck,
                  builtins.code_actions.statix,
                  builtins.code_actions.proselint,
                  builtins.diagnostics.chktex,
                  builtins.diagnostics.shellcheck,
                  builtins.diagnostics.statix,
                  builtins.diagnostics.trail_space,
                  builtins.diagnostics.yamllint,
                  builtins.diagnostics.zsh,
                  markdownlint,
                  builtins.formatting.nixfmt,
                  builtins.formatting.rustfmt,
                  builtins.formatting.trim_whitespace,
          '' + lib.optionalString withBeam ''
            builtins.formatting.erlfmt,
            builtins.formatting.mix,'' + ''
              },
            })
          '';
        }

        plenary-nvim
        {
          plugin = telescope-nvim;
          type = "lua";
          config = builtins.readFile ./telescope.lua;
        }
        {
          plugin = project-nvim;
          type = "lua";
          config = builtins.readFile ./project-nvim.lua;
        }

        PreserveNoEOL
        vim-signature
        vim-commentary
        vim-surround
        vim-unimpaired
        vim-sort-motion
        {
          plugin = vim-lion;
          config = ''
            let g:lion_create_maps    = 1
            let g:lion_squeeze_spaces = 1
            let g:lion_map_right      = 'ga'
            let g:lion_map_left       = 'gA'
          '';
        }

        {
          plugin = which-key-nvim;
          type = "lua";
          config = ''
            require("which-key").setup {}
          '';
        }
        vim-numbertoggle
        auto-pairs
        splitjoin-vim
        {
          plugin = nvim-tree-lua;
          type = "lua";
          config = builtins.readFile ./nvim-tree.lua;
        }

        # Languages
        vim-nix
        rust-vim
        vim-elixir

        BufOnly-vim
        # vim-gutentags
        friendly-snippets
        vim-devicons
        {
          plugin = nvim-web-devicons;
          type = "lua";
          config = ''
            require'nvim-web-devicons'.setup {
            -- your personnal icons can go here (to override)
            -- DevIcon will be appended to `name`
            -- override = {
            --  zsh = {
            --    icon = "",
            --    color = "#428850",
            --    name = "Zsh"
            --    }
            --  };
            -- globally enable default icons (default to false)
            -- will get overriden by `get_icons` option
            default = true;
            }
          '';
        }
        bclose-vim
        {
          plugin = todo-comments-nvim;
          type = "lua";
          config = builtins.readFile ./todo-comments.lua;
        }
        {
          plugin = vimtex;
          config = builtins.readFile ./vimtex.vim;
        }

        {
          plugin = vim-togglelist;
          config = ''
            let g:toggle_list_no_mappings = 1
            nmap <script> <silent> <leader>o <cmd>call ToggleLocationList()<CR>
            nmap <script> <silent> <leader>q <cmd>call ToggleQuickfixList()<CR>
          '';
        }
        # Utils
        vim-fugitive # Git wrapper
        {
          plugin = lualine-nvim;
          type = "lua";
          config = builtins.readFile ./lualine.lua;
        }
        {
          plugin = fzf-vim;
          config = ''
            let g:fzf_preview_window = ""
            let g:fzf_preview_window = ['right:50%', 'ctrl-/']
            nnoremap <silent> <C-p> :Files<CR>
            nnoremap <silent> <A-p> :Rg<CR>
          '';
        }
        {
          plugin = nclipper-vim;
          config = ''
            let g:nclipper_nomap = 1
            vmap <M-y> <Plug>(nclipper)
            vmap <C-y> <Plug>(nclipper-with-filename)
          '';
        }
        vim-mercenary

        {
          plugin = nvim-hlslens;
          type = "lua";
          config = builtins.readFile ./hlslens.lua;
        }

        {
          plugin = nvim-scrollbar;
          type = "lua";
          config = ''
            require("scrollbar").setup()
            require("scrollbar.handlers.search").setup()
          '';
        }

        {
          plugin = vim-polyglot;
          config = ''
            let g:polyglot_disabled = ["autoindent"]
          '';
        }
        vim-gutentags
        # vim-wakatime
        {
          plugin = vimspector;
          type = "lua";
          config = builtins.readFile ./vimspector.lua;
        }
        {
          plugin = nvim-treesitter-endwise;
          type = "lua";
          config = ''
            require('nvim-treesitter.configs').setup {
              endwise = {
                  enable = true,
              },
            }
          '';
        }
        tabular
        vim-markdown
        {
          plugin = vim-lengthmatters;
          config = ''
            let g:lengthmatters_on_by_default = 0
            let g:lengthmatters_start_at_column = 100
          '';
        }
        vim-rfc
        vim-sleuth
        promise-async
        {
          plugin = nvim-ufo;
          type = "lua";
          config = builtins.readFile ./nvim-ufo.lua;
        }
        vim-swap

      ] ++ optionals workConfig [ vim-erlang-runtime ];

    extraPackages = [ ];

    extraConfig = ''
      ${builtins.readFile ./functions.vim}
      ${builtins.readFile ./extra.vim}
      ${builtins.readFile ./mappings.vim}
      ${maybe_work_mappings}
      ${builtins.readFile ./spell.vim}
    '';
  };
}
