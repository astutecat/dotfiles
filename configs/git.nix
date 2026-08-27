{ pkgs, ... }:

{
  home.packages = [
    pkgs.git
    pkgs.delta
  ];
}
