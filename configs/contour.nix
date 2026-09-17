{
  lib,
  pkgs,
  ...
}:
let
  isLinux = pkgs.stdenv.hostPlatform.isLinux;

  # Iosevka's default zero is already slashed, so no OpenType features
  # (Monaspace's ss01-ss10 / cv01 sets only apply to Monaspace).
  fontFeatures = [ ];

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
              family: "Iosevka Extended"
              features:
                ${yamlList}
            italic:
              family: "Iosevka Extended"
            emoji: "emoji"
    '';
  };
}
