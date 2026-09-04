{
  pkgs,
  lib,
  ...
}:

# User-level garbage collection for Linux hosts. On Darwin, root-level GC runs
# via nix-darwin's nix.gc (see hosts/AstuteMBP/darwin.nix) instead, since a
# user launchd agent can't collect daemon-owned store paths.
lib.mkIf pkgs.stdenv.hostPlatform.isLinux {
  systemd.user.services.nix-collect-garbage = {
    Unit = {
      Description = "Run nix-collect-garbage";
    };
    Service = {
      Type = "oneshot";
      ExecStart = "${pkgs.nix}/bin/nix-collect-garbage --delete-older-than 30d";
    };
  };

  systemd.user.timers.nix-collect-garbage = {
    Unit = {
      Description = "Run nix-collect-garbage daily";
    };
    Timer = {
      OnCalendar = "daily";
      Persistent = true;
      RandomizedDelaySec = "1h";
    };
    Install = {
      WantedBy = [ "timers.target" ];
    };
  };
}
