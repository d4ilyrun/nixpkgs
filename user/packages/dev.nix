{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    # C/C++
    gcc clang-tools
    gnumake cmake
    gdb valgrind
    meson ninja
    criterion
    man-pages
  ];
}
