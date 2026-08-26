{ ... }:

{
  programs.helix = {
    enable = true;

    settings = {
      theme = "onedark";

      editor = {
        line-number = "relative";
        color-modes = true;
        trim-trailing-whitespace = true;
        bufferline = "always";

        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";
        };

        statusline = {
          separator = "│";
          mode.normal = "NORMAL";
          mode.insert = "INSERT";
          mode.select = "SELECT";
        };

        indent-guides = {
          render = true;
          skip-levels = 1;
        };
      };
    };

    languages = {
      # expert LSP is provided by erlang-language-platform in home.packages
      language-server.expert.command = "expert";

      language = [
        {
          name = "elixir";
          language-servers = [ "expert" ];
        }
        {
          name = "heex";
          language-servers = [ "expert" ];
        }
      ];
    };
  };
}
