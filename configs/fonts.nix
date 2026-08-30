{
  pkgs,
  lib,
  ...
}:
let
  isLinux = pkgs.stdenv.hostPlatform.isLinux;

  # Fonts that have no nixpkgs package, vendored from the former
  # chezmoi dot_local/share/fonts directory.
  miscFonts = pkgs.stdenvNoCC.mkDerivation {
    name = "misc-fonts";
    dontUnpack = true;
    dontBuild = true;
    installPhase = ''
      mkdir -p $out/share/fonts/truetype/misc
      install -m644 ${./fonts/AppleColorEmoji-Linux.ttf} $out/share/fonts/truetype/misc/AppleColorEmoji-Linux.ttf
      install -m644 ${./fonts/codicon.ttf} $out/share/fonts/truetype/misc/codicon.ttf
    '';
  };

  # Replaces run_after_download_fonts.zsh (gh release download of
  # ryanoasis/nerd-fonts): IosevkaTerm, Monaspace, Iosevka,
  # NerdFontsSymbolsOnly, Noto.
  nerdFonts = with pkgs.nerd-fonts; [
    iosevka
    iosevka-term
    monaspace
    noto
    symbols-only
  ];
in
{
  home.packages = [
    miscFonts
    pkgs.b612
    pkgs.ibm-plex
    pkgs.noto-fonts-color-emoji
  ]
  ++ nerdFonts;

  # Linux: let fontconfig discover fonts installed through home.packages.
  # (macOS is handled automatically: home-manager copies profile fonts to
  # ~/Library/Fonts/HomeManager via targets.darwin.)
  fonts.fontconfig.enable = isLinux;
}
