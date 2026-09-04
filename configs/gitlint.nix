{ pkgs, config, ... }:

let
  gitlintIni = ''
    [general]
    contrib = contrib-title-conventional-commits
    ignore = B5,B6

    [title-max-length]
    line-length = 100

    [body-max-line-length]
    line-length = 100
  '';
in
{
  home.packages = [
    # The real gitlint is only reachable through this wrapper, which lets a
    # repo-local .gitlint win and falls back to the user-level config below.
    (pkgs.writeShellScriptBin "gitlint" ''
      userIni="${config.xdg.configHome}/gitlint/gitlint.ini"
      if [ -f .gitlint ]; then
        exec "${pkgs.gitlint}/bin/gitlint" "$@"
      elif [ -f "$userIni" ]; then
        exec "${pkgs.gitlint}/bin/gitlint" -C "$userIni" "$@"
      else
        exec "${pkgs.gitlint}/bin/gitlint" "$@"
      fi
    '')
  ];

  xdg.configFile."gitlint/gitlint.ini".text = gitlintIni;
}
