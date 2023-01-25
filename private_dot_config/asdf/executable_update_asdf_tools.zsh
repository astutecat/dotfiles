#!/bin/zsh
[[ -n $(command -v asdf) ]] || return;
run() {
  source "$HOME/.config/asdf/utils.zsh"

  local plist=$(asdf plugin list)

  for tool in "${tools_to_install[@]}"; do
    local plugin_name=$(get_plugin_name "$tool")
    local awk_result=$(echo "$plist" | awk "/^${plugin_name}\$/{print}")
    [[ -z $awk_result ]] && continue;
    asdf install $plugin_name latest
    asdf global $plugin_name latest
  done
}

(run)
