{ config, pkgs, ... }:

let
  inherit (config.dotfiles.folders) applications;
  inherit (config.dotfiles.extraOptions) terminal;
  defaultTerminal = "${pkgs.alacritty}/bin/alacritty";

  scripts = "${applications}/rofi/scripts";

  copyConfigs = names: builtins.listToAttrs (
    map
      (name: pkgs.lib.attrsets.nameValuePair
        "rofi/themes/${name}.rasi"
        {
          enable = true;
          source = "${applications}/rofi/${name}.rasi";
        }
      )
      names
  );

in
{
  xdg.configFile = copyConfigs [ "config" "powermenu" "screenshot" ];

  programs.rofi = {
    enable = true;
    terminal = defaultTerminal;

    plugins = [
      pkgs.rofi-calc
      pkgs.rofi-emoji
    ];

    cycle = false;

    extraConfig = {
      modi = "drun,run,window";
      font = "JetBrainsMono Nerd Font Medium 14";
      location = 0;

      drun-display-format = "{icon} {name}";
      display-window = "   Windows ";
      display-drun = "  Apps ";
      display-run = "   Run ";

      show-icons = true;
      sidebar-mode = true;
      hide-scrollbar = true;
      disable-history = false;
    };

    theme = "${applications}/rofi/config.rasi";
  };

  xsession.windowManager.i3.config.keybindings = pkgs.lib.mkOptionDefault {
    "Mod4+d" = "exec rofi -show drun -show drun -show-icons -terminal ${terminal}";
    "Mod4+Shift+d" = "exec rofi -sho-icons -show window";
    "Mod4+Shift+e" = "exec ${scripts}/powermenu.sh";
    "Mod4+Shift+c" = "exec rofi -show calc -modi calc -display-calc 󰃬 -terse | xsel -b";
    "Mod4+Shift+w" = "exec ${scripts}/network.sh";
    "Mod4+comma" = "exec rofi -modi emoji -show emoji -emoji-mode insert";
    "Mod4+Shift+s" = "exec ${scripts}/screenshot.sh";
    "XF86Display" = "exec ${scripts}/autorandr.sh";
  };
} // (
  # Copy all config files into the config folder
  { }
)
