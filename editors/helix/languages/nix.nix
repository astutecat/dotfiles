{ pkgs, lib, ... }: {
  programs.helix = {
    extraPackages = with pkgs; [
      nixd
      nixfmt
      statix
    ];

    languages = {
      language-server.statix = {
        command = "${lib.getExe pkgs.statix}";
        args = [ "lsp" ];
      };

      language = [
        {
          name = "nix";
          auto-format = true;
          language-servers = [
            "nixd"
            "statix"
          ];
        }
      ];
    };
  };
}
