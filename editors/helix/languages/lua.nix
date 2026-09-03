{ pkgs, ... }: {
  programs.helix = {
    extraPackages = with pkgs; [
      lua-language-server
    ];

    languages = {
      language = [
        {
          name = "lua";
          auto-format = true;
        }
      ];
    };
  };
}
