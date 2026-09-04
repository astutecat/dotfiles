{ pkgs, ... }: {
  programs.helix = {
    extraPackages = with pkgs; [
      marksman
    ];

    languages = {
      language = [
        {
          name = "markdown";
          language-servers = [
            "marksman"
            "typos"
          ];
        }
      ];
    };
  };
}
