{
  pkgs,
  ...
}:

let
  imhex-patterns = pkgs.stdenv.mkDerivation {
    pname = "imhex-patterns";
    version = "unstable-2026-08-27";

    src = pkgs.fetchFromGitHub {
      owner = "WerWolv";
      repo = "ImHex-Patterns";
      rev = "4b25356eb7bec31ad33d6b196e8173c832b195f1";
      sha256 = "1znx68rfa9s3db0bxm6dr2f2js9dgk05adsdsl9pm277zmyh32z1";
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
