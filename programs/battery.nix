# TODO: see https://github.com/rycee/home-manager/issues/250 for instructions

{ config, lib, pkgs, ...}:

with lib;

let
  cfg = config.services.batteryNotifier;
  script = pkgs.writeShellApplication {
    name = "lowbatt-start";
    text = ''
      #!/bin/sh

      battery_capacity=$(cat /sys/class/power_supply/${cfg.device}/capacity)
      battery_status=$(cat /sys/class/power_supply/${cfg.device}/status)

      if [[ $battery_capacity -le ${builtins.toString cfg.notifyCapacity} && $battery_status = "Discharging" ]]; then
          notify-send --urgency=critical --hint=int:transient:1 --icon=battery_empty "Battery Low" "You should probably plug-in."
      fi

    '';
  };
in {
  options = {
    services.batteryNotifier = {
      enable = mkOption {
        default = false;
        description = ''
          Whether to enable battery notifier.
        '';
      };
      device = mkOption {
        default = "BAT0";
        description = ''
          Device to monitor.
        '';
      };
      notifyCapacity = mkOption {
        default = 10;
        description = ''
          Battery level at which a notification shall be sent.
        '';
      };
      hibernate = mkOption {
        default = false;
        description = ''
          Whether to hibernate when the battery is critically low.
        '';
      };
      hibernateCapacity = mkOption {
        default = 5;
        description = ''
          Battery level at which a hibernate unless connected shall be sent.
        '';
      };
    };
  };

  config = mkIf cfg.enable {
    systemd.user.timers."lowbatt" = {
      Unit = {
        Description = "check battery level";
      };

      Timer = {
        OnBootSec = "1min";
        OnUnitInactiveSec = "1min";
        Unit = "lowbatt.service";
      };

      Install = {
        WantedBy = [ "timers.target" ];
      };
    };

    systemd.user.services."lowbatt" = {
      Unit = {
        Description = "battery level notifier";
      };

      Service = {
        PassEnvironment = "DISPLAY";
        ExecStart = "${script}/bin/lowbatt-start";
      };
    };
  };
}
