{
  programs.zellij = {
    enable = true;

    settings = {
      theme = "nightfox";
      default_mode = "locked";
      default_shell = "fish";
      copy_command = "wl-copy";
      session_name = "main";
      attach_to_session = true;
      show_startup_tips = false;
    };
  };
}
