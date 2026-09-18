{
  pkgs,
  ...
}:

let
  imhex-patterns = pkgs.stdenv.mkDerivation {
    pname = "imhex-patterns";
    version = "unstable-2026-09-17";

    src = pkgs.fetchFromGitHub {
      owner = "WerWolv";
      repo = "ImHex-Patterns";
      rev = "e9e37e34cc2e335f1ee9d18f2cc9088d8bafe7b4";
      sha256 = "03m8bla2p9nvajy75nh9mjy6lkf07nqh02ph38hp09pd7lmkj8gl";
    };

    # The repo is pure data — no build phase, no dependencies.
    nativeBuildInputs = [ pkgs.git ];

    dontConfigure = true;
    dontBuild = true;

    installPhase = ''
      runHook preInstall

      mkdir -p $out/share/imhex/imhex-patterns
      cp -r . $out/share/imhex/imhex-patterns/

      runHook postInstall
    '';
  };
in
{
  xdg.dataFile."imhex/imhex-patterns" = {
    source = "${imhex-patterns}/share/imhex/imhex-patterns";
    recursive = true;
  };
  home.packages = [
    pkgs.imhex
  ];
}
