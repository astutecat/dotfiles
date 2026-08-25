{ pkgs, ... }:

let
  pert = pkgs.stdenv.mkDerivation {
    name = "pert";
    src = pkgs.fetchFromGitHub {
      owner = "arzzen";
      repo = "pert";
      rev = "2b6419639b9bb734e041d3cb168142d4d1f1b164";
      sha256 = "193rjghm8jh00zv7z40v46i3jqvlrfvc5va44gxld6h2sdkp34rz";
    };

    # pert depends on bc for calculations and tput for colors
    buildInputs = [ pkgs.bc ];

    nativeBuildInputs = [ pkgs.makeWrapper ];

    installPhase = ''
      runHook preInstall

      mkdir -p $out/bin
      cp pert $out/bin/pert
      chmod +x $out/bin/pert

      # wrap so bc is found at runtime
      wrapProgram $out/bin/pert \
        --prefix PATH : ${pkgs.lib.makeBinPath [ pkgs.bc ]}

      runHook postInstall
    '';
  };
in
{
  home.packages = [ pert ];
}
