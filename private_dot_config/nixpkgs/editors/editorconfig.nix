_:
{
  editorconfig = {
    enable = true;
    settings = {
      "*" = {
        charset = "utf-8";
        end_of_line = "lf";
        trim_trailing_whitespace = true;
        insert_final_newline = true;
        indent_style = "space";
        indent_size = 2;
      };
      "*.md" = {
        trim_trailing_whitespace = false;
      };
      "{Makefile*,**.mk*}" = {
        indent_style = "tab";
      };
      "{*.erl,*.hrl}" = {
        indent_style = "space";
        insert_final_newline = true;
        indent_size = "4";
        tab_width = "8";
      };
    };
  };
}
