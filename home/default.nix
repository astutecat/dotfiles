{
  pkgs,
  username,
  homeDirectory,
  ...
}:
let
  isDarwin = pkgs.stdenv.hostPlatform.isDarwin;
in
{
  imports = [
    ../configs/atuin.nix
    ../configs/direnv.nix
    ../configs/fastfetch.nix
    ../configs/nh.nix
    ../configs/tealdeer.nix
    ../configs/topgrade.nix
    ../configs/pert.nix
    ../configs/tfg.nix
    ../configs/imhex.nix
    ../configs/cheat.nix
  ];
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = username;
  home.homeDirectory = homeDirectory;

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "26.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages =
    with pkgs;
    [
      adrs
      age
      babelfish
      bottom
      cheat
      cloc
      difftastic
      direnv
      dust
      dysk
      exercism
      eza
      gawk
      gh
      htop
      hyperfine
      just
      jujutsu
      lazygit
      lazydocker
      lnav
      lua
      most
      mr
      nil
      nix
      nixd
      nixfmt
      prek
      restic
      sbcl
      silver-searcher
      tombi
      tree-sitter
      sops
      unzip
      update-nix-fetchgit
      usage
      visidata
      watchexec
      zellij
      zoxide

      beam29Packages.erlang
      beam29Packages.elixir_1_20
      beam29Packages.expert
      erlang-language-platform
      gleam

      rustup
      cargo-binstall
      cargo-cache
      cargo-update
      cargo-nextest
      cargo-generate
      cargo-cross
    ]
    ++ lib.optionals isDarwin [

    ]
    ++ lib.optionals (!isDarwin) [
      pkgs.bluetui
    ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/willrog/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {

  };

  xdg.configFile = {
  };

  programs = {
    # Let Home Manager install and manage itself.
    home-manager.enable = true;
  };

  nix = {
    package = pkgs.nix;
    settings.experimental-features = [
      "nix-command"
      "flakes"
    ];
  };
}
