{ ... }:
let
  mod = "Mod4";
  menuCmd = "rofi -terminal 'ghostty' -show combi -combi-modes drun#run -modes combi";
in
{
  wayland.windowManager.sway = {
    enable = true;

    # sway is installed as an OS package, not via nix.
    # Beware: this disables auto-reloading sway on config activation.
    package = null;
    checkConfig = false;

    systemd = {
      enable = true;
      variables = [
        "WAYLAND_DISPLAY"
        "XDG_CURRENT_DESKTOP=sway"
      ];
    };

    config = {
      modifier = mod;
      terminal = "ghostty";
      menu = menuCmd;

      fonts = {
        names = [
          "MonoLisaText"
          "Symbols Nerd Font Mono"
          "Noto Color Emoji"
        ];
        size = 10.0;
      };

      input = {
        "type:keyboard" = {
          repeat_delay = "200";
          repeat_rate = "50";
          xkb_options = "caps:escape,compose:ralt";
        };
        "type:touchpad".natural_scroll = "enabled";
      };

      output = {
        "*" = {
          bg = "#000000 solid_color";
        };
      };

      keybindings = {
        "${mod}+Return" = "exec ghostty";
        "${mod}+d" = menuCmd;
        "${mod}+Shift+q" = "kill";
        "${mod}+p" = "exec grim -g \"$(slurp)\" - | swappy -f -";
        "${mod}+Shift+p" = "exec grim - | swappy -f -";
        "${mod}+Shift+c" = "reload";
        "${mod}+Shift+e" = ''
          exec swaynag -t warning \
            -m 'You pressed the exit shortcut. Do you really want to exit sway? This will end your Wayland session.' \
            -B 'Yes, exit sway' 'swaymsg exit'
        '';

        "${mod}+h" = "focus left";
        "${mod}+j" = "focus down";
        "${mod}+k" = "focus up";
        "${mod}+l" = "focus right";
        "${mod}+Left" = "focus left";
        "${mod}+Down" = "focus down";
        "${mod}+Up" = "focus up";
        "${mod}+Right" = "focus right";

        "${mod}+Shift+h" = "move left";
        "${mod}+Shift+j" = "move down";
        "${mod}+Shift+k" = "move up";
        "${mod}+Shift+l" = "move right";
        "${mod}+Shift+Left" = "move left";
        "${mod}+Shift+Down" = "move down";
        "${mod}+Shift+Up" = "move up";
        "${mod}+Shift+Right" = "move right";

        "${mod}+1" = "workspace number 1";
        "${mod}+2" = "workspace number 2";
        "${mod}+3" = "workspace number 3";
        "${mod}+4" = "workspace number 4";
        "${mod}+5" = "workspace number 5";
        "${mod}+6" = "workspace number 6";
        "${mod}+7" = "workspace number 7";
        "${mod}+8" = "workspace number 8";
        "${mod}+9" = "workspace number 9";
        "${mod}+0" = "workspace number 10";

        "${mod}+Shift+1" = "move container to workspace number 1";
        "${mod}+Shift+2" = "move container to workspace number 2";
        "${mod}+Shift+3" = "move container to workspace number 3";
        "${mod}+Shift+4" = "move container to workspace number 4";
        "${mod}+Shift+5" = "move container to workspace number 5";
        "${mod}+Shift+6" = "move container to workspace number 6";
        "${mod}+Shift+7" = "move container to workspace number 7";
        "${mod}+Shift+8" = "move container to workspace number 8";
        "${mod}+Shift+9" = "move container to workspace number 9";
        "${mod}+Shift+0" = "move container to workspace number 10";

        "${mod}+Control+Shift+Right" = "move workspace to output right";
        "${mod}+Control+Shift+Left" = "move workspace to output left";
        "${mod}+Control+Shift+Down" = "move workspace to output down";
        "${mod}+Control+Shift+Up" = "move workspace to output up";

        "${mod}+Control+Shift+l" = "move workspace to output right";
        "${mod}+Control+Shift+h" = "move workspace to output left";
        "${mod}+Control+Shift+j" = "move workspace to output down";
        "${mod}+Control+Shift+k" = "move workspace to output up";

        "${mod}+b" = "splith";
        "${mod}+v" = "splitv";
        "${mod}+s" = "layout stacking";
        "${mod}+w" = "layout tabbed";
        "${mod}+e" = "layout toggle split";
        "${mod}+f" = "fullscreen";
        "${mod}+Shift+space" = "floating toggle";
        "${mod}+space" = "focus mode_toggle";
        "${mod}+a" = "focus parent";

        "${mod}+Shift+minus" = "move scratchpad";
        "${mod}+minus" = "scratchpad show";

        "${mod}+r" = "mode resize";
      };

      startup = [
        {
          command = ''
            swayidle -w \
              timeout 300 'swaylock -fF' \
              timeout 1200 'swaymsg "output * dpms off"' \
              resume 'swaymsg "output * dpms on"' \
              before-sleep 'swaylock -fF'
          '';
        }
        { command = "gsettings set org.gnome.desktop.interface gtk-theme 'Breeze-Dark'"; }
        { command = "gsettings set org.gnome.desktop.interface icon-theme 'breeze-dark'"; }
        { command = "gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'"; }
        { command = "lookandfeeltool -platform offscreen --apply \"org.kde.breezedark.desktop\""; }
        { command = "blueman-applet"; }
        { command = "nm-applet --indicator"; }
        { command = "/usr/libexec/polkit-mate-authentication-agent-1"; }
        { command = "systemctl start --user sway-session.service"; }
      ];

      bars = [
        {
          # equivalent of `swaybar_command waybar`
          command = "waybar";
          fonts = {
            names = [ "monospace" ];
            size = 8.0;
          };
        }
      ];
    };

    extraConfig = ''
      include '$(/usr/libexec/sway/layered-include "/usr/share/sway/config.d/*.conf" "/etc/sway/config.d/*.conf" "''${XDG_CONFIG_HOME:-$HOME/.config}/sway/config.d/*.conf")'
    '';
  };

  programs.swaylock = {
    enable = true;
    # swaylock is installed as an OS package, not via nix
    package = null;
    settings = {
      ignore-empty-password = true;
      color = "191724";
    };
  };

  xdg.configFile = {
    "waybar/config.jsonc".source = ./waybar/config.jsonc;
    "waybar/style.css".source = ./waybar/style.css;
  };
}
