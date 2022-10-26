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
      foreground = "#f8f8f2";
      accent = "#ff5555";
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

  tokyodark = rec {
    primary = {
      background = "#11121D";
      foreground = "#a9b1d6";
      accent = normal.magenta;
    };
    normal = {
      black = "#32344a";
      red = "#f7768e";
      green = "#9ece6a";
      yellow = "#e0af68";
      blue = "#7aa2f7";
      magenta = "#ad8ee6";
      cyan = "#449dab";
      white = "#787c99";
    };
    bright = {
      black = "#444b6a";
      red = "#ff7a93";
      green = "#b9f27c";
      yellow = "#ff9e64";
      blue = "#7da6ff";
      magenta = "#bb9af7";
      cyan = "#0db9d7";
      white = "#acb0d0";
    };
  };

  onedark = rec {
    primary = {
      background = normal.black;
      foreground = normal.white;
      accent = normal.red;
    };

    normal = {
      black = "#282C34";
      red = "#e06c75";
      green = "#98c379";
      yellow = "#E5C07B";
      blue = "#61afef";
      magenta = "#c678dd";
      cyan = "#56b6c2";
      white = "#ABB2BF";
    };

    bright = {
      black = "#282C34";
      red = "#e06c75";
      green = "#98c379";
      yellow = "#E5C07B";
      blue = "#61afef";
      magenta = "#c678dd";
      cyan = "#56b6c2";
      white = "#ABB2BF";
    };
  };

  catpuccin = rec {
    primary = {
      background = "#1E1D2F";
      foreground = "#D9E0EE";
      accent = normal.magenta;
    };

    cursor = {
      text = "#1E1D2F";
      cursor = "#F5E0DC";
    };

    normal = {
      black = "#6E6C7E";
      red = "#F28FAD";
      green = "#ABE9B3";
      yellow = "#FAE3B0";
      blue = "#96CDFB";
      magenta = "#F5C2E7";
      cyan = "#89DCEB";
      white = "#D9E0EE";
    };

    bright = {
      black = "#988BA2";
      red = "#F28FAD";
      green = "#ABE9B3";
      yellow = "#FAE3B0";
      blue = "#96CDFB";
      magenta = "#F5C2E7";
      cyan = "#89DCEB";
      white = "#D9E0EE";
    };
  };
}
