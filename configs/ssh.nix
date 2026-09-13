{
  pkgs,
  lib,
  ...
}:

let
  isDarwin = pkgs.stdenv.hostPlatform.isDarwin;

  hostDefaults =
    if isDarwin then
      {
        IdentityAgent = ''"~/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"'';
        Compression = true;
        ServerAliveInterval = 60;
        ServerAliveCountMax = 3;
      }
    else
      {
        Compression = true;
        AddKeysToAgent = "yes";
        IgnoreUnknown = "AddKeysToAgent";
        IdentityAgent = "~/.1password/agent.sock";
        ServerAliveInterval = 60;
        ServerAliveCountMax = 3;
      };
in
{
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;

    settings = {
      "github.com" = lib.hm.dag.entryBefore [ "*" ] {
        ControlMaster = "auto";
        ControlPath = "~/.ssh/github.sock";
        ControlPersist = "30s";
        ServerAliveInterval = 0;
      };

      "git.sr.ht" = lib.hm.dag.entryBefore [ "*" ] {
        IdentityFile = "~/.ssh/id_sourcehut.pub";
        IdentitiesOnly = true;
      };

      "*" = hostDefaults;
    };
  };

  home.file.".ssh/id_entelios.pub".text = ''
    ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIA7FBkqrvwbjN4hnmi0NGYU627I0s7m/Dm7IJKqWKiZ2
  '';

  home.file.".ssh/id_sourcehut.pub".text = ''
    ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIByaYbjqPG4VP+TvNrmkGIwY1Le3jCtDoaesIdI6IV2o
  '';
}
