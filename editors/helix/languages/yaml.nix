{ pkgs, ... }: {
  programs.helix = {
    extraPackages = with pkgs; [
      yamlfmt
      yaml-language-server
    ];

    languages = {
      language = [
        {
          name = "yaml";
          auto-format = true;
        }
      ];
    };
  };
}
