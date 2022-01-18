{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    pre-commit

    # C/C++
    gcc clang-tools
    gnumake cmake
    gdb valgrind
    criterion
    man-pages
  ];
}
