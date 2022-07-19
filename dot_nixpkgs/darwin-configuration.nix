{ config, pkgs, ... }:

with pkgs;

let inherit (lib) optionals;
in {

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with darwin.apple_sdk.frameworks; [
    wxmac
    neovim
    curl
    wget
    fd
    fzy
    silver-searcher
    ripgrep
    elixir
    erlangR25
    direnv
    chezmoi
    CoreFoundation
    CoreServices
    nix-prefetch-git
    git
    nmap
    neofetch
    rsync
    socat
    tree-sitter
    pinentry_mac
    jq
    zsh
    m-cli
    rustup
  ];

  # Use a custom configuration.nix location.
  # $ darwin-rebuild switch -I darwin-config=$HOME/.config/nixpkgs/darwin/configuration.nix
  # environment.darwinConfig = "$HOME/.config/nixpkgs/darwin/configuration.nix";

  # Create /etc/bashrc that loads the nix-darwin environment.
  programs.bash.enable = true;
  programs.zsh.enable = true;
  programs.fish.enable = true;
  programs.zsh.promptInit = "";
  programs.nix-index.enable = true;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;

  services.nix-daemon.enable = true;

  # You should generally set this to the total number of logical cores in your system.
  # $ sysctl -n hw.ncpu
  nix.settings = {
    max-jobs = 8;
    cores = 8;
    trusted-users = [ "root" "astutecat" ];
    auto-optimise-store = true;
    substituters = [ "https://nix-community.cachix.org/" ];
    trusted-substituters = [ "https://nix-community.cachix.org/" ];
    trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };

  nix.gc = {
    automatic = true;
    options = "--delete-older-than 7d";
  };
  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '' + lib.optionalString (pkgs.system == "aarch64-darwin") ''
    extra-platforms = x86_64-darwin aarch64-darwin
  '';

  homebrew = {
    enable = true;
    brewPrefix = "/opt/homebrew/bin";
    brews = [
      "coreutils"
      "wakeonlan"
      "sops"
      "age"
      "openssl@1.1"
      "readline"
      "python3"
      "gnupg"
      "microk8s"
      "kubernetes-cli"
      "qmk"
      # QMK deps start
      "avrdude"
      "bootloadhid"
      "clang-format"
      "dfu-programmer"
      "dfu-util"
      "hidapi"
      "libusb"
      "make"
      "mdloader"
      "osx-cross/arm/arm-gcc-bin@8"
      "osx-cross/avr/avr-gcc@8"
      "pillow"
      "python"
      "teensy_loader_cli"
      "julia"
      # QMK deps end
    ];
    taps = [
      "homebrew/cask"
      "ubuntu/microk8s"
      "saulpw/vd"
      "homebrew/cask-drivers"
      "qmk/qmk"
      "osx-cross/avr"
      "osx-cross/arm"
    ];
    casks = [
      "gpg-suite-no-mail"
      "r"
      "rstudio"
      "skim"
      "trackerzapper"
      "calibre"
      "dangerzone"
      "1password-cli"
      "mattermost"
      "tla-plus-toolbox"
      "multipass"
      "vlc"
      "qmk-toolbox"
    ];
  };
  homebrew.onActivation.cleanup = "zap";
  homebrew.onActivation.upgrade = true;
  homebrew.global.autoUpdate = false;
}
