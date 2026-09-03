{ pkgs, ... }:
{
  home.packages = with pkgs; [
    restic
  ];
  services.restic = {
    enable = true;
  };
}
