{pkgs}:

{
  home.packages = [ pkgs.picom ];

  services.picom = {
    enable = true;
    experimentalBackends = false;

    fade = false;
    fadeDelta = 4;
    blur=false;

    shadow = true;
    shadowOffsets = [ (-5) (-5) ];
    shadowOpacity = "0.5";
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
    blur-background = false;
    '';
  };
}
