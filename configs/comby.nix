{ lib, pkgs, ... }:

let
  isLinux = pkgs.stdenv.hostPlatform.isLinux;
  version = "1.8.1";

  # upstream binary wants libpcre.so.3 (Debian soname); nixpkgs ships .so.1
  pcre3 = pkgs.runCommand "pcre3" { } ''
    mkdir -p $out/lib
    ln -s ${pkgs.pcre.out}/lib/libpcre.so.1 $out/lib/libpcre.so.3
  '';

  # prefer the nixpkgs package; fall back to the upstream release binary only
  # while it is marked broken (e.g. ocaml tar >= 3 incompatibility on 26.05)
  comby =
    if pkgs.comby.meta.broken then
      pkgs.stdenv.mkDerivation {
        pname = "comby";
        inherit version;

        src = pkgs.fetchurl {
          url = "https://github.com/comby-tools/comby/releases/download/${version}/comby-${version}-x86_64-linux";
          hash = "sha256-iu62Uerke7r9jJh7u+4AMxaWJXnyfaH69hgk1+YoPco=";
        };

        dontUnpack = true;

        nativeBuildInputs = with pkgs; [ autoPatchelfHook ];
        buildInputs = with pkgs; [
          stdenv.cc.cc.lib
          sqlite
          zlib
          libev
          pcre3
        ];

        installPhase = ''
          runHook preInstall
          install -Dm755 $src $out/bin/comby
          runHook postInstall
        '';

        meta = with pkgs.lib; {
          description = "Tool for searching and changing code structure";
          homepage = "https://comby.dev";
          license = licenses.asl20;
          mainProgram = "comby";
          platforms = [ "x86_64-linux" ];
          sourceProvenance = with sourceTypes; [ binaryNativeCode ];
        };
      }
    else
      pkgs.comby;
in
{
  home.packages = lib.optionals (isLinux || !pkgs.comby.meta.broken) [ comby ];
}
