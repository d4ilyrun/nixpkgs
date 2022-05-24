{ config, pkgs, ... }:

let
  python-with-my-packages = pkgs.python3.withPackages (p: with p; [
      dbus-python
  ]);
in
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
    rust-analyzer

    # Python + packages
    python-with-my-packages
  ];
}
