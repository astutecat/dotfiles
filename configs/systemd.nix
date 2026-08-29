{ pkgs, ... }:

{
  systemd.user.services.nix-collect-garbage = {
    Unit = {
      Description = "Run nix-collect-garbage";
    };
    Service = {
      Type = "oneshot";
      ExecStart = "${pkgs.nix}/bin/nix-collect-garbage";
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
