{ pkgs, ... }: {
  programs.helix = {
    extraPackages = [
      pkgs.beam29Packages.expert
    ];

    languages = {
      language = [
        {
          name = "elixir";
          language-servers = [
            "expert"
            "typos"
          ];
        }
      ];
    };
  };
}
