{ config, ... }:

{
  home.sessionVariables = rec {
    MANPAGER = "sh -c 'col -bx | bat -l man -p --theme ansi'";
    BAT_THEME = "ansi";
    MANROFFOPT = "-c";
  };

  programs.bat = {
    enable = true;
    config.pager = "less -FR";
  };
}
