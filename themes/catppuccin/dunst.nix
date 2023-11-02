{ config, ... }:

{
  services.dunst.settings = rec {

    global.frame_color = config.dotfiles.theme.colors.primary.accent;

    urgency_low = {
      background = "#1E1E2E";
      foreground = "#CDD6F4";
    };

    urgency_normal = urgency_low;

    urgency_critical = urgency_low // {
      frame_color = "#FAB387";
    };
  };
}
