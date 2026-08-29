{ pkgs, ... }:

{
  launchd.agents.nix-collect-garbage = {
    enable = true;
    config = {
      ProgramArguments = [ "${pkgs.nix}/bin/nix-collect-garbage" ];
      RunAtLoad = true;
      StartCalendarInterval = [
        {
          Hour = 3;
          Minute = 0;
        }
      ];
      StandardOutPath = "/tmp/nix-collect-garbage.out.log";
      StandardErrorPath = "/tmp/nix-collect-garbage.err.log";
    };
  };
}
