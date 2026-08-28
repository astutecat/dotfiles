{ ... }:

{
  programs.atuin = {
    enable = true;
    enableFishIntegration = true;
    settings = {
      db_path = "~/.local/share/atuin/history.db";
      dialect = "uk";
      auto_sync = true;
      filter_mode = "global";
      filter_mode_shell_up_key_binding = "host";
      style = "auto";
      ctrl_n_shortcuts = true;
      enter_accept = true;
      inline_height = 0;
      show_preview = true;
      history_filter = [ ];
      dotfiles = {
        enabled = true;
      };
      sync = {
        records = true;
      };
    };
  };
}
