{
  dotfiles.theme.wallpapers = rec {
    all = {
      comfy_home = "https://raw.githubusercontent.com/catppuccin/wallpapers/main/misc/comfy-home.png";
      anime = {
        # Best name
        purple_waifu = "https://free4kwallpapers.com/uploads/originals/2020/08/27/tokyo-night-wallpaper.jpg";
        koucha_wine = "https://i.pximg.net/img-master/img/2017/04/20/20/54/41/62494474_p0_master1200.jpg";
        sangatsu = "https://w.wallhaven.cc/full/95/wallhaven-959zy8.png";
      };
      vertical = {
        yellow_beret = "https://w.wallhaven.cc/full/pk/wallhaven-pky7ym.jpg";
        koucha_bench = "https://pbs.twimg.com/media/DiIUpziUcAAJe24.jpg";
      };
    };

    active = with all; [
      anime.sangatsu
      vertical.koucha_bench
    ];
  };
}
