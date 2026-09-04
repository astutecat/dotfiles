{ pkgs, ... }: {
  imports = [
    ./bash.nix
    ./css.nix
    ./elixir.nix
    ./erlang.nix
    ./gleam.nix
    ./git-commit.nix
    ./just.nix
    ./html.nix
    ./javascript.nix
    ./json.nix
    ./latex.nix
    ./lua.nix
    ./markdown.nix
    ./nickel.nix
    ./nix.nix
    ./python.nix
    ./rust.nix
    ./toml.nix
    ./yaml.nix
  ];

  programs.helix = {
    extraPackages = with pkgs; [
      typos-lsp
    ];

    languages = {
      language-server.typos = {
        command = "typos-lsp";
      };

      use-grammars = {
        except = [
          "go"
          "gotmpl"
          "git-config"
        ];
      };
    };
  };
}
