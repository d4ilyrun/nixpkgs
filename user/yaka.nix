{ config, lib, pkgs, ... }:

{
  imports = lib.importConfig {
    pkgs = [ "yaka" ];
  };

  home = {
    sessionVariables = {
      YAKA = "${config.dotfiles.homeDirectory}/School/YAKA";
    };
  };

  programs = {
    ssh = {
      enable = true;
      matchBlocks = {
        # ASSISTANTS / SCHOOL
        "*.epita.fr" = {
          identityFile = "${config.dotfiles.homeDirectory}/.ssh/epita";
        };
      };
    };
    git = {
      aliases = { };
    };
    fish = {
      functions = {
        dexec = ''
          set IMAGE (docker load -i "$argv[1]")
          set REGISTRY (echo "$IMAGE" | cut -d ' ' -f 3)
          echo "Running '$argv[2]' inside $REGISTRY"
          docker run --rm -it "$REGISTRY" $argv[2]
        '';
        go = ''
          if test (count $argv) -ge 1
            cd (find $YAKA -maxdepth 3 -type d | fzf -q $argv[1] -0 -1)
          else
            cd (find $YAKA -maxdepth 3 -type d | fzf -0 -1)
          end
        '';
      };
    };

    firefox.profiles."${config.dotfiles.username}" = {
      bookmarks = [
        {
          name = "Clockishift";
          url = "https://app.clockify.me/tracker";
        }
        {
          name = "GitLab";
          url = "https://gitlab.cri.epita.fr/";
        }
        {
          name = "Tickets";
          url = "https://tickets.cri.epita.fr/";
        }
        {
          name = "Operator";
          url = "https://operator.forge.epita.fr/ui/";
        }
      ];
    };
  };
}
