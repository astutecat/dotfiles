{ pkgs, ... }: {
  programs.helix = {
    extraPackages = with pkgs; [
      python313Packages.jedi
      ruff
      ty
    ];

    languages = {
      language = [
        {
          name = "python";
          auto-format = true;
        }
      ];
    };
  };
}
