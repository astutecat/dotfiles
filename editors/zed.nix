_: {
  # LSPs live in ./lsp.nix (shared with Helix).
  programs.zed-editor = {
    enable = true;

    package = null;

    userSettings = {
      format_on_save = "modifications_if_available";
      cli_default_open_behavior = "existing_window";
      restore_on_startup = "launchpad";
      indent_guides.coloring = "indent_aware";
      toolbar.code_actions = true;
      which_key.enabled = true;
      show_edit_predictions = true;
      telemetry = {
        diagnostics = false;
        metrics = false;
      };
      git_panel.dock = "left";
      outline_panel.dock = "left";
      languages.Erlang.show_edit_predictions = true;
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
      buffer_font_family = "Monaspace Argon";
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
