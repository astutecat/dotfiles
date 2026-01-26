# set --universal pure_symbol_prompt λ
# set --universal pure_show_prefix_root_prompt true
# set --universal pure_enable_nixdevshell true
# set --universal pure_symbol_title_bar_separator :
# set --universal pure_show_numbered_git_indicator true
# set --universal pure_color_primary cyan
# set --universal pure_color_success FF4F00
# set --universal fish_transient_prompt 1
# set --universal pure_enable_single_line_prompt false
# set --universal pure_show_exit_status true
#
# set --universal hydro_symbol_prompt λ
# set --universal hydro_color_prompt FF4F00
# set --universal hydro_multiline true
# set --universal fish_prompt_pwd_dir_length 100

set --global tide_left_prompt_items pwd jj newline character
set --global tide_right_prompt_items status git cmd_duration context jobs direnv bun node python rustc java php pulumi ruby go gcloud kubectl distrobox toolbox terraform aws nix_shell crystal elixir zig
set --global tide_character_icon λ
set --global tide_character_color FF4F00
set -g fish_key_bindings fish_default_key_bindings
