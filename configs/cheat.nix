{
  pkgs,
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
  xdg.configFile."cheat/cheatsheets/community" = {
    source = "${community-cheatsheets}/share/cheat/cheatsheets";
    recursive = true;
  };
  home.packages = [
    pkgs.cheat
  ];
}
