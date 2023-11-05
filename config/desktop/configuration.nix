{ pkgs, ... }:

{
  imports = [
    ../minimal/configuration.nix
    ./hardware-configuration.nix
  ];

  # Set environment variables
  environment.variables = {
    NIXOS_CONFIG_DIR = "$HOME/.config/nixpkgs/configuration/desktop/";
    NIXOS_CONFIG = "$NIXOS_CONFIG_DIR/configuration.nix";
  };

  # Nix settings, auto cleanup and enable flakes
  nix = {
    settings.allowed-users = [ "leo" ];
    gc = {
      automatic = true;
      dates = "weekly";
    };
  };

  networking = {
    hostName = "leo";
    useDHCP = false;
    networkmanager.enable = true;
    interfaces.enp30s0.useDHCP = true;
    interfaces.wlp35s0.useDHCP = true;
  };

  services.xserver = {
    enable = true;

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

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.leo = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "docker" ];
    shell = pkgs.fish;
  };

  programs = {
    fish.enable = true;
  };

  # Download patched fonts from nerd fonts to use glyphs in the terminal
  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "FiraCode" "UbuntuMono" "JetBrainsMono" ]; })
  ];

  # Basic monitor layout
  services.xserver.xrandrHeads = [
    {
      output = "DisplayPort-0";
      primary = true;
      monitorConfig = ''
        Option "PreferredMode" "1920x080_144"
      '';
    }
    {
      output = "HDMI-A-0";
      monitorConfig = ''
        Option "Rotate" "left"
        option "LeftOf" "DisplayPort-0"
      '';
    }
  ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "21.11"; # Did you read the comment?
}

