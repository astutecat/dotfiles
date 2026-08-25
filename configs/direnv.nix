{ ... }:

{
  programs = {
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
  };
  services.lorri.enable = true;
}
