{
  services.picom = {
    enable = true;

    fade = true;
    fadeDelta = 4;

    shadow = true;
    shadowOffsets = [ (-5) (-5) ];
    shadowOpacity = 0.7;
    shadowExclude = [
      "! name~=''"
      "name = 'Notification'"
      "name *= 'compton'"
      "name *= 'picom'"
      "class_g = 'Firefox' && argb"
    ];

    opacityRules = [
      #"100:class_g = 'Alacritty' && focused"
      #"90:class_g = 'Alacritty' && !focused"
    ];

    vSync = true;

    settings = {
      shadow.radius = 12;

      blur = {
        method = "dual_kawase";

        strength = 1.5;
        deviation = 1.0;

        background = true;
        background-frame = false;
        background-fixed = true;

        exclude = [
          "window_type = 'dock'"
          "class_g = 'slop'"
        ];
      };
    };
  };
}
