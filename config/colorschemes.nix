{
  tokyonight = rec {
    primary = {
      background = "#24283b";
      foreground = "#c0caf5";
      accent = normal.magenta;
    };

    normal = {
      black = "#1D202F";
      red = "#f7768e";
      green = "#9ece6a";
      yellow = "#e0af68";
      blue = "#7aa2f7";
      magenta = "#bb9af7";
      cyan = "#7dcfff";
      white = "#a9b1d6";
    };

    bright = {
      black = "#414868";
      red = "#f7768e";
      green = "#9ece6a";
      yellow = "#e0af68";
      blue = "#7aa2f7";
      magenta = "#bb9af7";
      cyan = "#7dcfff";
      white = "#c0caf5";
    };

    polybar = {
      background = normal.black;
      foreground = primary.foreground;
      foreground-dark = "#484848";
    };
  };

  nord = {
    primary = {
      background = "#2e3440";
      foreground = "#d0d0d0";
    };

    normal = {
      black = "#434759";
      red = "#f07178";
      green = "#c3e88d";
      yellow = "#ffcb6b";
      blue = "#82aaff";
      magenta = "#c792ea";
      cyan = "#89ddff";
      white = "#d0d0d0";
    };

    bright = {
      black = "#434758";
      red = "#ff8b92";
      green = "#ddffa7";
      yellow = "#ffe585";
      blue = "#9cc4ff";
      magenta = "#e1acff";
      cyan = "#a3f7ff";
      white = "#fefefe";
    };

    selection = {
      text = "#eceef0";
      background = "#607c8b";
    };
  };

  dracula = {
    primary = {
      background = "#282a36";
      foreground =  "#f8f8f2";
    };
    
    selection = {
      text = "CellForeground";
      background = "#44475a";
    };

    normal = {
      black = "#21222c";
      red = "#ff5555";
      green = "#50fa7b";
      yellow = "#f1fa8c";
      blue = "#bd93f9";
      magenta = "#ff79c6";
      cyan = "#8be9fd";
      white = "#f8f8f2";
    };

    bright = {
      black = "#6272a4";
      red = "#ff6e6e";
      green = "#69ff94";
      yellow = "#ffffa5";
      blue = "#d6acff";
      magenta = "#ff92df";
      cyan = "#a4ffff";
      white = "#ffffff";
    };
  };
}
