{ pkgs, ... }: {
  # Language servers shared by Zed and Helix (on PATH via home.packages).
  home.packages = with pkgs; [
    typos-lsp

    bash-language-server

    vscode-langservers-extracted

    beam29Packages.expert
    erlang-language-platform
    gleam

    efm-langserver

    just-lsp

    typescript-language-server

    texlab

    lua-language-server

    marksman

    nls

    nixd
    nixfmt
    statix

    python313Packages.jedi
    ruff
    ty

    taplo

    yamlfmt
    yaml-language-server
  ];
}
