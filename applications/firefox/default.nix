{ config, pkgs, lib, ... }:

{
  programs.firefox = {
    enable = true;

  extensions = with pkgs.nur.repos.rycee.firefox-addons; [
    darkreader
    refined-github
    return-youtube-dislikes
    ublock-origin
    c-c-search-extension
    consent-o-matic
    onepassword-password-manager
  ];

    profiles = {
      "${config.dotfiles.username}" = {
        name = config.dotfiles.username;
        isDefault = true;

        settings = {
          "browser.startup.homepage" = "https://search.nixos.org/packages";
          "browser.search.region" = "US";
          "browser.search.isUS" = true;
          "distribution.searchplugins.defaultLocale" = "en-US";
          "general.useragent.locale" = "en-US";
          "toolkit.legacyUserProfileCustomizations.stylesheets" = true; # userChrome
          "layout.css.backdrop-filter.enabled" = true; # blur style
        };

        bookmarks = { };
      };
    };
  };
}
