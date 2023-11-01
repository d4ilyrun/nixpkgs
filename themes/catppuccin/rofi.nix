{ config, ... }:

with config.dotfiles.theme.colors;

{
  xdg.configFile."rofi/theme/theme.rasi" = {
    enable = true;
    text = ''
      * {
          width: 600;

          background:  #181825;
          background-alt: #11111b;
          foreground: #cdd6f4;
          foreground-alt: #f38ba8;
          border: #1e1e2e;
          selected: #1e1e2e;
          grey: #6c7086;
          blue: #89b4fa;
          red: ${normal.red};
          green: ${normal.green};
      }
    '';
  };
}
