# Configuration related to NVIDIA drivers.
# My laptop ships with a 1050 Mobile GPU (PRIME)

# BEWARE, these settings depends on your GPU
# and may cause some problems if your laptop doesn't include an Nvidia GPU.

{ pkgs, config, ... }:

let
  nvidia-offload = pkgs.writeShellScriptBin "nvidia-offload" ''
    export __NV_PRIME_RENDER_OFFLOAD=1
    export __NV_PRIME_RENDER_OFFLOAD_PROVIDER=NVIDIA-G0
    export __GLX_VENDOR_LIBRARY_NAME=nvidia
    export __VK_LAYER_NV_optimus=NVIDIA_only
    exec -a "$0" "$@"
  '';
in
{
  services.xserver.videoDrivers = [ "nvidia" ];

  environment.systemPackages = [ nvidia-offload ];

  hardware = {
    nvidia = {
      modesetting.enable = true;
      prime = {
        offload.enable = true;
        intelBusId = "PCI:0:2:0";
        nvidiaBusId = "PCI:1:0:0";
      };
    };

    opengl = {
      enable = true;
    };
  };
}
