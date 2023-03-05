{ config, ... }:

{
  programs.fzf = {
    enable = true;

    defaultCommand = "";
    defaultOptions = [
      "--height 40%"
      "--layout=reverse --border"
    ];

    changeDirWidgetOptions = [
      "--preview 'exa -la --icons {} --git-ignore --no-permissions | head -200'"
    ];
  };
}
