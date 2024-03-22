{
  dotfiles.theme.wallpapers = rec {
    all = {
      comfy_home = "https://raw.githubusercontent.com/catppuccin/wallpapers/main/misc/comfy-home.png";
      anime = {
        # Best name
        purple_waifu = "https://free4kwallpapers.com/uploads/originals/2020/08/27/tokyo-night-wallpaper.jpg";
        sangatsu = "https://w.wallhaven.cc/full/95/wallhaven-959zy8.png";
        purple_car = "https://raw.githubusercontent.com/dharmx/walls/b4c6dceceeea44091e6b794623abd797a9ec50dd/anime/5a1c8031-3c4e-4b2e-96ef-5b17d8c1c948.jpg";
        train = "https://raw.githubusercontent.com/dharmx/walls/b4c6dceceeea44091e6b794623abd797a9ec50dd/anime/32%20-%20rS9lewf.jpg";

        koucha = {
          wine = "https://i.pximg.net/img-master/img/2017/04/20/20/54/41/62494474_p0_master1200.jpg";
          night = "https://raw.githubusercontent.com/dharmx/walls/b4c6dceceeea44091e6b794623abd797a9ec50dd/anime/1610796908965.jpg"; # banger
        };
      };
      vertical = {
        yellow_beret = "https://w.wallhaven.cc/full/pk/wallhaven-pky7ym.jpg";
        koucha_bench = "https://pbs.twimg.com/media/DiIUpziUcAAJe24.jpg";
        mountain = "https://raw.githubusercontent.com/dharmx/walls/b4c6dceceeea44091e6b794623abd797a9ec50dd/mountain/sascha-bosshard-n8WT_zhU6cg-unsplash.jpg";
      };
      landscape = {
        night_kingdom = "https://i.imgur.com/LT9xCFE.jpeg";
        yosemite = "https://raw.githubusercontent.com/Gingeh/wallpapers/main/landscapes/yosemite.png";
        evening_sky = "https://raw.githubusercontent.com/Gingeh/wallpapers/main/landscapes/evening-sky.png";
        dreamcore = "https://raw.githubusercontent.com/dharmx/walls/b4c6dceceeea44091e6b794623abd797a9ec50dd/dreamcore/dorian-przystalski-UDy3uvI5DaI-unsplash.jpg";
        mountains = {
          fuji = "https://raw.githubusercontent.com/dharmx/walls/b4c6dceceeea44091e6b794623abd797a9ec50dd/mountain/clay-banks-u27Rrbs9Dwc-unsplash.jpg";
          blueish = "https://raw.githubusercontent.com/dharmx/walls/b4c6dceceeea44091e6b794623abd797a9ec50dd/mountain/poon_hill_histan_mandali.jpg";
          snow = "https://raw.githubusercontent.com/dharmx/walls/b4c6dceceeea44091e6b794623abd797a9ec50dd/cold/mountain.jpg";
        };
      };
      cherry = {
        purple = "https://raw.githubusercontent.com/dharmx/walls/b4c6dceceeea44091e6b794623abd797a9ec50dd/cherry/nikhil-kumar-JdPHvI7VF0o-unsplash.jpg";
        simple = "https://raw.githubusercontent.com/dharmx/walls/b4c6dceceeea44091e6b794623abd797a9ec50dd/cherry/Light-Floral-01.png";
      };
    };

    active = with all; [
      landscape.mountains.fuji
      anime.koucha.night
    ];
  };
}
