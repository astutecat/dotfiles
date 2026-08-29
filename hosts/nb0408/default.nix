{ ... }:
{
  imports = [
    ../../home
    ../../configs/sway
    ../../configs/systemd.nix
  ];
  targets.genericLinux.enable = true;
}
