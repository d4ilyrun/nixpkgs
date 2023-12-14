# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:

{
  imports =
    [
      # Include the results of the hardware scan.
      ../minimal/configuration.nix
      ./hardware-configuration.nix
    ];

  # Set environment variables
  environment.variables = {
    NIXOS_CONFIG = "$HOME/.config/nixpkgs/config/verna/configuration.nix";
    NIXOS_CONFIG_DIR = "$HOME/.config/nixpkgs/verna/laptop";
  };

  # Nix settings, auto cleanup and enable flakes
  nix = {
    settings = {
      allowed-users = [ "leo" ];
    };
  };

  networking = {
    hostName = "verna";
    networkmanager.enable = true;
    useDHCP = false;
    interfaces.enp0s31f6.useDHCP = true;
    interfaces.wlp4s0.useDHCP = true;
  };

  services.xserver = {
    enable = true;

    windowManager = {
      i3 = {
        enable = true;
        package = pkgs.i3-gaps;
      };
    };

    displayManager = {
      defaultSession = "none+i3";
      lightdm.enable = true;
    };

    desktopManager = {
      xterm.enable = false;
    };

    layout = "fr";
    xkbOptions = "eurosign:e";

    # Enable touchpad support (enabled default in most desktopManager).
    libinput.enable = true;
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  users.users.leo = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "docker" "libvirtd" ];
    shell = pkgs.fish;
  };

  programs = {
    fish.enable = true;
  };

  environment.systemPackages = with pkgs; [ virt-manager ];

  virtualisation.libvirtd.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "21.11"; # Did you read the comment?
}

