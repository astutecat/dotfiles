{ pkgs, workConfig ? false, ... }: {
  # NOTYET: neovim config still needs to be migrated.  
  imports = [
    (import ./neovim {
      inherit pkgs;
      inherit workConfig;
    })
    ./editorconfig.nix
  ];
}
