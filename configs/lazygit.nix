{ ... }:
{
  programs.lazygit = {
    enable = true;
    settings = {
      gui = {
        skipRewordInEditorWarning = true;
        nerdFontsVersion = "3";
        spinner = {
          frames = [
            "⠋"
            "⠙"
            "⠹"
            "⠸"
            "⠼"
            "⠴"
            "⠦"
            "⠧"
            "⠇"
            "⠏"
          ];
          rate = 100;
        };
      };

      git = {
        diffRenderers = [
          {
            colorArg = "always";
            command = "delta --dark --paging=never";
          }
        ];
        commit = {
          autoWrapWidth = 120;
        };
        log = {
          showWholeGraph = false;
        };
      };

      os = {
        copyToClipboardCmd = ''printf "\033]52;c;$(printf {{text}} | base64 -w 0)\a" > /dev/tty'';
      };
    };
  };
}
