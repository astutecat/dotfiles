{
  pkgs,
  ...
}:

let
  imhex-patterns = pkgs.stdenv.mkDerivation {
    pname = "imhex-patterns";
    version = "unstable-2026-08-31";

    src = pkgs.fetchFromGitHub {
      owner = "WerWolv";
      repo = "ImHex-Patterns";
      rev = "8718f8e935663544d29c4dcbad1da105412394d5";
      sha256 = "102iy33212xfc9sxijxwl0nr9l465k9h367ii5kbcrcy7h69y4hb";
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
