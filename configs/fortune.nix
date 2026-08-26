{ pkgs, ... }:

let
  fortune-files = pkgs.stdenv.mkDerivation {
    pname = "fortunes";
    version = "0.1.0";

    src = ./fortunes;

    nativeBuildInputs = [ pkgs.fortune ];

    buildPhase = ''
      runHook preBuild

      # Generate a .dat index for each fortune text file
      for f in *; do
        strfile "$f"
      done

      runHook postBuild
    '';

    installPhase = ''
      runHook preInstall

      mkdir -p "$out"
      cp -r . "$out/"

      # Remove Nix's empty placeholder file if present
      rm -f "$out/.gitkeep" "$out/README.md" 2>/dev/null || true

      runHook postInstall
    '';
  };
in
{
  xdg.dataFile."fortunes" = {
    source = "${fortune-files}";
    recursive = true;
  };

  home.packages = with pkgs; [ fortune ];
}
