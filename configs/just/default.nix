{ pkgs, ... }:
{
  xdg.configFile."just/justfile".source = ./justfile;
  home.packages = with pkgs; [ just ];
}
