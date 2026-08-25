{
  pkgs,
  ...
}:
let
  isDarwin = pkgs.stdenv.hostPlatform.isDarwin;
in
{
  programs = {
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
  };
  services.lorri.enable = (!isDarwin);
}
