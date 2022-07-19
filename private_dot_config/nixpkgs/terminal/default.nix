{ pkgs, workConfig ? false, ... }:

{
  imports = [
    (import ./zsh.nix {inherit pkgs; inherit workConfig;})
  ];
}
