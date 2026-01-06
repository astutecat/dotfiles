function update_fish_completions
  echo "updating fish completions..."
  set --local completions_dir ~/.config/fish/completions

  if type -q mise
    mise completion fish > $completions_dir/mise.fish
  end

  if type -q prek
    begin
      set -lx COMPLETE fish
      prek > ~/.config/fish/completions/prek.fish
    end
  end

  if type -q rustup
    rustup completions fish > $completions_dir/rustup.fish
  end

  if type -q atuin
    atuin gen-completions --shell fish > $completions_dir/atuin.fish
  end

  if type -q stg
    stg completion fish > $completions_dir/stg.fish
  end

  if type -q devbox
    devbox completion fish > $completions_dir/devbox.fish
  end

  if type -q restic
    restic generate --fish-completion $completions_dir/restic.fish
  end

  if type -q trivy
    trivy completion fish > $completions_dir/trivy.fish
  end

  echo ...done
end
