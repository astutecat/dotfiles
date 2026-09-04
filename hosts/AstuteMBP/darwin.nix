{ username, ... }:
{
  # The platform the configuration will be used on:
  nixpkgs.hostPlatform = "aarch64-darwin";

  nix.settings = {
    experimental-features = "nix-command flakes";

    trusted-users = [ username ];

    substituters = [
      "https://cache.nixos.org/"
      "https://nix-community.cachix.org"
    ];

    trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };

  # Root-level garbage collection via launchd (the user-level systemd timer in
  # services/nix-gc.nix only applies to Linux hosts).
  nix.gc = {
    automatic = true;
    interval = {
      Hour = 3;
      Minute = 0;
    };
    options = "--delete-older-than 30d";
  };

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 7;

  # Set the primary user for nix-darwin:
  system.primaryUser = username;

  homebrew = {
    enable = true;
    onActivation = {
      cleanup = "zap";

      extraFlags = [
        "--force-cleanup"
      ];
    };

    # taps =
    #   lib.map
    #     (tap: {
    #       name = tap;
    #       trusted = true;
    #       force_auto_update = true;
    #     })
    #     [
    #       "qmk/qmk"
    #       "osx-cross/arm" # required by qmk/qmk/qmk
    #       "osx-cross/avr" # required by qmk/qmk/qmk
    #     ];

    brews = [
      # "choose-gui"
      # "qmk/qmk/qmk"
      # "qman"
    ];

    casks = [
      "raycast"
      "rstudio"
      "1password-cli"
      "r-app"
      "anki"
      "calibre"
      "dangerzone"
      "ghostty"
      "qflipper"
      "gqrx"
      "skim"
      "scribus"
      "trackerzapper"
      "josm"
    ];
  };

  # Add ability to use TouchID for sudo authentication in terminal:
  security.pam.services.sudo_local.touchIdAuth = true;
  # This fixes Touch ID for sudo not working inside tmux and screen:
  security.pam.services.sudo_local.reattach = true;
}
