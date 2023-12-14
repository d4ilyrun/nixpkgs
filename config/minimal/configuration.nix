{ pkgs, ... }:

rec {

  imports = [
    ./hardware-configuration.nix
  ];

  environment.variables = {
    NIX_PATH = builtins.concatStringsSep ":" nix.nixPath;
  };

  nix = {
    nixPath = [
      "nixos=${pkgs.config.outPath}"
      "nixpkgs=${pkgs.config.outPath}"
      "/nix/var/nix/profiles/per-user/root/channels"
    ];
    package = pkgs.nixUnstable;
    settings = {
      auto-optimise-store = true;
      experimental-features = [ "nix-command" "flakes" "repl-flake" ];
    };
  };

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  programs.command-not-found.dbPath = "${pkgs.config.outPath}/programs.sqlite";

  environment.systemPackages = with pkgs; [
    git
    refind
    vim
    curl
    docker
  ];

  # Set your time zone.
  time.timeZone = "Europe/Paris";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    useXkbConfig = true;
  };

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;
  hardware.bluetooth.enable = true;

  services = {
    openssh.enable = true;
    printing.enable = true;
    logind.extraConfig = ''
      # don’t shutdown when power button is short-pressed
      HandlePowerKey=ignore
    '';
  };

  virtualisation.docker.enable = true;
}
