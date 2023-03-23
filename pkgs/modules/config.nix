# This module is here to hold settings that are reused everywhere throughout the configuration

{ config, pkgs, lib, ... }:

with lib;

let
  cfg = config.dotfiles;
in
{
  imports = [ ./themes.nix ];

  options.dotfiles = {
    username = mkOption {
      type = types.str;
      description = "The user's name";
    };

    machine = mkOption {
      type = types.str;
      description = "The type of machine used";
      example = "laptop";
      default = "minimal";
    };

    homeDirectory = mkOption {
      type = types.str;
      description = "The user home directory;";
      default = "/home/${cfg.username}";
    };

    repository = mkOption {
      type = types.str;
      description = "The path to the config repository";
      default = "${../..}";
    };

    # Subfolders

    folders =
      let
        makeFolderPath = name: path: {
          "${name}" = mkOption {
            type = types.str;
            description = "The path to the config '${path}' folder.";
            default = "${cfg.repository}/${path}";
          };
        };
        makeFolder = name: makeFolderPath name name;
      in
      makeFolderPath "packages" "pkgs" # TODO: Go into "pkgs/packages"
      // makeFolder "config"
      // makeFolder "themes"
      // makeFolder "services"
      // makeFolder "applications";

    # Options

    extraOptions = mkOption {
      type = types.attrs;
      description = "Additional theme specfific parameters.";
      example = {
        i3.gaps = {
          inner = 6;
          outer = 5;
        };
      };
    };
  };

  config = {
    home = {
      inherit (cfg) username homeDirectory;
    };
  };
}
