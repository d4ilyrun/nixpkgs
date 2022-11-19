{ config, pkgs, ... }:

{
  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    # Fonts
    fira
    fira-code
    roboto-mono
    iosevka
    terminus_font
    unifont
    jetbrains-mono

    # Icon fonts
    font-awesome
    fira-code-symbols
    material-design-icons
    unifont_upper
  ];
}
