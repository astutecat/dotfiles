{ pkgs, ... }:

{
  home.packages = [
    pkgs.git
    pkgs.delta
    pkgs.difftastic
  ];
}
