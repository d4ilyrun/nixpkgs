{pkgs, ...}:
#~/.config/nixpkgs/programs/alacritty/default-settings.nix
let
  my = import ~/.config/nixpkgs/config;
in
{
  enable = true;

  settings = 
  {
    live_config_reload = true;

    env = {
      "TERM" = "xterm-256color";
    };

    window = {
      dynamic_padding = true;
      title = "Alacritty";
    };

    font = {
      size = 8.0;

      normal = {
        family = "Fira Code";
        style = "Regular";
      };
      bold = {
        family = "Fira Code";
        style = "Bold";
      };
      italic = {
        family = "Fira Code";
        style = "Italic";
      };

      offset.y = 1;
    };

    colors = my.colorschemes.tokyonight;

    background_opacity = 0.93;

    shell = {
      program = "${pkgs.fish}/bin/fish";
      args = [ "-C" "neofetch" ];
    };

    key_bindings = [
      { key = "N"; mods = "Control"; action = "SpawnNewInstance"; }
      { key = "Equals"; mods = "Control|Alt"; action = "ResetFontSize"; }
    ];
  };
}
