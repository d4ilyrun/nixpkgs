{ config, pkgs, lib, ... }:

rec {
  news.display = "silent";

  imports = lib.importConfig {
    pkgs = [ "dev" ];
    applications = [ "git" ];
    imports = [ ./yaka.nix ];
  };

  dotfiles = {
    username = "leo";
    extraOptions = {
      browser = "${pkgs.firefox}/bin/firefox";
      terminal = "${pkgs.kitty}/bin/kitty";
      editor = "${pkgs.neovim}/bin/nvim";
    };
  };

  home = {
    stateVersion = "22.11";

    sessionVariables = with dotfiles.extraOptions; {
      PATH = "${config.dotfiles.homeDirectory}/.nix-profile/bin:${config.dotfiles.homeDirectory}/.npm-packages/bin/:$PATH";
      EDITOR = editor;
      BROWSER = browser;
    };

    keyboard = {
      layout = "fr,fr";
      variant = ",bepo";
      options = "eurosign:e,grp:win_space_toggle";
    };

    packages = with pkgs; [
      miru
      bitwarden
      home-manager
      nixpkgs-fmt
    ];
  };

  programs = {
    git = {
      userEmail = "leo@duboin.com";
      userName = "Léo DUBOIN";
      includes = [
        {
          condition = "gitdir:~/School/";
          contents.user = {
            name = "Léo DUBOIN";
            address = "leo.duboin@epita.fr";
            email = "leo.duboin@epita.fr";
          };
        }
      ];
    };
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
        browser = [ "firefox.desktop" ];
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

  programs.ssh = {
    extraConfig = ''
      AddKeysToAgent yes
      IdentityFile ~/.ssh/default
      IdentitiesOnly yes
    '';
  };
}
