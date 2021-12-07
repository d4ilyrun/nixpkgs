{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    # Fonts
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
