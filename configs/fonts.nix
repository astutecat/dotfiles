{
  pkgs,
  schemar-private-fonts,
  ...
}:
let
  isLinux = pkgs.stdenv.hostPlatform.isLinux;
in
{
  home.packages = [
    pkgs.b612
    pkgs.ibm-plex
    pkgs.noto-fonts-color-emoji
    pkgs.monaspace
    pkgs.nerd-fonts.symbols-only

    schemar-private-fonts.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];

  # Linux: let fontconfig discover fonts installed through home.packages.
  # (macOS is handled automatically: home-manager copies profile fonts to
  # ~/Library/Fonts/HomeManager via targets.darwin.)
  fonts.fontconfig.enable = isLinux;
}
