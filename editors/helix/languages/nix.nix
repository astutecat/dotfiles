{ pkgs, ... }: {
  programs.helix = {
    extraPackages = with pkgs; [
      nixd
      nixfmt
    ];

    languages = {
      language = [
        {
          name = "nix";
          auto-format = true;
        }
      ];
    };
  };
}
