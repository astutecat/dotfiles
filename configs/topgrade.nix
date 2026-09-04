{
  username,
  hostname,
  homeDirectory,
  ...
}:
{
  home.sessionVariables = {
    NH_HOME_FLAKE = "${homeDirectory}/repos/dotfiles";
  };
  programs.topgrade = {
    enable = true;
    settings = {
      misc = {
        disable = [
          "powershell"
          "typst"
          "helix"
          "waydroid"
          "nix"
          "toolbx"
          "emacs"
        ];
        first = [ "chezmoi" ];
        ignore_failures = [
          "powershell"
          "containers"
          "helix"
          "typst"
          "mise"
          "emacs"
        ];
        assume_yes = true;
        ask_retry = false;
        cleanup = true;
        notify_end = "always";
        pre_sudo = true;
      };
      brew = {
        autoremove = true;
      };
      linux = {
        arch_package_manager = "autodetect";
        enable_tlmgr = true;
        home_manager_arguments = [
          "-c"
          "${username}@${hostname}"
        ];
      };
      firmware = {
        upgrade = true;
      };
      containers = {
        runtime = "podman";
        system_prune = false;
      };
    };
  };
}
