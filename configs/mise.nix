_: {
  programs.mise = {
    enable = true;
    enableFishIntegration = true;

    # generates ~/.config/mise/config.toml
    globalConfig.settings = {
      experimental = true;
      cache_prune_age = "14d";
      disable_hints = [
        "python_multi"
        "python_precompiled"
      ];
      disable_backends = [ "asdf" ];
    };
  };
}
