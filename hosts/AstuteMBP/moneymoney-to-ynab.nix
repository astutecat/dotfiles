{
  pkgs,
  config,
  inputs,
  ...
}:
let
  package = inputs.moneymoney-to-ynab.packages.${pkgs.stdenv.hostPlatform.system}.default;

  stateRel = "Library/Scripts/mm_export";
  stateDir = "${config.home.homeDirectory}/${stateRel}";
  logDir = "${stateDir}/log";
  configFile = "${stateDir}/config.yaml";

  syncScript = pkgs.writeShellScript "moneymoney-sync" ''
    if ! /usr/bin/curl -sS --max-time 5 -o /dev/null https://api.ynab.com/v1/; then
      echo "Offline - cannot reach api.ynab.com"
      exit 0
    fi

    ${package}/bin/moneymoney-to-ynab -c <(${pkgs.sops}/bin/sops --decrypt "${configFile}") &
    tool_pid=$!

    ( sleep 900; kill -TERM "$tool_pid" 2>/dev/null ) &
    watchdog_pid=$!

    wait "$tool_pid"
    status=$?
    kill "$watchdog_pid" 2>/dev/null

    exit "$status"
  '';
in
{
  home.packages = [ package ];

  home.file = {
    # Encrypted with sops; decrypted by the sync script at run time.
    "${stateRel}/config.yaml".source = "${inputs.moneymoney-to-ynab.outPath}/config.yaml";

    # Ensures the log directory exists before launchd tries to write to it.
    "${stateRel}/log/.keep".text = "";
  };

  launchd.agents.moneymoney-sync = {
    enable = true;
    config = {
      Label = "moneymoney.sync.job";
      ProgramArguments = [ "${syncScript}" ];
      RunAtLoad = false;
      ProcessType = "Background";
      LowPriorityIO = true;
      LowPriorityBackgroundIO = true;
      WorkingDirectory = stateDir;
      StandardOutPath = "${logDir}/sync.stdout";
      StandardErrorPath = "${logDir}/sync.stderr";
      StartCalendarInterval =
        map
          (Hour: {
            inherit Hour;
            Minute = 0;
          })
          [
            0
            4
            8
            12
            16
            20
          ];
    };
  };
}
