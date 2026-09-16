{
  lib,
  pkgs,
  ...
}:
let
  isLinux = pkgs.stdenv.hostPlatform.isLinux;

  # Monaspace ligature sets ss01-ss10 (matching ghostty/wezterm); cv01=2
  # selects the slashed zero.
  fontFeatures = [
    "calt" # texture healing
    "liga" # spacing of repeated patterns like ///
    "ss01" # equals-family ligatures: != === =~ ~~ &=
    "ss02" # greater/less-or-equal: <= >=
    "ss03" # arrows: -> <-> --> ~> <~>
    "ss04" # markup: </ /> <!-->
    "ss05" # F# pipe operators: |> <|
    "ss06" # repeats of # + _ = &: ## ### __ ===
    "ss07" # colons: :: =:= <:
    "ss08" # period combos: ..= .- .=
    "ss09" # greater/less + equals combos: <=> >> =<<
    "ss10" # other tags: #[ #(
    "cv01=2" # slashed zero (1 plain, 2 slash, 3 reverse slash, 4 cut-out)
  ];

  yamlList = lib.concatStringsSep "\n" (map (f: "                - ${f}") fontFeatures);
in
{
  home.packages = lib.mkIf isLinux [ pkgs.contour ];

  xdg.configFile."contour/contour.yml" = lib.mkIf isLinux {
    text = ''
      # Managed by home-manager. See docs at contour-terminal.org/configuration.
      default_profile: main

      color_schemes:
        nightfox:
          default:
            background: "#192330"
            foreground: "#cdcecf"
            cursor:
              text: "#192330"
              default: "#cdcecf"
          selection:
            background: "#2b3b51"
            foreground: "#cdcecf"
          normal:
            - "#393b44"
            - "#c94f6d"
            - "#81b29a"
            - "#dbc074"
            - "#719cd6"
            - "#9d79d6"
            - "#63cdcf"
            - "#dfdfe0"
          bright:
            - "#575860"
            - "#d16983"
            - "#8ebaa4"
            - "#e0c989"
            - "#86abdc"
            - "#baa1e2"
            - "#7ad5d6"
            - "#e4e4e5"
          extended:
            16: "#f4a261"

      profiles:
        main:
          terminal_size:
            columns: 110
            lines: 35
          bell:
            sound: "off"
            alert: false
          mouse:
            hide_while_typing: true
          scrollbar:
            position: Hidden
          colors: "nightfox"
          font:
            size: 11
            locator: native
            text_shaping:
              engine: OpenShaper
            render_mode: gray
            builtin_box_drawing: true
            regular:
              family: "Monaspace Argon"
              features:
                ${yamlList}
            emoji: "emoji"
    '';
  };
}
