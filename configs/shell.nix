{
  pkgs,
  lib,
  ...
}:

let
  # ── Shared commands (work in both bash and zsh) ───────────────
  sharedCommands = "";

  bashOnlyCommands = "";

  zshOnlyCommands = "";

  # ── Fish exec guard ──────────────────────────────────────────
  # Runs last. Execs into nix-managed fish for interactive sessions.
  fishExec = ''
    if [[ $- == *i* ]] && [[ -z "''${NIX_FISH_EXEC-}" ]]; then
      export NIX_FISH_EXEC=1
      exec ${pkgs.fish}/bin/fish
    fi
  '';

  # Concatenated init: shared + shell-specific + fish exec guard
  bashInit = sharedCommands + bashOnlyCommands + fishExec;
  zshInit = sharedCommands + zshOnlyCommands + fishExec;

in
{
  programs.bash = {
    enable = true;
    initExtra = bashInit;
    profileExtra = ''
      [[ -f ~/.bashrc ]] && . ~/.bashrc
    '';
  };

  programs.zsh = {
    enable = true;
    initContent = lib.mkOrder 1000 zshInit;
  };

  programs.fish = {
    enable = true;

    plugins = [
      {
        name = "tide";
        # The built plugin uses share/fish/vendor_*, which home-manager's
        # plugin loader doesn't understand; the source tree has the expected
        # functions/, conf.d/ and completions/ at the top level.
        src = pkgs.fishPlugins.tide.src;
      }
    ];

    shellInit = ''
      fish_config theme choose "fish default"

      if type -q brew
          brew shellenv | source
      end
    '';

    interactiveShellInit = ''
      # Tide renders the prompt in a non-interactive child fish, so config must
      # be in universal scope to be visible there.
      set --universal tide_left_prompt_items pwd git newline character
      set --universal tide_right_prompt_items status cmd_duration context jobs direnv bun node python rustc java php pulumi ruby go gcloud kubectl distrobox toolbox terraform aws nix_shell crystal elixir zig
      set --universal tide_character_icon λ
      set --universal tide_character_color FF4F00
      set --universal tide_git_truncation_length 30
      set --universal fish_key_bindings fish_default_key_bindings
    '';

    shellAbbrs = {
      gc = "git commit";
      gca = "git commit -a";
      gcam = "git commit -a -m";
      gco = "git checkout";
      gpft = "git push --follow-tags";
      gp = "git push";
      ga = "git add";
      gpf = "git fpush";
      gsw = "git switch";
      gsp = "git spr";
      gst = "gh stack";
      spr = "git spr";
      j = "just";
      ".j" = "just -g";
      ".just" = "just -g";
      e = "eza";
      lg = "lazygit";
      lj = "lazyjj";
      adr = "adrs";
      la = "eza -a";
      lal = "eza -al";
      ll = "eza -l";
      lt = "eza -al --sort=modified";
      zj = "zellij";
      qm = "qman";
      jst = "jj status";
      jsh = "jj show";
      jshs = "jj show --summary";
      jl = "jj log";
      jlr = "jj log --reversed";
      jb = "jj bookmark";
      jbc = "jj bookmark create";
      jbd = "jj bookmark delete";
      jbm = "jj bookmark move";
      "jbm@" = "jj bookmark move --to @";
      jcl = "jj git clone --colocate";
      jclo = "jj git clone --colocate --remote upstream";
      jd = "jj desc";
      jdm = "jj desc -m";
      jdf = "jj diff";
      jdg = "jj diff --git";
      je = "jj edit";
      jfa = "jj git fetch --all-remotes";
      jf = "jj git fetch";
      jp = "jj git push";
      jpa = "jj git push --all";
      jpb = "jj git push --bookmark";
      jpc = "jj git push --change";
      jpd = "jj git push --deleted";
      jn = "jj new";
      jna = "jj new -A";
      jnb = "jj new -B";
      jnn = "jj new --no-edit";
      jnna = "jj new --no-edit -A";
      jnnb = "jj new --no-edit -B";
      jsq = "jj squash";
      jgr = "jj git remote";
      jgra = "jj git remote add";
      jgrl = "jj git remote list";
      jrb = "jj rebase";
      rbr = "jj rebase -r";
      rbs = "jj rebase -s";
      ja = "jj abandon";

      "!!" = {
        position = "anywhere";
        function = "last_history_item";
      };
    };

    functions = {
      last_history_item.body = "echo $history[1]";

      fish_greeting.body = ''
        if type -q fastfetch
          fastfetch
        end

        if type -q fortune
          fortune -s ~/.local/share/fortunes/ | fmt
          echo ""
        end
      '';

      source_if_exists.body = ''
        function source_if_exists -a file
            if test -e $file
                eval $file
            end
        end
      '';
    };
  };
}
