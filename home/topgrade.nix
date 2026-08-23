{
  ...
}:
{
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
          "home-manager"
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
      };
      brew = {
        autoremove = true;
      };
      linux = {
        arch_package_manager = "autodetect";
        enable_tlmgr = true;
      };
      firmware = {
        upgrade = true;
      };
      containers = {
        runtime = "podman";
        system_prune = false;
      };
      doom = {
        aot = true;
      };
    };
  };
}
