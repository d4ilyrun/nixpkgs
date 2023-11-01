{ ... }:

{
  services.dunst.settings = rec {

    global.frame_color = "#89B4FA";

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
