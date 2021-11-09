# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

let
  unstable = import <nixos-unstable> { config = { allowUnfree = true; }; };
in
{
  imports =
  [ # Include the results of the hardware scan.
    /etc/nixos/hardware-configuration.nix
  ];

  # Set environment variables
  environment.variables = {
    NIXOS_CONFIG="$HOME/.config/nixpkgs/configuration.nix";
    NIXOS_CONFIG_DIR="$HOME/.config/nixpkgs/";
  };

  # Nix settings, auto cleanup and enable flakes
  nix = {
    autoOptimiseStore = true;
    allowedUsers = [ "leo" ];
    gc = {
      automatic = true;
      dates = "daily";
    };
    package = pkgs.nixUnstable;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  # Set up locales (timezone and keyboard layout)
  # Select internationalisation properties.
  time.timeZone = "Europe/Paris";
  i18n.defaultLocale = "fr_FR.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "fr";
  };

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking = {
    hostName = "leo";
    networkmanager.enable = true;
    # The global useDHCP flag is deprecated, therefore explicitly set to false here.
    # Per-interface useDHCP will be mandatory in the future, so this generated config
    # replicates the default behaviour.
    useDHCP = false;
    interfaces.enp6s0f1.useDHCP = true;
    interfaces.wlp0s20f3.useDHCP = true;
  };

  services.xserver = {
    enable = true;

    displayManager = { 
      lightdm.enable = true;
      defaultSession = "none+i3";
    };  

    desktopManager = {
      xterm.enable = false;
    };

    windowManager.i3 = {
      enable = true;
      package = pkgs.i3-gaps;
    };

    desktopManager = {
      xterm.enable = false;
    };

    layout = "fr";
    xkbOptions = "eurosign:e";

    # Enable touchpad support (enabled default in most desktopManager).
    libinput.enable = true;

  };

  # NVIDIA STUFF

  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia.prime = {
    offload.enable = true;
    # Bus ID of the Intel GPU. You can find it using lspci, either under 3D or VGA
    intelBusId = "PCI:0:2:0";
    # Bus ID of the NVIDIA GPU. You can find it using lspci, either under 3D or VGA
    nvidiaBusId = "PCI:1:0:0";
  };

  specialisation = {
    external-display.configuration = {
      system.nixos.tags = [ "external-display" ];
      hardware.nvidia.prime.offload.enable = lib.mkForce false;
      hardware.nvidia.powerManagement.enable = lib.mkForce false;
    };
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  users.users.leo = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
    shell = pkgs.fish;
  };

  environment.systemPackages = with pkgs; [
    refind
    git
    vim 
    alacritty
    fish
    curl
    nvidia-offload
  ];
  
  fonts = { 
    fontconfig.enable = true;
    fonts = with pkgs; [
      (nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" ]; })
      pkgs.roboto-mono
      pkgs.iosevka
      pkgs.material-design-icons
      pkgs.weather-icons
    ];
  };

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "21.05"; # Did you read the comment?

}

