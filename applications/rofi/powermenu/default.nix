{ my, pkgs }:

let
  dir = "${my.config.nixpkgs}/applications/rofi/powermenu";
  menu_theme = "card_rounded";
  lock_command = "${pkgs.betterlockscreen}/bin/betterlockscreen -l dimblur";
in
pkgs.writeShellScript "powermenu.sh"
  ''
    export __ROFI_POWERMENU_THEME="${menu_theme}"
    export __ROFI_POWERMENU_DIR="${dir}"

    export user_lock_command="${lock_command}"

    export shutdown=""
    export reboot=""
    export lock=""
    export suspend=""
    export logout=""

    bash ${dir}/powermenu.sh
  ''
