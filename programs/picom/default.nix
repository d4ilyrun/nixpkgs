{ pkgs }:

{
  home.packages = [ pkgs.picom ];

  services.picom = {
    enable = true;
    experimentalBackends = false;

    fade = true;
    fadeDelta = 4;

    blur = true;
    blurExclude = [
      "window_type = 'dock'"
      "class_g = 'slop'"
    ];

    shadow = true;
    shadowOffsets = [ (-5) (-5) ];
    shadowOpacity = "0.7";
    shadowExclude = [
      "! name~=''"
      "name = 'Notification'"
      "name *= 'compton'"
      "name *= 'picom'"
      "class_g = 'Firefox' && argb"
    ];

    opacityRule = [
      "100:class_g = 'Alacritty' && focused"
      "90:class_g = 'Alacritty' && !focused"
    ];

    vSync = true;

    extraOptions = ''
      shadow-radius = 12;

      blur: {
        method = "dual_kawase";
        # method = "kernel";
        strength = 1.5;
        deviation = 1.0;
        # kernel = "11x11gaussian";
        background = true;
        background-frame = false;
        background-fixed = true;
        # kern = "3x3box";
      }
    '';
  };
}
