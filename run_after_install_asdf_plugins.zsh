#!/bin/zsh
#!/bin/zsh
[[ -n $(command -v asdf) ]] || return;
run() {
  source "$HOME/.config/asdf/utils.zsh"

  for tool in "${tools_to_install[@]}"; do
    [[ -n $(command -v "$tool") ]] && continue

    local plugin_name=$(get_plugin_name "$tool")

    asdf plugin add "$plugin_name"
    asdf install "$plugin_name" latest
    asdf global "$plugin_name" latest
  done
}

(run)
