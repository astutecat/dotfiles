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
          # topgrade hardcodes `mr --directory $HOME`, which finds nothing
          # because ~/repos is a symlink out of $HOME on some machines;
          # replaced by the myrepos command below.
          "myrepos"
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
      commands = {
        "myrepos" = "mr --directory ${homeDirectory}/repos update";
      };
      linux = {
        arch_package_manager = "autodetect";
        enable_tlmgr = false;
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
