{ pkgs, ... }: {
  programs.home-manager.enable = true;
  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
    defaultCommand =
      "fd --type file --follow --color=always --exclude .git --exclude .hg";
    defaultOptions = [ "--ansi" ];
  };
  programs.dircolors = {
    enable = true;
    enableZshIntegration = true;
  };
  programs.tealdeer = {
    enable = true;
    settings = {
      display = {
        use_pager = true;
        compact = true;
      };
      updates = {
        auto_update = true;
      };
    };
  };
  programs.pls.enable = true;
  programs.tmate.enable = true;
  programs.bottom.enable = true;
  programs.k9s.enable = true;
}
