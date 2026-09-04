{ pkgs, ... }: {
  programs.helix = {
    extraPackages = with pkgs; [
      gleam
    ];

    languages = {
      language = [
        {
          name = "gleam";
          auto-format = true;
        }
      ];
    };
  };
}
