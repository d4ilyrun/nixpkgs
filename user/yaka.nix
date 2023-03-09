{ config, lib, pkgs, ...}:

{
  imports = lib.importConfig {
    pkgs = [ "yaka" ];
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
  };
}
