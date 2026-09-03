{
  pkgs,
  lib,
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
    ../configs/dircolors.nix
    ../configs/direnv.nix
    ../configs/editorconfig.nix
    ../configs/fonts.nix
    ../editors/doom-emacs.nix
    ../editors/helix
    ../editors/imhex.nix
    ../configs/fastfetch.nix
    ../configs/fortune.nix
    ../configs/scm.nix
    ../services/nix-gc.nix
    ../configs/ssh.nix
    ../configs/ghostty.nix
    ../configs/just
    ../configs/keymapp.nix
    ../configs/lazygit.nix
    ../configs/mise.nix
    ../configs/opencode.nix
    ../configs/pert.nix
    ../configs/shell.nix
    ../configs/ssh.nix
    ../configs/tealdeer.nix
    ../configs/tfg.nix
    ../configs/topgrade.nix
    ../configs/wezterm.nix
    ../configs/yamllint.nix
    ../configs/zathura.nix
    ../configs/zellij
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
        pkgs.wl-clipboard
      ])
    ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    ".typos.toml".text = ''
      [default]
      extend-ignore-re = [
        "(?Rm)^.*(%|#|//)\\s*spellcheck:disable-line$",  # spellcheck:disable-line
        "(?s)(%|#|//)\\s*spellcheck:off.*?\\n\\s*(%|#|//)\\s*spellcheck:on",  # spellcheck:<on|off>
        "(?s)(%|#|//)\\s*spellcheck:off\n?.*",  # spellcheck:off open ended
        "(?s).*(%|#|//)\\s*spellcheck:disable-file\n?.*",  # spellcheck:disable-file
      ]

      [default.extend-identifiers]

      [default.extend-words]

      [files]
      extend-exclude = ["CHANGELOG.md"]
    '';

    ".latexmkrc".text = ''
      $pdf_mode = 5;
      $clean_ext = "synctex.gz nav snm thm soc loc glg acn";
    '';
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
    "$HOME/.moon/bin"
    "$HOME/.fly/bin"
    "/Applications/Obsidian.app/Contents/MacOS"
  ];

  home.sessionVariables = {
    PAGER = "most";
  };

  xdg.configFile = {
  };

  nix = {
    package = pkgs.nix;

    settings = {
      accept-flake-config = true;

      # While you're here, add the nix-community cache:
      substituters = [
        "https://cache.nixos.org/"
        "https://nix-community.cachix.org"
      ];
      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];

      experimental-features = [
        "nix-command"
        "flakes"
      ];
    };
  };
}
