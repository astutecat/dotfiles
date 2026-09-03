{ ... }:
{
  imports = [
    ./keys.nix
    ./languages
  ];

  programs.helix = {
    enable = true;
    defaultEditor = true;

    settings = {
      theme = "nightfox";
      editor = {
        # Use system clipboard
        default-yank-register = "+";

        # These may not get picked up properly in tmux
        true-color = true;
        undercurl = true;

        bufferline = "always";

        rulers = [
          80
          120
        ];

        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";
        };

        line-number = "relative";

        color-modes = true;
        trim-trailing-whitespace = true;
        popup-border = "all";

        indent-guides = {
          render = true;
        };

        end-of-line-diagnostics = "error";
        inline-diagnostics = {
          cursor-line = "info";
        };

        file-picker.hidden = false;

        auto-save = {
          focus-lost = true;
          after-delay = {
            enable = true;
            timeout = 10000; # ms
          };
        };

        statusline = {
          mode.normal = "NORMAL";
          mode.insert = "INSERT";
          mode.select = "SELECT";
          left = [
            "mode"
            "file-name"
            "read-only-indicator"
            "file-modification-indicator"
          ];
          center = [ ];
          right = [
            "spinner"
            "spacer"
            "version-control"
            "spacer"
            "diagnostics"
            "separator"
            "selections"
            "register"
            "separator"
            "position"
            "position-percentage"
            "file-type"
          ];
        };
      };
    };
  };
}
