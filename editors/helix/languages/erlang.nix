{ pkgs, lib, ... }: {
  programs.helix = {
    extraPackages = with pkgs; [
      erlang-language-platform
    ];

    languages = {
      language = [
        {
          name = "erlang";
          auto-format = true;
          formatter = {
            command = "${lib.getExe pkgs.erlfmt}";
            args = [ "-" ];
          };
        }
      ];
      grammar = [
        {
          name = "erlang";
          source = {
            git = "https://github.com/WhatsApp/tree-sitter-erlang";
            rev = "67e7f7f05baf492ca2a7c0d9538761b242d33d95";
          };
        }
      ];
    };
  };
}
