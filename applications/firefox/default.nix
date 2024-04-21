{ config, pkgs, lib, ... }:

{
  programs.firefox = {

    enable = true;

    profiles = {
      "${config.dotfiles.username}" = {
        name = config.dotfiles.username;
        isDefault = true;

        settings = {
          "browser.search.region" = "US";
          "browser.search.isUS" = true;
          "distribution.searchplugins.defaultLocale" = "en-US";
          "general.useragent.locale" = "en-US";
          "toolkit.legacyUserProfileCustomizations.stylesheets" = true; # userChrome
          "layout.css.backdrop-filter.enabled" = true; # blur style
        };

        bookmarks = [
          {
            name = "Nix";
            toolbar = true;
            bookmarks = [
              { name = "Search: NixOs"; url = "search.nixos.org"; }
              { name = "Search: Home-Manager"; url = "https://mipmip.github.io/home-manager-option-search/"; }
              { name = "Manual"; url = "https://ryantm.github.io/nixpkgs/functions/library/attrsets"; }
            ];
          }
        ];

        userChrome = ''
          /* Custom theme defined inside the 'themes' nix dconfiguration */
          @import 'theme/userChrome.css';
        '';


        extensions = with pkgs.nur.repos.rycee.firefox-addons; [
          darkreader
          refined-github
          return-youtube-dislikes
          ublock-origin
          consent-o-matic
          bitwarden
        ];
      };
    };
  };

  xsession.windowManager.i3 = {
    config.window.commands = [
      { command = "floating disable border none"; criteria = { class = "Firefox"; }; }
    ];
  };
}
