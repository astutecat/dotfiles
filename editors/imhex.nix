{
  pkgs,
  ...
}:

let
  imhex-patterns = pkgs.stdenv.mkDerivation {
    pname = "imhex-patterns";
    version = "unstable-2026-09-01";

    src = pkgs.fetchFromGitHub {
      owner = "WerWolv";
      repo = "ImHex-Patterns";
      rev = "90739e5a57df0fbe35760bc4b4460fc0abb8dbee";
      sha256 = "198bs00hcsqvwqmjh8crnbk633xkvb6016d72isfxj12jrd9774p";
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
