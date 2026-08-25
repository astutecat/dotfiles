{ pkgs, ... }:
let
  tfg = pkgs.stdenv.mkDerivation {
    name = "tfg";
    src = pkgs.fetchFromGitHub {
      owner = "4rtzel";
      repo = "tfg";
      rev = "88793e738a0680fa9e8fd38da158776f3c3c2bc0";
      sha256 = "0slkkdbi0ljf8521w8lkqjyixs6bq73z7bz2174byzk8n7lzp861";
    };

    nativeBuildInputs = [ pkgs.makeWrapper ];

    # Python's curses module needs ncurses at runtime
    buildInputs = [
      pkgs.python3
      pkgs.ncurses
    ];

    installPhase = ''
      runHook preInstall

      mkdir -p $out/bin
      cp tfg.py $out/bin/tfg
      chmod +x $out/bin/tfg

      wrapProgram $out/bin/tfg \
        --prefix PATH : ${pkgs.lib.makeBinPath [ pkgs.python3 ]} \
        --set PYTHONPATH ""

      runHook postInstall
    '';
  };
in
{
  home.packages = [ tfg ];
}
