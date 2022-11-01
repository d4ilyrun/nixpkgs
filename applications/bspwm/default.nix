{ pkgs, my }:

{
  xsession.windowManager.bspwm = {

    enable = true;

    settings = {
      left_padding = 46;
      border_width = 4;
      window_gap = 10;
      split_ratio = 0.5;

      borderless_monocle = true;
      gapless_monocle = true;
      focus_follows_pointer = true;
    };

    rules = { };

    startupPrograms = [
      "${pkgs.feh}/bin/feh --bg-scale ${my.config.wallpaper}"
      "${pkgs.betterlockscreen}/bin/betterlockscreen -u ${my.config.wallpaper}"
      "${pkgs.eww}/bin/eww -c ${my.config.nixpkgs}/applications/eww/bar"
      "${pkgs.autorandr}/bin/autorandr -c"
    ];

  };
}
