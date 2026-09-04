{ pkgs, ... }: {
  programs.helix = {
    extraPackages = with pkgs; [
      texlab
    ];

    languages = {
      language = [
        {
          name = "latex";
          auto-format = true;
          formatter = {
            command = "${pkgs.texlivePackages.latexindent}/bin/latexindent";
            args = [ "-" ];
          };
        }
      ];
    };
  };
}
