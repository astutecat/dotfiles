{
  pkgs,
  lib,
  ...
}:

let
  isDarwin = pkgs.stdenv.hostPlatform.isDarwin;
  isLinux = pkgs.stdenv.hostPlatform.isLinux;

  serviceName = "nix-collect-garbage";
  gcCmd = "${pkgs.nix}/bin/${serviceName}";
in
{
  launchd.agents."${serviceName}" = lib.mkIf isDarwin {
    enable = true;
    config = {
      ProgramArguments = [ gcCmd ];
      RunAtLoad = true;
      StartCalendarInterval = [
        {
          Hour = 3;
          Minute = 0;
        }
      ];
      StandardOutPath = "/tmp/${serviceName}.out.log";
      StandardErrorPath = "/tmp/${serviceName}.err.log";
    };
  };

  systemd.user.services."${serviceName}" = lib.mkIf isLinux {
    Unit = {
      Description = "Run ${serviceName}";
    };
    Service = {
      Type = "oneshot";
      ExecStart = gcCmd;
    };
  };

  systemd.user.timers."${serviceName}" = lib.mkIf isLinux {
    Unit = {
      Description = "Run ${serviceName} daily";
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
