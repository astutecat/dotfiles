{
  # Zed itself is managed outside home-manager (e.g. via its own updater or
  # Homebrew); only the core user settings are managed here. Extensions are
  # installed dynamically per machine and left untouched.
  programs.zed-editor = {
    enable = true;
    package = null;

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
