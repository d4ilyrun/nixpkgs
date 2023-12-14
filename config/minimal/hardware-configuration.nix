{ ... }:

{
  fileSystems = {
    # Mount my own empty tmpfs
    "/rtmp" = { fsType = "tmpfs"; };
  };
}
