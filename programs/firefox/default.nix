{ pkgs, my, lib, ... }:

{
  enable = true;

  extensions = with pkgs.nur.repos.rycee.firefox-addons; [
    darkreader
    https-everywhere
    refined-github
    return-youtube-dislikes
    ublock-origin
    videospeed
    vim-vixen
  ];

  profiles = {
    "${my.config.username}" = {
      name = my.config.username;
      isDefault = true;
      
      settings = {
        "browser.startup.homepage" = "https://nixos.org";
        "browser.search.region" = "US";
        "browser.search.isUS" = true;
        "distribution.searchplugins.defaultLocale" = "en-US";
        "general.useragent.locale" = "en-US";
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true; # userChrome
        "layout.css.backdrop-filter.enabled" = true; # blur style
      };

      userChrome = builtins.readFile "${my.config.nixpkgs}/programs/firefox/tokyo-night-fox/chrome/userChrome.css";
      userContent = builtins.readFile "${my.config.nixpkgs}/programs/firefox/tokyo-night-fox/chrome/userContent.css";

      bookmarks = {};
    };
  };
}