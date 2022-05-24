{ pkgs }:

{
  home.packages = [ pkgs.picom ];

  services.picom = {
    enable = true;
    experimentalBackends = false;

    fade = true;
    fadeDelta = 4;

    blur=true;

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

    vSync = false;

    extraOptions = ''
    shadow-radius = 12;
    '';
  };
}
