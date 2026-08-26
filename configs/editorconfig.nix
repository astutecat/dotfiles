{ ... }:
{
  editorconfig = {
    enable = true;
    settings = {
      "*" = {
        charset = "utf-8";
        end_of_line = "lf";
        indent_size = 2;
        indent_style = "space";
        insert_final_newline = true;
        trim_trailing_whitespace = true;
        max_line_length = 120;
      };
      "*.md" = {
        trim_trailing_whitespace = false;
      };
      "*.erl" = {
        indent_style = "space";
        indent_size = 4;
        trim_trailing_whitespace = true;
        insert_final_newline = true;
      };
      "*.hrl" = {
        indent_style = "space";
        indent_size = 4;
        trim_trailing_whitespace = true;
        insert_final_newline = true;
      };
      "Makefile" = {
        indent_style = "tab";
      };
      "*.mk" = {
        indent_style = "tab";
      };
      "*.lua" = {
        indent_style = "space";
        indent_size = 2;
      };
    };
  };
}
