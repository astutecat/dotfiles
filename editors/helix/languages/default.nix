{ ... }: {
  imports = [
    ./bash.nix
    ./css.nix
    ./erlang.nix
    ./just.nix
    ./html.nix
    ./javascript.nix
    ./json.nix
    ./lua.nix
    ./nickel.nix
    ./nix.nix
    ./python.nix
    ./toml.nix
    ./yaml.nix
  ];

  programs.helix.languages = {
    use-grammars = {
      except = [
        "go"
        "gotmpl"
        "git-config"
      ];
    };
  };
}
