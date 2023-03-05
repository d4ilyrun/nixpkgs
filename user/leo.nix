{ config, pkgs, ... }:

let
  my = import ../config;
  my_browser = "firefox";
in
{
  dotfiles = {
    username = "leo";
  };

  home = {
    inherit (config.dotfiles) username;

    stateVersion = "22.11";

    homeDirectory = my.config.home;
    sessionVariables = {
      PATH = "${my.config.home}/.nix-profile/bin:${my.config.home}/.npm-packages/bin/:$PATH";
      EDITOR = "nvim";
      BROWSER = my_browser;
    };

    keyboard = {
      layout = "fr,fr";
      variant = ",bepo";
      options = "eurosign:e,grp:win_space_toggle";
    };

    packages = with pkgs; [
      miru
      _1password
      home-manager
      nixpkgs-fmt
    ];
  };

  programs = {
    git = import "${my.config.nixpkgs}/applications/git" { inherit my pkgs; };
  };

  systemd.user.startServices = true;

  fonts = {
    fontconfig.enable = true;
  };

  # Delete old mimeApps to avoid conflict
  home.activation."mimeapps-remove" = {
    before = [ "checkLinkTargets" ];
    after = [ ];
    data = "rm -f /home/balsoft/.config/mimeapps.list";
  };

  xdg = {
    mimeApps =
      let
        file-manager = [ "ranger.desktop" ];
        browser = [ "${my_browser}.desktop" ];
        text-editor = [ "nvim.desktop" ];
        pdf = [ "evince.desktop" ];
        image = [ "feh.desktop" ];
        mail = [ "thunderbird.desktop" ];
      in
      rec {
        enable = true;
        associations.added = defaultApplications;
        defaultApplications = {
          # open in browser
          "text/html" = browser;
          "x-scheme-handler/http" = browser;
          "x-scheme-handler/https" = browser;
          "x-scheme-handler/ftp" = browser;
          "x-scheme-handler/chrome" = browser;
          "x-scheme-handler/about" = browser;
          "x-scheme-handler/unknown" = browser;
          "application/x-extension-htm" = browser;
          "application/x-extension-html" = browser;
          "application/x-extension-shtml" = browser;
          "application/xhtml+xml" = browser;
          "application/x-extension-xhtml" = browser;
          "application/x-extension-xht" = browser;

          "x-scheme-handler/miru" = [ "miru.desktop" ];
          "inode/directory" = file-manager;
          "x-scheme-handler/mailto" = mail;
          "application/pdf" = pdf;
          "application/json" = text-editor;
          "text/plain" = text-editor;
          "text/csv" = text-editor;
          "image/*" = image;
        };
      };
  };
}
