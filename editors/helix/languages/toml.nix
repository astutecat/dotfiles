{ pkgs, ... }: {
  programs.helix = {
    extraPackages = with pkgs; [
      taplo
    ];

    languages = {
      language = [
        {
          name = "toml";
          auto-format = true;
        }
      ];
    };
  };
}
