{
  description = "my flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    home-manager.url = "github:nix-community/home-manager/release-26.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      home-manager,
      flake-utils,
    }:
    flake-utils.lib.eachDefaultSystemPassThrough (
      system:
      let
        pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };
      in
      {
        homeConfigurations = {
          "willrog@nb0408" = home-manager.lib.homeManagerConfiguration {
            inherit pkgs;
            extraSpecialArgs = {
              inherit inputs;
              username = "willrog";
              hostname = "nb0408";
              homeDirectory = "/home/willrog";
            };
            modules = [
              ./hosts/nb0408
            ];
          };
          "astutecat@astutecachy" = home-manager.lib.homeManagerConfiguration {
            inherit pkgs;
            extraSpecialArgs = {
              inherit inputs;
              username = "astutecat";
              hostname = "astutecachy";
              homeDirectory = "/home/astutecat";
            };
            modules = [
              ./hosts/astutecachy
            ];
          };
          "astutecat@AstuteMBP" = home-manager.lib.homeManagerConfiguration {
            inherit pkgs;
            extraSpecialArgs = {
              inherit inputs;
              username = "astutecat";
              hostname = "AstuteMBP";
              homeDirectory = "/Users/astutecat";
            };
            modules = [
              ./hosts/AstuteMBP
            ];
          };
        };
      }
    );
}
