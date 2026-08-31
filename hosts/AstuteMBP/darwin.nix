{ lib, username, ... }:
{
  # The platform the configuration will be used on:
  nixpkgs.hostPlatform = "aarch64-darwin";

  nix.settings.experimental-features = "nix-command flakes";

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 7;

  # Set the primary user for nix-darwin:
  system.primaryUser = username;

  # homebrew = {
  #   enable = true;
  #   onActivation = {
  #     cleanup = "zap";
  #
  #     extraFlags = [
  #       "--force-cleanup"
  #     ];
  #   };
  #
  #   taps =
  #     lib.map
  #       (tap: {
  #         name = tap;
  #         trusted = true;
  #         force_auto_update = true;
  #       })
  #       [
  #         "qmk/qmk"
  #         "osx-cross/arm" # required by qmk/qmk/qmk
  #         "osx-cross/avr" # required by qmk/qmk/qmk
  #       ];
  #
  #   brews = [
  #     "choose-gui"
  #     "qmk/qmk/qmk"
  #   ];
  #
  #   casks = [
  #   ];
  # };

  # Add ability to use TouchID for sudo authentication in terminal:
  security.pam.services.sudo_local.touchIdAuth = true;
  # This fixes Touch ID for sudo not working inside tmux and screen:
  security.pam.services.sudo_local.reattach = true;
}
