{ pkgs, ... }: {
  programs.helix = {
    extraPackages = with pkgs; [
      nls
    ];

    languages = {
      language = [
        {
          name = "nickel";
          auto-format = true;
        }
      ];
    };
  };
}
