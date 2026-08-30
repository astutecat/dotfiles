{
  description = "my flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    home-manager.url = "github:nix-community/home-manager/release-26.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nix-doom-emacs-unstraightened = {
      url = "github:marienz/nix-doom-emacs-unstraightened";
      inputs = {
        # We pass our own doomDir via programs.doom-emacs
        doomdir.follows = "";
        # Reuse our pinned nixpkgs so the same Emacs is used everywhere
        nixpkgs.follows = "nixpkgs";
      };
    };
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      home-manager,
      ...
    }:
    let
      mkHome =
        {
          system ? "x86_64-linux",
          username ? "astutecat",
          hostname,
          homeDirectory,
          isWorkMachine ? false,
        }:
        home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs {
            inherit system;
            config.allowUnfree = true;
          };
          extraSpecialArgs = {
            inherit
              inputs
              username
              hostname
              homeDirectory
              isWorkMachine
              ;
          };
          modules = [ (nixpkgs.lib.path.append ./hosts hostname) ];
        };
    in
    {
      homeConfigurations = {
        "willrog@nb0408" = mkHome {
          username = "willrog";
          hostname = "nb0408";
          homeDirectory = "/home/willrog";
          isWorkMachine = true;
        };

        "astutecat@astutecachy" = mkHome {
          hostname = "astutecachy";
          homeDirectory = "/home/astutecat";
        };

        "astutecat@AstuteMBP" = mkHome {
          system = "aarch64-darwin";
          hostname = "AstuteMBP";
          homeDirectory = "/Users/astutecat";
        };
      };
    };
}
