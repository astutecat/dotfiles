{ pkgs, ... }: {
  # Zed and its language servers are managed by home-manager; the wrapped
  # "zeditor" binary gets the language servers below on its PATH (without
  # polluting the interactive shell PATH). Extensions are still installed
  # dynamically per machine and left untouched.
  #
  # The list mirrors the language servers configured for Helix in
  # editors/helix/languages.
  programs.zed-editor = {
    enable = true;

    extraPackages = with pkgs; [
      # Global (spell/style checkers)
      typos-lsp

      # bash
      bash-language-server

      # css, html, json
      vscode-langservers-extracted

      # elixir
      beam29Packages.expert

      # erlang
      erlang-language-platform

      # gleam
      gleam

      # git-commit (gitlint via efm-langserver)
      efm-langserver

      # just
      just-lsp

      # javascript
      typescript-language-server

      # latex
      texlab

      # lua
      lua-language-server

      # markdown
      marksman

      # nickel
      nls

      # nix
      nixd
      statix

      # python
      python313Packages.jedi
      ruff
      ty

      # rust
      rust-analyzer
      rustfmt

      # toml
      taplo

      # yaml
      yamlfmt
      yaml-language-server
    ];

    userSettings = {
      format_on_save = "modifications_if_available";
      agent_servers = {
        github-copilot-cli.type = "registry";
        opencode.type = "registry";
      };

      agent = {
        sidebar_side = "right";
        dock = "right";
        favorite_models = [ ];
        model_parameters = [ ];
      };

      project_panel.dock = "left";

      icon_theme = "Zed (Default)";
      buffer_font_family = "MonoLisa";
      ui_font_size = 16;
      buffer_font_size = 12;

      preferred_line_length = 120;
      tab_size = 2;

      theme = {
        mode = "dark";
        light = "One Light";
        dark = "Nightfox - opaque";
      };

      # The only extension plumbing here: Zed fetches and updates them itself.
      # Needed so the "Nightfox - opaque" theme resolves on a fresh machine.
      auto_install_extensions = {
        nvim-nightfox = true;
      };
    };
  };
}
