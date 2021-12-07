{ pkgs, ... }:

let
  my = import ~/.config/nixpkgs/config;
  dir = "${my.config.nixpkgs}/programs/polybar";
in
  {
    enable = true;
    script = ''
    #!/usr/bin/env bash
    killall -q polybar

    while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

    echo "---" | tee -a /tmp/polybar.log

    for m in $(polybar --list-monitors | cut -d":" -f1); do
    MONITOR=$m polybar example -c ${dir}/gloom-onedark.ini >>/tmp/polybarl.log 2>&1 &
    done

    echo "Bar launched..."

    '';
  }

