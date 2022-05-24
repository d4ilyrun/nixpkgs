with import <nixpkgs>;

# Sources:
# - wallhaven.cc
# - pixiv

with builtins; {

  # Light
  dotusknot = builtins.fetchurl {
    url = "https://raw.githubusercontent.com/notusknot/dotfiles-nix/51aaf92e0f7c74c337ad0797fa9bfd4d34243a99/config/pics/wallpaper.png";
    sha256 = "1bbxc4ly7cxvsg6y8sagvxvl4qhgfhcbw3rpcisnr2szcn1m4cmv";
  };

  # Purple

  comfy-home = builtins.fetchurl {
    url = "https://raw.githubusercontent.com/catppuccin/wallpapers/main/misc/comfy-home.png";
  };

  anime = {
    sangatsu = builtins.fetchurl { url = "https://w.wallhaven.cc/full/95/wallhaven-959zy8.png"; };

    # Best name
    purpleWaifu = builtins.fetchurl {
      url = "https://free4kwallpapers.com/uploads/originals/2020/08/27/tokyo-night-wallpaper.jpg";
      sha256 = "03vzh46wi4l5jm65n9303n89pgvg5r5w0ynhzsbp7cfminfx6qjz";
    };

    koucha_wine = builtins.fetchurl { url = "https://i.pximg.net/img-master/img/2017/04/20/20/54/41/62494474_p0_master1200.jpg"; };
  };

  vertical = {
    anime = {
      yellow_beret = builtins.fetchurl { url = "https://w.wallhaven.cc/full/pk/wallhaven-pky7ym.jpg"; };
      koucha_bench = builtins.fetchurl { url = "https://pbs.twimg.com/media/DiIUpziUcAAJe24.jpg"; };
    };
  };
}
