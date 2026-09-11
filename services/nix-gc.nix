{ pkgs, lib, ... }:

# User-level garbage collection for Linux hosts via home-manager's nix.gc
# module. On Darwin, root-level GC runs via nix-darwin's nix.gc (see
# hosts/AstuteMBP/darwin.nix) instead, since a user launchd agent can't collect
# daemon-owned store paths.
lib.mkIf pkgs.stdenv.hostPlatform.isLinux {
  nix.gc = {
    automatic = true;
    dates = "daily";
    randomizedDelaySec = "1h";
    options = "--delete-older-than 30d";
  };
}
