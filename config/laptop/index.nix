#~/.config/nixpkgs/config/desktop/index.nix
{ config, lib, pkgs, ... }:

let
  programs = ../../programs;

  nvidia-offload = pkgs.writeShellScriptBin "nvidia-offload" ''
    export __NV_PRIME_RENDER_OFFLOAD=1
    export __NV_PRIME_RENDER_OFFLOAD_PROVIDER=NVIDIA-G0
    export __GLX_VENDOR_LIBRARY_NAME=nvidia
    export __VK_LAYER_NV_optimus=NVIDIA_only
    exec -a "$0" "$@"
  '';
in
{
  xsession.windowManager.i3 = import "${programs}/i3/i3_gaps.nix" { inherit pkgs lib; };

  programs = {
    neovim  = import "${programs}/neovim/default.nix" { inherit pkgs; };
    alacritty  = import "${programs}/alacritty/default-settings.nix" { inherit pkgs; };
    fish = import "${programs}/fish/default.nix";
  };

  # NVIDIA STUFF

  environment.systemPackages = [ nvidia-offload ];
  
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia.prime = {
    offload.enable = true;

    # Bus ID of the Intel GPU. You can find it using lspci, either under 3D or VGA
    intelBusId = "PCI:0:2:0";

    # Bus ID of the NVIDIA GPU. You can find it using lspci, either under 3D or VGA
    nvidiaBusId = "PCI:1:0:0";
  };

}
