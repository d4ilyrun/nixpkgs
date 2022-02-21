{ my, ... }:

let
  dir = "${my.config.nixpkgs}/programs/fish";
in
  {
    enable = true;

    shellInit = " \
    source ${dir}/${my.config.colorscheme_name}.fish
    set fish_greeting
    set EDITOR /usr/bin/env nvim
    ";

    shellAliases = {
      # tree and ls;
      ls="exa";
      ll="exa -l --icons";
      la="exa -a --icons";
      lla="exa -al --icons";

      # Colorize grep output (good for log files);
      grep="grep --color=auto";
      egrep="egrep --color=auto";
      fgrep="fgrep --color=auto";

      # confirm before overwriting something;
      cp="cp -iv";
      mv="mv -iv";
      rm="rm -iv";
      mkdir="mkdir -pv";

      # git;
      g="git";
      gs="git status";
      gc="git commit";
      gd="git diff";
      ga="git add";
      gap="git add -p";
      gp="git push";
      gpt="git push --follow-tags";
      gtree = "tree -a -I \".git\"";

      neofetch="neofetch --config ~/.config/nixpkgs/programs/neofetch/config.conf";
      nix-shell="nix-shell --command 'fish'";
    };

    functions = {
      hms = ''home-manager switch --flake ${my.config.nixpkgs}#$argv[1] --impure'';
      nrs = "sudo nixos-rebuild switch --flake ${my.config.nixpkgs}#$argv[1]";
    };
  }
