{ ... }:
{
  imports = [
    ../../home
    ../../configs/systemd.nix
  ];
  targets.genericLinux.enable = true;
}
