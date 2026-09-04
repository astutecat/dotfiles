{ ... }: {
  imports = [
    ./bash.nix
    ./css.nix
    ./erlang.nix
    ./gleam.nix
    ./just.nix
    ./html.nix
    ./javascript.nix
    ./json.nix
    ./latex.nix
    ./lua.nix
    ./nickel.nix
    ./nix.nix
    ./python.nix
    ./rust.nix
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
