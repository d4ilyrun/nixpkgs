{ config, ... }:

with config.dotfiles.theme.colors;

{
  xdg.configFile."rofi/themes/dotfiles.rasi" = {
    enable = true;
    text = ''
      * {
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
          accent: ${primary.accent};
      }
    '';
  };
}
