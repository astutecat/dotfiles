{
  pkgs,
  ...
}:

let
  imhex-patterns = pkgs.stdenv.mkDerivation {
    pname = "imhex-patterns";
    version = "unstable-2026-09-03";

    src = pkgs.fetchFromGitHub {
      owner = "WerWolv";
      repo = "ImHex-Patterns";
      rev = "34b5824e44c8d3efbbe781f536d44ba0ba712a90";
      sha256 = "1k7l0ww5vzqq81xsi90gsfnmhdq70xnm4plzxv5rfd776v2k0ivm";
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
