{ pkgs, config, ... }:

{
  xdg.configFile."tmux/plugins/tpm" = {
    source = pkgs.fetchgit {
      url = "https://github.com/tmux-plugins/tpm";
      sha256 = "sha256-1agBX7r4tEdG3fRvsuXHj+YfhsIj0eLLA1Wl8fP+UbQ=";
      rev = "99469c4";
    };
  };

  programs.tmux = {
    enable = true;

    prefix = "C-x";
    keyMode = "vi";

    terminal = "tmux-256color";
    shell = "${pkgs.fish}/bin/fish";

    clock24 = true;
    baseIndex = 1;
    sensibleOnTop = true;

    extraConfig = ''
      source-file ${config.dotfiles.folders.applications}/tmux/tmux.conf
    '';
  };
}
