{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    # CLI
    pre-commit

    # C/C++
    gcc clang-tools
    gnumake cmake
    gdb valgrind
    criterion
    man-pages
    binutils

    # Rust
    rustup
  ];
}
