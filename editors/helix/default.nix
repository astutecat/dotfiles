{ pkgs, ... }:
{
  imports = [
    ./keys.nix
    ./languages
  ];

  programs.helix = {
    enable = true;
    defaultEditor = true;

    extraPackages = [
      (pkgs.writeShellScriptBin "other-file" # bash
        ''
            #!/usr/bin/env bash

            current_file=$1
            # Where to store the result to:
            output_file=$2

            if [ "$current_file" == "" ]; then
            	echo "No input file given!" >&2
            	exit 1
            fi
            if [ "$output_file" == "" ]; then
            	echo "No output file given!" >&2
            	exit 2
            fi

            # Search for files matching regex $2 in directory $1
            other_files() {
            	if [ ! -d "$1" ]; then
            		echo "No other file found" >&2
            		exit 3
            	fi

            	mapfile -t other_files < <(fd "$2" "$1")

            	if [ ''${#other_files[@]} == 0 ]; then
            		echo "No other file found" >&2
            		exit 4
            	elif [ ''${#other_files[@]} == 1 ]; then
            		echo "''${other_files[0]}" >$output_file
            	else
            		printf "%s\n" "''${other_files[@]}" | fzf >$output_file
            	fi
            }

            if echo "$current_file" | rg --quiet "src/.*\\.erl$"; then
            	# Find test files for erlang implementation file
            	dirname="$(dirname "$current_file")"
            	basename="$(basename "$current_file" ".erl")"

            	other_files "''${dirname}/../test" "''${basename}_(SUITE|tests)\\.erl"
            elif echo "$current_file" | rg --quiet "test/.*\\_SUITE.erl$"; then
            	# Find implementation file for erlang CT test file
            	dirname="$(dirname "$current_file")"
            	basename="$(basename "$current_file" "_SUITE.erl")"

            	other_files "''${dirname}/../src" "''${basename}\\.erl"
            elif echo "$current_file" | rg --quiet "test/.*\\_tests.erl$"; then
            	# Find implementation file for erlang Eunit test file
            	dirname="$(dirname "$current_file")"
            	basename="$(basename "$current_file" "_tests.erl")"

            	other_files "''${dirname}/../../src" "''${basename}\\.erl"
            else
          		echo "No other file found" >&2
           		exit 3
            fi
        ''
      )
    ];

    settings = {
      theme = "nightfox";
      editor = {
        # Use system clipboard
        default-yank-register = "+";

        # These may not get picked up properly in tmux
        true-color = true;
        undercurl = true;

        bufferline = "always";

        rulers = [
          80
          120
        ];

        completion-replace = true;

        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";
        };

        line-number = "relative";

        color-modes = true;
        trim-trailing-whitespace = true;
        popup-border = "all";

        indent-guides = {
          render = true;
          character = "┆";
          skip-levels = 1;
        };

        end-of-line-diagnostics = "disable";
        inline-diagnostics = {
          cursor-line = "hint";
          prefix-len = 1;
          max-diagnostics = 3;
        };

        file-picker.hidden = false;

        gutters = {
          line-numbers = {
            min-width = 4;
          };
        };

        auto-save = {
          focus-lost = true;
          after-delay = {
            enable = true;
            timeout = 10000; # ms
          };
        };

        statusline = {
          mode = {
            normal = "NORMAL";
            insert = "INSERT";
            select = "SELECT";
          };
          left = [
            "mode"
            "file-name"
            "read-only-indicator"
            "file-modification-indicator"
          ];
          center = [ ];
          right = [
            "spinner"
            "spacer"
            "version-control"
            "spacer"
            "diagnostics"
            "separator"
            "selections"
            "register"
            "separator"
            "position"
            "total-line-numbers"
            "position-percentage"
            "file-type"
          ];
          diagnostics = [
            "hint"
            "warning"
            "error"
          ];
          workspace-diagnostics = [
            "hint"
            "warning"
            "error"
          ];
        };
      };
    };
  };
}
