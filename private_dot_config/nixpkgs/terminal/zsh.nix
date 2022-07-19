{ pkgs, workConfig ? false, ... }:
with pkgs;
with lib;
let
  inherit (stdenv) isDarwin isLinux;
  inherit (lib) optionalString optionals;
in {
  home.packages = with pkgs; [ bat delta most ];
  programs.zsh = {
    enable = true;
    dotDir = ".config/zsh";
    enableSyntaxHighlighting = true;
    enableVteIntegration = true;
    autocd = true;
    shellAliases = {
      hl = ''printf %"$COLUMNS"s |tr " " "-"'';
      lcl = "hl && clear";
      ls = "ls --color=auto";
      stldr = "split_tldr";
    } // attrsets.optionalAttrs stdenv.isDarwin { sudoedit = "sudo -e $@"; }
      // attrsets.optionalAttrs workConfig {
        devel = "cd ~/repos/NOC-Devel/Erlnoc";
        stable = "cd ~/repos/NOC-Stable/Erlnoc";
        zebra = "cd ~/repos/Zebra";
        repos = "cd ~/repos/";
        thg = "tortoisehg 2>/dev/null&";
      };
    history = {
      size = 100000;
      save = 100000;
      path = "$HOME/.zsh_history";
      ignoreSpace = true;
      expireDuplicatesFirst = true;
      extended = true;
      ignoreDups = true;
      share = true;
    };
    profileExtra = ''
      export PAGER="most"
    '' + optionalString isLinux ''
      export NIX_PATH=$NIX_PATH:$HOME/.nix-defexpr/channels:/nix/var/nix/profiles/per-user/root/channels
    '';
    completionInit = ''
      mkdir -p ~/.zfunc/
      cog generate-completions zsh > ~/.zfunc/_cog
      fpath=(~/.zfunc/ $fpath)
      autoload -U compinit && compinit
    '';
    initExtra = ''
      ${builtins.readFile ./functions.zsh}
      ZSH_THEME=""

      if [[ -d "$HOME/.cache/rebar3" ]]; then
        export PATH="$HOME/.cache/rebar3/bin:$PATH"
      fi

      if [ -f $HOME/.asdf/asdf.sh ]; then
        . $HOME/.asdf/asdf.sh
      fi
    '' + optionalString isDarwin ''
      export LANG=en_US.UTF-8

      eval $(/opt/homebrew/bin/brew shellenv)
      if [[ -f /opt/homebrew/bin/brew ]]; then
        eval $(/opt/homebrew/bin/brew shellenv)
      fi
      if is_cmd brew; then
        FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH

        if [ -f $(brew --prefix)/bin/ctags ] && [ ! -h ~/.local/bin/ctags ]; then
          mkdir -p ~/.local/bin
          ln -s $(brew --prefix)/bin/ctags ~/.local/bin/ctags
        fi
      fi
      '';
      prezto = {
      enable = true;
      caseSensitive = false;
      pmodules = [
        "history-substring-search"
        "archive"
        "autosuggestions"
        "git"
        "tmux"
        "completion"
      ] ++ optionals isLinux [
        "gpg"
        "ssh"
      ] ++ optionals isDarwin [
        "osx"
      ] ++ [
        "prompt"
      ];
      syntaxHighlighting = {
        highlighters = [ "main" "brackets" "line" ];
        styles = { globbing = "fg=cyan"; };
      };
      tmux = { itermIntegration = isDarwin; };
      ssh = {
        identities = optionals workConfig [ "id_dcb" "id_rsa" "id_rsa_trac" ];
      };
      prompt = {
        theme = "pure";
      };
      extraConfig = ''
      zstyle ':prezto:module:git:alias' skip 'yes'
      zstyle :prompt:pure:path color cyan
      zstyle :prompt:pure:git:dirty color 160
      zstyle :prompt:pure:prompt:success color 202
      PURE_PROMPT_SYMBOL="λ";
      '';
    };
    sessionVariables = {
      EDITOR = "nvim";
      BAT_THEME = "Dracula";
      DELTA_PAGER = "bat";
      PAGER = "most";
      DIRENV_LOG_FORMAT = "";
    };
  };
}
