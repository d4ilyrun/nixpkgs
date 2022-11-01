let
  my = import ../../config;
in
{
  programs.fzf = {
    enable = true;

    defaultCommand = "";
    defaultOptions = with my.config.colorscheme.primary; [
      "--height 40%"
      "--layout=reverse --border"
    ];

    changeDirWidgetOptions = [
      "--preview 'exa -la --icons {} --git-ignore --no-permissions | head -200'"
    ];

    enableFishIntegration = true;
  };
}
