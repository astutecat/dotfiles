_:

{
  programs.ghostty = {
    enable = true;
    systemd.enable = false;
    package = null; # Installed externally

    settings = {
      font-family = [
        "Monaspace Argon"
        "Symbols Nerd Font Mono"
      ];
      font-feature = "calt, cv01 2";
      font-size = 11;
      font-family-italic = "Monaspace Radon";

      bell-features = "no-title";

      window-decroration = "none";

      # Nightfox colors
      background = "#192330";
      foreground = "#cdcecf";
      selection-background = "#2b3b51";
      selection-foreground = "#cdcecf";
      cursor-color = "#cdcecf";

      palette = [
        # normal
        "0=#393b44"
        "1=#c94f6d"
        "2=#81b29a"
        "3=#dbc074"
        "4=#719cd6"
        "5=#9d79d6"
        "6=#63cdcf"
        "7=#dfdfe0"
        # bright
        "8=#575860"
        "9=#d16983"
        "10=#8ebaa4"
        "11=#e0c989"
        "12=#86abdc"
        "13=#baa1e2"
        "14=#7ad5d6"
        "15=#e4e4e5"
        # extended colors
        "16=#f4a261"
      ];

      macos-option-as-alt = "left";
      keybind = [
        "alt+left=unbind"
        "alt+right=unbind"
      ];
    };
  };
}
