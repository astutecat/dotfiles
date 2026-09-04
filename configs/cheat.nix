{
  pkgs,
  config,
  lib,
  ...
}:

let
  community-cheatsheets = pkgs.stdenv.mkDerivation {
    pname = "cheat-community-cheatsheets";
    version = "unstable-2022-12-17";

    src = pkgs.fetchFromGitHub {
      owner = "cheat";
      repo = "cheatsheets";
      rev = "36bdb99dcfadde210503d8c2dcf94b34ee950e1d";
      sha256 = "0yzj15zkn7zfwspr07qfq9xqrkiakd1z2cgnb8r2nk2qz6ng9yq1";
    };

    nativeBuildInputs = [ pkgs.git ];
    dontConfigure = true;
    dontBuild = true;

    installPhase = ''
      runHook preInstall

      mkdir -p $out/share/cheat/cheatsheets
      cp -r . $out/share/cheat/cheatsheets/

      runHook postInstall
    '';
  };
in
{
  # Community cheatsheets (read-only symlink into the Nix store)
  xdg.dataFile."cheat/cheatsheets/community" = {
    source = "${community-cheatsheets}/share/cheat/cheatsheets";
  };

  # cheat configuration (migrated from chezmoi conf.yml.tmpl)
  xdg.configFile."cheat/conf.yml".text = ''
    editor: ${config.home.sessionVariables.EDITOR}
    colorize: true
    style: onedark
    formatter: terminal256
    pager: ${pkgs.most}/bin/most -R
    cheatpaths:
      - name: personal
        path: ${config.xdg.dataHome}/cheat/cheatsheets/personal
        tags: [personal]
        readonly: false
      - name: work
        path: ${config.xdg.dataHome}/cheat/cheatsheets/work
        tags: [work]
        readonly: false
      - name: community
        path: ${config.xdg.dataHome}/cheat/cheatsheets/community
        tags: [community]
        readonly: true
  '';

  # Ensure writable cheat directories exist
  home.activation.createCheatDirs = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    mkdir -p "${config.xdg.dataHome}/cheat/cheatsheets/personal"
    mkdir -p "${config.xdg.dataHome}/cheat/cheatsheets/work"
  '';

  home.packages = [ pkgs.cheat ];
}
