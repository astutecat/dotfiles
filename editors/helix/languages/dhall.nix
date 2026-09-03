{ pkgs, ... }: {
  programs.helix = {
    extraPackages = with pkgs; [
      dhall-lsp-server
    ];

    languages = {
      language = [
        {
          name = "dhall";
          auto-format = true;
        }
      ];
    };
  };
}
