{ pkgs, ... }:

let
  copyCommand = if pkgs.stdenv.hostPlatform.isDarwin then "pbcopy" else "wl-copy";
in
{
  programs.zellij = {
    enable = true;

    settings = {
      theme = "nightfox";
      default_mode = "locked";
      default_shell = "fish";
      copy_command = copyCommand;
      session_name = "main";
      attach_to_session = true;
      show_startup_tips = false;
    };
  };
}
