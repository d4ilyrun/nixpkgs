{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    # C/C++
    gcc clang-tools
    gnumake cmake
    gdb valgrind
    criterion
    man-pages
  ];
}
