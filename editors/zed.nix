_:
let
  # Monaspace gates its ligatures behind stylistic sets ss01-ss10
  # (matching ghostty/contour/wezterm); cv01 = 2 selects the slashed zero.
  # Zed takes an OpenType feature map (bool or index value).
  monaspaceFeatures = {
    ss01 = true; # equals-family ligatures: != === =~ ~~ &=
    ss02 = true; # greater/less-or-equal: <= >=
    ss03 = true; # arrows: -> <-> --> ~> <~>
    ss04 = true; # markup: </ /> <!-->
    ss05 = true; # F# pipe operators: |> <|
    ss06 = true; # repeats of # + _ = &: ## ### __ ===
    ss07 = true; # colons: :: =:= <:
    ss08 = true; # period combos: ..= .- .=
    ss09 = true; # greater/less + equals combos: <=> >> =<<
    ss10 = true; # other tags: #[ #(
    cv01 = 2; # slashed zero (1 plain, 2 slash, 3 reverse slash, 4 cut-out)
  };
in
{
  # LSPs live in ./lsp.nix (shared with Helix).
  programs.zed-editor = {
    enable = true;

    package = null;

    userSettings = {
      use_system_prompts = false;
      language_models.opencode = {
        show_zen_models = false;
        show_go_models = false;
      };
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
        opencode = {
          type = "registry";
          default_config_options = {
            model = "opencode-go/glm-5.3-flash";
          };
        };
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
      buffer_font_features = monaspaceFeatures;
      ui_font_size = 16;
      buffer_font_size = 12;

      terminal = {
        font_family = "Monaspace Argon";
        # Same feature map for the built-in terminal.
        font_features = monaspaceFeatures;
      };

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
        elixir = true;
        erlang = true;
        html = true;
        just = true;
        latex = true;
        nickel = true;
        nix = true;
        rainbow-csv = true;
        ssh-config = true;
      };
    };
  };
}
