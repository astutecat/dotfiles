{
  config,
  pkgs,
  lib,
  homeDirectory,
  ...
}:

let
  aenergiRemotePatterns = [
    "https://github.com/aenergi/**"
    "git@github.com:aenergi/*"
  ];

  aenergiIdentity = {
    user = {
      name = "Will Rogers";
      email = "william.rogers@entelios.com";
      signingKey = "469E3543DCF12EB0";
    };
    core.sshCommand = "ssh -i ${homeDirectory}/.ssh/id_entelios.pub -o IdentitiesOnly=yes";
  };

  aenergiIncludes = map (remote: {
    condition = "hasconfig:remote.*.url:${remote}";
    contentSuffix = "aenergi-gitconfig";
    contents = aenergiIdentity;
  }) aenergiRemotePatterns;

  repoDir = p: "${homeDirectory}/repos/${p}";

  # Repos that should be registered for `git maintenance` if/when they are
  # checked out on this machine. Existence can't reliably be checked at Nix
  # evaluation time (flake evaluation is pure and can't see the real
  # filesystem), so the actual filtering happens at Home Manager activation
  # time instead (see the gitMaintenanceRepos activation script below).
  maintenanceCandidateRepos = map repoDir [
    "dotfiles"
    "astutecat_infrastructure"
    "kiezburn/public"
    "kiezburn/deployments"
    "demand-response-rs"
    "entag-development"
    "eto-rts"
    "eto-sentinel"
    "eto-services"
  ];
in
{
  home.packages = with pkgs; [
    prek
    gh
    stgit
  ];

  programs.mr = {
    enable = true;
  };

  programs.git = {
    enable = true;
    package = pkgs.gitFull;

    maintenance = {
      enable = true;
    };

    settings = {
      user = {
        name = "Will Rogers";
        email = "github@astutecat.dev";
      };
      commit.gpgSign = false;
      diff.tool = "difftastic";
      difftool.prompt = false;
      difftool.bc3.trustExitCode = true;
      difftool.difftastic.cmd = "difft \"$LOCAL\" \"$REMOTE\"";
      alias = {
        dft = "difftool -t difftastic";
        dfts = "dft --staged";
        fpush = "push --force-with-lease --force-if-includes";
        shhh = "fpush";
        sw = "switch";
        res = "restore";
        prune-branches = "!git remote prune origin && git branch -vv | grep ': gone]' | awk '{print $1}' | xargs -r git branch -d";
        prune-branches-force = "!git remote prune origin && git branch -vv | grep ': gone]' | awk '{print $1}' | xargs -r git branch -D";
      };
      gc.autoDetach = false;
      init = {
        defaultBranch = "main";
        templateDir = "${homeDirectory}/.git-template";
      };
      core = {
        editor = config.home.sessionVariables.EDITOR;
        pager = "delta";
      };
      advice = {
        detachedHead = false;
        skippedCherryPicks = false;
      };
      rebase = {
        autoStash = true;
        updateRefs = true;
        autoSquash = true;
      };
      push = {
        recurseSubmodules = "check";
        default = "current";
        autoSetupRemote = true;
      };
      pull = {
        rebase = true;
        useForceIfIncludes = true;
      };
      column.ui = "auto";
      branch.sort = "-committerdate";
      rerere = {
        enabled = true;
        autoUpdate = true;
      };
      absorb.autoStageIfNothingStaged = true;
      checkout = {
        defaultRemote = "origin";
        workers = -1;
      };
    };

    signing.key = "3BD453E1C45430E8";

    includes = aenergiIncludes;
  };

  programs.jujutsu = {
    enable = true;

    settings = {
      user = {
        name = "Will Rogers";
        email = "github@astutecat.dev";
      };
      ui = {
        pager = "cat";
        default-command = [
          "log"
          "--reversed"
        ];
      };
      aliases = {
        fetch = [
          "git"
          "fetch"
        ];
        rlog = [
          "log"
          "--reversed"
        ];
      };
      remotes.origin.auto-track-created-bookmarks = "*";
    };
  };

  programs.delta = {
    enable = true;
    enableGitIntegration = true;
    options = {
      line-numbers = true;
      hunk-header-decoration-style = "";
      file-decoration-style = "";
      hunk-header-style = "syntax";
      hunk-header-file-style = "brightblue";
      file-style = "brightblue";
      minus-style = "syntax \"#37222c\"";
      minus-non-emph-style = "syntax \"#37222c\"";
      minus-emph-style = "syntax \"#713137\"";
      minus-empty-line-marker-style = "syntax \"#37222c\"";
      line-numbers-minus-style = "#b2555b";
      plus-style = "syntax \"#20303b\"";
      plus-non-emph-style = "syntax \"#20303b\"";
      plus-emph-style = "syntax \"#2c5a66\"";
      plus-empty-line-marker-style = "syntax \"#20303b\"";
      line-numbers-plus-style = "#266d6a";
      line-numbers-zero-style = "#3b4261";
    };
  };

  programs.difftastic = {
    enable = true;
    jujutsu.enable = true;
  };

  # `git config --global maintenance.repo` can't be set declaratively based on
  # whether a repo actually exists (Nix evaluation is pure and can't see the
  # real filesystem), so register only the repos that exist on this machine
  # here instead, at activation time.
  home.activation.gitMaintenanceRepos = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    gitCommand="${lib.getExe pkgs.git}"
    maintenanceRepos=(
      ${lib.concatMapStringsSep "\n" lib.escapeShellArg maintenanceCandidateRepos}
    )

    # Print configured repositories that are absent from maintenanceRepos:
    # -F treats paths literally, -x matches complete lines, and -v excludes matches.
    unmanagedMaintenanceRepos=$(
      "$gitCommand" config --global --get-all maintenance.repo 2>/dev/null \
        | grep -vFxf <(printf '%s\n' "''${maintenanceRepos[@]}") \
        || true
    )
    if [ "$unmanagedMaintenanceRepos" != "" ]; then
      warnEcho "The following git maintenance.repo entries are not managed by Nix and will be removed: $(printf '%s\n' "$unmanagedMaintenanceRepos" | tr '\n' ' ')"
    fi

    "$gitCommand" config --global --unset-all maintenance.repo 2>/dev/null || true
    for repo in "''${maintenanceRepos[@]}"; do
      if [ -d "$repo/.git" ]; then
        "$gitCommand" config --global --add maintenance.repo "$repo"
      fi
    done
  '';
}
