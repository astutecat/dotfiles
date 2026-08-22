{
  description = "my flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    home-manager.url = "github:nix-community/home-manager/release-26.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      home-manager,
    }:
    {
      homeConfigurations = {
        "willrog@nb0408" = home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs {
            system = "x86_64-linux";
            config.allowUnfree = true;
          };
          extraSpecialArgs = { inherit inputs; username = "willrog"; homeDirectory = "/home/willrog"; };
          modules = [
            ./hosts/nb0408
          ];
        };
        "astutecat@astutecachy" = home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs {
            system = "x86_64-linux";
            config.allowUnfree = true;
          };
          extraSpecialArgs = { inherit inputs; username = "astutecat"; homeDirectory = "/home/astutecat"; };
          modules = [
            ./hosts/astutecachy
          ];
        };
        "astutecat@AstuteMBP" = home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs {
            system = "aarch64-darwin";
            config.allowUnfree = true;
          };
          extraSpecialArgs = { inherit inputs; username = "astutecat"; homeDirectory = "/Users/astutecat"; };
          modules = [
            ./hosts/AstuteMBP
          ];
        };
      };
    };
}
