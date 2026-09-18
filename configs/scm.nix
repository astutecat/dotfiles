{
  config,
  pkgs,
  lib,
  homeDirectory,
  isWorkMachine,
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

  # Repos that should be registered for `git maintenance` and, when
  # `myReposInclude` is true (default false), for `mr` (myrepos) if/when they
  # are checked out on this machine. Existence can't reliably be checked at
  # Nix evaluation time (flake evaluation is pure and can't see the real
  # filesystem), so the actual filtering happens at Home Manager activation
  # time instead (see the myReposUpdate and gitMaintenanceUpdate scripts
  # below).
  mkRepo =
    path:
    {
      myReposInclude ? false,
    }:
    {
      path = repoDir path;
      # mr resolves section names against the directory containing
      # ~/.mrconfig, so relative names keep working wherever $HOME points.
      myReposSection = "repos/${path}";
      inherit myReposInclude;
    };

  candidateRepos = [
    (mkRepo "dotfiles" { myReposInclude = true; })
    (mkRepo "astutecat_infrastructure" { })
    (mkRepo "kiezburn/public" { })
    (mkRepo "kiezburn/deployments" { })
    (mkRepo "demand-response-rs" { })
    (mkRepo "entag-development" { })
    (mkRepo "eto-rts" { })
    (mkRepo "eto-sentinel" { })
    (mkRepo "eto-services" { })
    (mkRepo "albuinn" { })
  ];

  maintenanceCandidateRepos = map (repo: repo.path) candidateRepos;

  # Generated fragment holding the `maintenance.repo` entries. It sits next to
  # the managed ~/.config/git/config and is pulled in via an include; see
  # gitMaintenanceUpdate below for why it can't go in that file directly.
  maintenanceConfigPath = "${homeDirectory}/.config/git/maintenance";

  myReposSections = map (repo: repo.myReposSection) (
    lib.filter (repo: repo.myReposInclude) candidateRepos
  );

  # The static sections of ~/.mrconfig come from programs.mr.settings; this
  # is the generated baseline the mr module links into place.
  myReposBaseline = config.home.file.".mrconfig".source;

  # Registers every listed repo with a .git directory for `git maintenance`.
  #
  # The entries can't be written into ~/.config/git/config itself: that file is
  # a read-only symlink into the Nix store, so `git config --global` can't lock
  # it and writes to ~/.gitconfig instead. Regenerating a separate fragment
  # under ~/.config/git keeps the entries in the XDG config directory (via the
  # include added to programs.git.includes) while still filtering against the
  # real filesystem at activation time.
  gitMaintenanceUpdate = pkgs.writers.writeFishBin "update-git-maintenance" ''
    # Usage: update-git-maintenance REPO...
    set -x PATH $PATH ${lib.makeBinPath [ pkgs.git ]}

    set -l candidates $argv
    set -l target ${maintenanceConfigPath}
    set -l tmp $target.tmp

    # Build next to the target so the final mv is an atomic rename on the same
    # filesystem; the fixed temp name self-heals after a crashed run.
    rm -f $tmp; or exit 1
    printf '[maintenance]\n' > $tmp; or exit 1

    for repo in $candidates
      if test -d $repo/.git
        printf '\trepo = %s\n' $repo >> $tmp; or exit 1
      end
    end

    mv $tmp $target; or exit 1

    # Earlier revisions wrote these entries into ~/.gitconfig through
    # `git config --global`; drop them so the list has a single managed source.
    if test -f $HOME/.gitconfig
      git config --global --unset-all maintenance.repo 2>/dev/null; or true
    end
  '';

  # Rebuilds ~/.mrconfig from the declarative baseline plus a managed
  # section per checked-out repo. Bare sections let mr auto-detect the VCS,
  # and skip = lazy makes mr skip any repo that disappears before the next
  # activation instead of erroring.
  myReposUpdate = pkgs.writers.writeFishBin "update-mrconfig" ''
    # Usage: update-mrconfig MRCONFIG BASELINE SECTION...
    set -x PATH $PATH ${lib.makeBinPath [ pkgs.coreutils ]}

    set -l mrconfig $argv[1]
    set -l baseline $argv[2]
    set -l sections $argv[3..]

    # Build the file next to the target so the final mv is an atomic rename
    # on the same filesystem. The fixed temp name self-heals: a stale file
    # left by a crashed run is removed here and never accumulates.
    set -l tmp $mrconfig.tmp
    rm -f $tmp; or exit 1

    cat $baseline > $tmp; or exit 1
    if test -s $tmp
      printf '\n' >> $tmp; or exit 1
    end

    for section in $sections
      if test -d $HOME/$section/.git
        printf '[%s]\nskip = lazy\n\n' $section >> $tmp; or exit 1
      end
    end

    mv $tmp $mrconfig; or exit 1
  '';
in
{
  programs = {
    mr = {
      enable = true;
      # Static sections of ~/.mrconfig. The dynamic per-repo sections are
      # added by the myReposConfig activation script below, which rebuilds
      # the file wholesale.
    };

    git = {
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
        difftool = {
          prompt = false;
          bc3.trustExitCode = true;
          difftastic.cmd = "difft \"$LOCAL\" \"$REMOTE\"";
        };
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

      includes = lib.optionals isWorkMachine aenergiIncludes ++ [
        { path = maintenanceConfigPath; }
      ];
    };

    jujutsu = {
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

    delta = {
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

    difftastic = {
      enable = true;
      jujutsu.enable = true;
    };
  };

  home = {
    packages = with pkgs; [
      prek
      gh
      stgit
    ];

    # The activation script below rewrites ~/.mrconfig after linkGeneration,
    # so force the relink on the next switch; the script rebuilds it anyway.
    file.".mrconfig".force = true;

    # Maintenance and mr registration can't be expressed declaratively:
    # `git maintenance.repo` only applies to repos that actually exist, and
    # existence can't be checked at Nix evaluation time (flake evaluation is
    # pure and can't see the real filesystem). Both are therefore generated at
    # activation time after linkGeneration, once managed files have been
    # (re)linked. The maintenance entries land in ~/.config/git/maintenance
    # (included by the managed git config) because ~/.config/git/config itself
    # is a read-only store symlink.
    activation = {
      gitMaintenanceRepos = lib.hm.dag.entryAfter [ "linkGeneration" ] ''
        ${lib.getExe gitMaintenanceUpdate} ${lib.escapeShellArgs maintenanceCandidateRepos}
      '';

      myReposConfig = lib.hm.dag.entryAfter [ "linkGeneration" ] ''
        ${lib.getExe myReposUpdate} \
          "$HOME/.mrconfig" \
          "${myReposBaseline}" \
          ${lib.escapeShellArgs myReposSections}
      '';
    };
  };
}
