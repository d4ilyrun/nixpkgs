let
  fingerprint = {
    "HDMI-0" = "00ffffffffffff0010ac7fa0535948310c16010380301b78ea3d25a35951a0250f5054a54b00714f8180d1c001010101010101010101023a801871382d40582c4500132b2100001e000000ff00563056434d32334c314859530a000000fc0044454c4c205032323132480a20000000fd00384c1e5311000a2020202020200032";
    "eDP-1-1" = "00ffffffffffff0006afed6100000000001a010495221378025925935859932926505400000001010101010101010101010101010101783780b470382e406c30aa0058c1100000180000000f0000000000000000000000000020000000fe0041554f0a202020202020202020000000fe004231353648414e30362e31200a00ea";
  };
in
{
  programs.autorandr = {
    enable = true;

    profiles = {
      "double-screen" = {
        inherit fingerprint;
        config = {
          "eDP-1-1" = {
            enable = true;
            primary = true;
            position = "0x1080";
            mode = "1920x1080";
          };

          "HDMI-0" = {
            enable = true;
            mode = "1920x1080";
            position = "0x0"; # Above eDP-1-1
          };
        };
      };
      "duplicate" = {
        inherit fingerprint;
        config = {
          "eDP-1-1" = {
            enable = true;
            primary = true;
            position = "0x0";
            mode = "1920x1080";
          };
          "HDMI-0" = {
            enable = true;
            mode = "1920x1080";
            position = "0x0"; # SameAs eDP-1-1
          };
        };
      };
    };
  };
}
