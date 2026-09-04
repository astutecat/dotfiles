_:
# let
#   full-terminal = command: [
#     ":write-all"
#     ":insert-output ${command}"
#     ":redraw"
#     ":reload-all"
#   ];
#   full-terminal-interactive = command: full-terminal "zsh -ic \"${command}\" >/dev/tty 2>&1";
# in
{
  programs.helix = {
    settings.keys = {
      normal = {
        # Mark line and move with them up/down
        # https://github.com/helix-editor/helix/discussions/5764#discussioncomment-4840408
        C-j = [
          "extend_to_line_bounds"
          "delete_selection"
          "paste_after"
        ];
        C-k = [
          "extend_to_line_bounds"
          "delete_selection"
          "move_line_up"
          "paste_before"
        ];
        space = {
          l = ":toggle inline-diagnostics.cursor-line hint disable";
          # Other file:
          o = [
            ":sh rm -f /tmp/helix-other-file-selection-result"
            ":insert-output other-file %{buffer_name} /tmp/helix-other-file-selection-result 1>/dev/tty 2>&1"
            ":open %sh{cat /tmp/helix-other-file-selection-result}"
            ":redraw"
          ];
        };
      };
    };
  };
}
