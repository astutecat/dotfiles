{ pkgs, lib, ... }: {
  programs.helix = {
    extraPackages = with pkgs; [
      typescript-language-server
    ];

    languages = {
      language = [
        {
          name = "javascript";
          auto-format = true;
          formatter = {
            command = "${lib.getExe pkgs.prettier}";
            args = [
              "--parser"
              "typescript"
            ];
          };
        }
      ];
    };
  };
}
