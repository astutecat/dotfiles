{ pkgs, ... }:

{
  home.packages = [ pkgs.yamllint ];

  xdg.configFile."yamllint/config".text = ''
    # vim: ft=yaml

    rules:
      document-start: disable
  '';
}
