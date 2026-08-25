{ ... }:
{
  programs.zoxide = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    enableFishIntegration = true;
  };
  home.sessionVariables = {
    _ZO_RESOLVE_SYMLINKS = "0";
    _ZO_EXCLUDE_DIRS = "/var/mnt/games/repos/*";
  };
}
