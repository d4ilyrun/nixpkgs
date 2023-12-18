{ pkgs, ... }:

{
  imports = [
    ../minimal/configuration.nix
    ./hardware-configuration.nix
  ];

  # Set environment variables
  environment.variables = {
    NIXOS_CONFIG = "$HOME/.config/nixpkgs/config/laptop/configuration.nix";
    NIXOS_CONFIG_DIR = "$HOME/.config/nixpkgs/config/laptop";
  };

  # Nix settings, auto cleanup and enable flakes
  nix = {
    settings = {
      allowed-users = [ "leo" ];
    };
    gc = {
      automatic = true;
      dates = "weekly";
    };
  };

  networking = {
    hostName = "leo";
    networkmanager.enable = true;
    useDHCP = false;
    interfaces.enp1s0f0.useDHCP = true;
  };

  services.xserver = {
    enable = true;
    dpi = 150;

    displayManager = {
      lightdm.enable = true;
      defaultSession = "none+i3";
    };

    windowManager.i3 = {
      enable = true;
      package = pkgs.i3-gaps;
    };

    layout = "fr";
    xkbOptions = "eurosign:e";

    # Enable touchpad support (enabled default in most desktopManager).
    libinput.enable = true;
  };

  users.users.leo = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "docker" ];
    shell = pkgs.fish;
  };

  programs = {
    fish.enable = true;
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?
}

