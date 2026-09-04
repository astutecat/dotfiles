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
  services.lorri.enable = !isDarwin;
  home.sessionVariables = {
    DIRENV_WARN_TIMEOUT = "1m";
  };
}
