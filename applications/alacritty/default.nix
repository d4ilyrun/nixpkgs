{ config, pkgs, ... }:

{
  programs.alacritty = {

    enable = true;

    settings = {
      live_config_reload = true;

      env = {
        "TERM" = "xterm-256color";
      };

      window = {
        dynamic_padding = true;
        title = "Alacritty";
        opacity = 1; # 0.93
      };

      font = {
        size = 8.0;

        normal = {
          family = "FiraCode Nerd Font";
          style = "Regular";
        };
        bold = {
          family = "FiraCode Nerd Font";
          style = "Bold";
        };
        italic = {
          family = "FiraCode Nerd Font";
          style = "Italic";
        };

        offset.y = 1;
      };

      colors = config.dotfiles.theme.colors;

      shell = {
        program = "${pkgs.fish}/bin/fish";
        # args = [ "-C" "neofetch" ];
      };

      key_bindings = [
        { key = "N"; mods = "Control"; action = "SpawnNewInstance"; }
        { key = "Equals"; mods = "Control|Alt"; action = "ResetFontSize"; }
      ];
    };
  };
}
