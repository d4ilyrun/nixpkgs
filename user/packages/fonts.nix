{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    # Fonts
    fira-code
    roboto-mono
    iosevka
    terminus_font

    # Icon fonts
    font-awesome
    fira-code-symbols
    material-design-icons
  ];
}
