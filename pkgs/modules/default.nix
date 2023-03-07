{ spicetify-nix, ... }:

{
  imports = [
    ./config.nix
    ./battery.nix
  ];
}
