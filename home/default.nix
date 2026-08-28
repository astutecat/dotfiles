{
  pkgs,
  username,
  homeDirectory,
  ...
}:
let
  isDarwin = pkgs.stdenv.hostPlatform.isDarwin;
  isLinux = pkgs.stdenv.hostPlatform.isLinux;
in
{
  nixpkgs.config.allowUnfree = true;

  imports = [
    ../configs/atuin.nix
    ../configs/cheat.nix
    ../configs/comby.nix
    ../configs/dev.nix
    ../configs/direnv.nix
    ../configs/editorconfig.nix
    ../editors/doom-emacs.nix
    ../editors/helix.nix
    ../editors/imhex.nix
    ../configs/fastfetch.nix
    ../configs/fortune.nix
    ../configs/git.nix
    ../configs/ghostty.nix
    ../configs/just
    ../configs/keymapp.nix
    ../configs/lazygit.nix
    ../configs/mise.nix
    ../configs/opencode.nix
    ../configs/pert.nix
    ../configs/shell.nix
    ../configs/tealdeer.nix
    ../configs/tfg.nix
    ../configs/topgrade.nix
    ../configs/wezterm.nix
    ../configs/yamllint.nix
    ../configs/zathura.nix
    ../configs/zoxide.nix
  ];

  programs = {
    # Let Home Manager install and manage itself.
    home-manager.enable = true;
    nh.enable = true;
    man = {
      enable = isLinux;
    };
    fd.enable = true;
    fzf.enable = true;
  };

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
    lib.concatLists [
      [
        age
        babelfish
        bottom
        cheat
        dust
        dysk
        exercism
        eza
        gawk
        htop
        hyperfine

        lnav
        most
        mr
        nix
        prek
        restic
        ripgrep
        silver-searcher
        sops
        unzip
        usage
        visidata
        watchexec
        zellij
        zoxide

      ]
      (lib.optionals isDarwin [
        # Darwin specific packages go here.
      ])
      (lib.optionals isLinux [
        # Linux specific packages go here.
        pkgs.bluetui
      ])
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
  home.sessionPath = [
    "/opt/homebrew/bin"
    "/opt/homebrew/sbin"
    "/home/linuxbrew/.linuxbrew/bin"
    "/home/linuxbrew/.linuxbrew/sbin"
    "$HOME/bin"
    "$HOME/.local/bin"
    "$HOME/.cargo/bin"
    "$HOME/.cache/rebar3/bin"
    "$HOME/.local/share/nvim/mason/bin"
    "$HOME/.moon/bin"
    "$HOME/.fly/bin"
    "/Applications/Obsidian.app/Contents/MacOS"
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
    PAGER = "most";
  };

  xdg.configFile = {
  };

  nix = {
    package = pkgs.nix;
    settings.experimental-features = [
      "nix-command"
      "flakes"
    ];
  };
}
