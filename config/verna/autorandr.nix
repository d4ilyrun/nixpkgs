let
  fingerprint = {
    "HDMI-2" = "00ffffffffffff0026cd41612a050000181c010380351e782aee35a656529d280b5054b30c00714f818081c081009500b300d1c00101023a801871382d40582c45000f282100001e000000fd00374c1e5311000a202020202020000000ff0031313634384d38363031333232000000fc00504c32343933480a2020202020018b02031ef14b9002030411121305141f01230907018301000065030c001000023a801871382d40582c45000f282100001e8c0ad08a20e02d10103e96000f2821000018011d007251d01e206e2855000f282100001e8c0ad090204031200c4055000f282100001800000000000000000000000000000000000000000000000000ab";
    "eDP-1" = "00ffffffffffff000daec91400000000081a0104951f11780228659759548e271e505400000001010101010101010101010101010101b43b804a71383440503c680035ad10000018000000fe004e3134304843412d4541420a20000000fe00434d4e0a202020202020202020000000fe004e3134304843412d4541420a20003e";
  };
in
{
  programs.autorandr = {
    enable = true;

    profiles = {
      "double-screen" = {
        inherit fingerprint;
        config = {
          "eDP-1" = {
            enable = true;
            primary = true;
            position = "0x1080";
            mode = "1920x1080";
          };

          "HDMI-2" = {
            enable = true;
            mode = "1920x1080";
            position = "0x0"; # Above eDP-1-1
          };
        };
      };
      "duplicate" = {
        inherit fingerprint;
        config = {
          "eDP-1" = {
            enable = true;
            primary = true;
            position = "0x0";
            mode = "1920x1080";
          };
          "HDMI-2" = {
            enable = true;
            mode = "1920x1080";
            position = "0x0"; # SameAs eDP-1-1
          };
        };
      };
    };
  };
}
