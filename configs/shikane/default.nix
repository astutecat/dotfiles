_: {
  # shikane: dynamic wayland output configuration; the systemd user service
  # is wired to the sway session target (sway module sets systemd.enable).
  services.shikane.enable = true;

  # The config is deployed verbatim instead of generated from
  # services.shikane.settings so profiles exported via `shikanectl export`
  # can be appended to it easily.
  xdg.configFile."shikane/config.toml".source = ./config.toml;
}
