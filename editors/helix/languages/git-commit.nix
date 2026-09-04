{ pkgs, ... }: {
  programs.helix = {
    extraPackages = [ pkgs.efm-langserver ];

    languages = {
      language-server.gitlint = {
        command = "efm-langserver";
        config.languages.git-commit = [
          {
            lint-command = "gitlint";
            lint-stdin = true;
            lint-ignore-exit-code = true;
            lint-formats = [
              ''%l: %m: "%r"''
              "%l: %m"
            ];
          }
        ];
      };

      language = [
        {
          name = "git-commit";
          language-servers = [ "gitlint" ];
        }
      ];
    };
  };
}
