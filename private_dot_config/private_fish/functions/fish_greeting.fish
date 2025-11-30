function fish_greeting
  if type -q fastfetch
    fastfetch
  end

  if type -q fortune
    fortune -s ~/.local/share/fortunes/ | fmt
    echo ""
  end
end
