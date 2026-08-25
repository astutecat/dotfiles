{ ... }:
{
  programs.fastfetch = {
    enable = true;
    settings = {
      display = {
        noBuffer = true;
        disableLinewrap = true;
      };
      logo = {
        type = "auto"; # Logo type: auto, builtin, small, file, etc.
        width = 10; # Width in characters (for image logos)
        height = 10; # Height in characters (for image logos)
        preserveAspectRatio = true;
        position = "left";
        padding = {
          top = 0; # Top padding
          left = 0; # Left padding
          right = 0; # Right padding
        };
      };
      modules = [
        "title"
        {
          type = "separator";
          string = "-";
          length = 40;
        }
        "os"
        "host"
        "kernel"
        "uptime"
        "shell"
        "terminal"
        "terminalfont"
        "localip"
        {
          type = "separator";
          string = "-";
          length = 40;
        }
        "colors"
      ];
    };
  };
}
