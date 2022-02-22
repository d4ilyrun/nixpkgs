{ my, pkgs, ...}:

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
        family = "FiraCode Nerd Font";
        #family = "JetBrainsMono Nerd Font";
        #family = "UbuntuMono Nerd Font";
        style = "Regular";
      };
      bold = {
        family = "FiraCode Nerd Font";
        #family = "JetBrainsMono Nerd Font";
        #family = "UbuntuMono Nerd Font";
        style = "Bold";
      };
      italic = {
        family = "FiraCode Nerd Font";
        #family = "JetBrainsMono Nerd Font";
        #family = "UbuntuMono Nerd Font";
        style = "Italic";
      };

      offset.y = 1;
    };

    colors = my.config.colorscheme;

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
