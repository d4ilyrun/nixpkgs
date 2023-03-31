# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:

{
  nixpkgs.config.allowUnfree = true;

  imports =
    [
      # Include the results of the hardware scan.
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
      auto-optimise-store = true;
      allowed-users = [ "leo" ];
    };
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
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    useXkbConfig = true;
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

    windowManager = {
      i3 = {
        enable = true;
        package = pkgs.i3-gaps;
      };
    };

    displayManager = {
      defaultSession = "none+i3";
      startx.enable = true;
      lightdm = {
        enable = true;
      };
      autoLogin = {
        enable = false;
        user = "leo";
      };
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

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;
  hardware.bluetooth.enable = true;

  users.users.leo = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "docker" ];
    shell = pkgs.fish;
  };

  environment.systemPackages = with pkgs; [
    refind
    git
    vim
    curl
    fish
    docker
  ];

  # Download patched fonts from nerd fonts to use glyphs in the terminal
  fonts.fonts = with pkgs; [
    (nerdfonts.override { fonts = [ "FiraCode" "UbuntuMono" "JetBrainsMono" ]; })
  ];

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  services.logind.extraConfig = ''
    # don’t shutdown when power button is short-pressed
    HandlePowerKey=ignore
  '';

  virtualisation.docker.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "21.11"; # Did you read the comment?
}

