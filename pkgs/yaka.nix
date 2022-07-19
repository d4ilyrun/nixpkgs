{ config, pkgs, ... }:

let
  user = "leo.duboin";
in
{
  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    slack
    #clockify
    thunderbird
  ];

  programs.ssh = {
    enable = true;

    matchBlocks = {
      # ASSISTANTS / SCHOOL
      "*.epita.fr" = {
        inherit user;
        identityFile = "~/.ssh/epita";
      };
    };

    extraConfig = ''
      AddKeysToAgent yes
      IdentityFile ~/.ssh/default
      IdentitiesOnly yes
      '';
  };
}


