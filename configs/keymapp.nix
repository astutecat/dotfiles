{ pkgs, lib, ... }:

{
  home.packages = [
    pkgs.keymapp
  ];

  # Linux: create a .desktop entry. macOS: .app bundles are handled
  # automatically by Home Manager if the package ships one.
  xdg.desktopEntries.keymapp = lib.mkIf pkgs.stdenv.isLinux {
    name = "Keymapp";
    genericName = "Keyboard Configuration Tool";
    exec = "${pkgs.keymapp}/bin/keymapp";
    icon = "keymapp";
    terminal = false;
    type = "Application";
    categories = [ "Utility" ];
    comment = "Configure ZSA ergonomic keyboards";
  };
}
