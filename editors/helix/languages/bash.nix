{ pkgs, lib, ... }: {
  programs.helix = {
    extraPackages = with pkgs; [
      bash-language-server
    ];

    languages = {
      language = [
        {
          name = "bash";
          auto-format = true;
          formatter = {
            command = "${lib.getExe pkgs.shfmt}";
          };
        }
      ];
    };
  };
}
