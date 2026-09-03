{ pkgs, ... }: {
  programs.helix = {
    extraPackages = with pkgs; [
      just-lsp
    ];

    languages = {
      language = [
        {
          name = "just";
          auto-format = true;
        }
      ];
    };
  };
}
