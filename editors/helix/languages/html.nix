{ pkgs, ... }: {
  programs.helix = {
    extraPackages = with pkgs; [
      vscode-langservers-extracted
    ];

    languages = {
      language = [
        {
          name = "html";
          auto-format = true;
        }
      ];
    };
  };
}
