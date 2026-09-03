{ pkgs, ... }: {
  programs.helix = {
    extraPackages = with pkgs; [
      vscode-langservers-extracted
    ];

    languages = {
      language = [
        {
          name = "json";
          auto-format = true;
        }
      ];
    };
  };
}
