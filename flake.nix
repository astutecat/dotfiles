{
  description = "my flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";

    nix-darwin.url = "github:nix-darwin/nix-darwin/nix-darwin-26.05";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager/release-26.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    schemar-private-fonts = {
      url = "git+ssh://git@github.com/schemar/fonts.git";
      flake = true;
    };

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
      nix-darwin,
      ...
    }:
    let
      darwin = {
        # Set Git commit hash for darwin-version.
        system.configurationRevision = self.rev or self.dirtyRev or null;
      };

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
            schemar-private-fonts = inputs.schemar-private-fonts;
          };
          modules = [ (nixpkgs.lib.path.append ./hosts "${hostname}/home.nix") ];
        };

      mkDarwin =
        {
          username ? "astutecat",
          hostname,
        }:
        nix-darwin.lib.darwinSystem {
          specialArgs = {
            inherit
              inputs
              username
              hostname
              ;
          };
          modules = [
            darwin
            (nixpkgs.lib.path.append ./hosts "${hostname}/darwin.nix")
          ];
        };
    in
    {
      # Build darwin flake using:
      # $ darwin-rebuild switch --flake .
      darwinConfigurations."AstuteMBP" = mkDarwin { hostname = "AstuteMBP"; };

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
