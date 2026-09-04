{
  description = "my flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    flake-utils.url = "github:numtide/flake-utils";

    nix-darwin.url = "github:nix-darwin/nix-darwin/nix-darwin-26.05";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager/release-26.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    git-hooks = {
      url = "github:cachix/git-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

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
      flake-utils,
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
            inherit (inputs) schemar-private-fonts;
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

      mkPreCommit =
        system: pkgs:
        inputs.git-hooks.lib.${system}.run {
          src = self;
          package = pkgs.prek;
          default_stages = [ "pre-push" ];
          hooks = {
            trim-trailing-whitespace.enable = true;
            end-of-file-fixer.enable = true;
            check-yaml.enable = true;
            check-toml = {
              enable = true;
            };
            mixed-line-endings = {
              enable = true;
              args = [ "--fix=lf" ];
            };
            gitlint = {
              enable = true;
              stages = [ "commit-msg" ];
            };
            statix.enable = true;
            deadnix.enable = true;
            nixfmt.enable = true;
            nix-flake-check = {
              enable = true;
              name = "nix flake check";
              entry = "nix flake check";
              language = "system";
              pass_filenames = false;
            };
          };
        };
    in
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };
        preCommit = mkPreCommit system pkgs;

        # Strips the explicit --config git-hooks.nix bakes into the prek hook
        # shims, so prek's hook-impl doesn't print "Using config file: ..." on
        # every commit.
        stripShimConfigHook = ''
          find .git/hooks -maxdepth 1 -type f ! -name '*.sample' \
            -exec sed -i 's/ --config="[^"]*"//' {} +
        '';
      in
      {
        devShells.default = pkgs.mkShell {
          buildInputs = [
            # Dev tools
            pkgs.just
            pkgs.direnv
            pkgs.prek
          ]
          ++ preCommit.enabledPackages;

          # Generates .pre-commit-config.yaml and installs hooks with prek
          shellHook = ''
            ${preCommit.shellHook}
            ${stripShimConfigHook}
          '';
        };
      }
    )
    // {
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
