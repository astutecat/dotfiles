{ pkgs, ... }: {
  programs.helix = {
    extraPackages = with pkgs; [
      rust-analyzer
      rustfmt
    ];

    languages = {
      language-server.rust-analyzer.config.check.command = "clippy";

      language = [
        {
          name = "rust";
          auto-format = true;
        }
      ];
    };
  };
}
