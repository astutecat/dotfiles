{ pkgs, ... }: {
  programs.helix = {
    extraPackages = with pkgs; [
      vscode-langservers-extracted
    ];

    languages = {
      language = [
        {
          name = "css";
          auto-format = true;
        }
      ];
    };
  };
}
