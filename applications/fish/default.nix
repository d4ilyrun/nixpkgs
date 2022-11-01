{ pkgs, lib, ... }:

let
  my = import ../../config/.;
  dir = "${my.config.nixpkgs}/applications/fish";
in

{
  imports = [
    ./bat.nix
    ./fzf.nix
  ];

  home.packages = with pkgs; [
    starship
    exa
    bat
    neofetch
  ];

  programs.starship = import "${dir}/../starship" { inherit my pkgs lib; };

  programs.fish = {
    enable = true;

    # FIXME: Deprecated buildFishPlugin, so install those packages through fisher for the time being
    plugins = with pkgs.fishPlugins; [
      #done
      #forgit
    ];

    shellInit = " \
      source ${dir}/themes/${my.config.colorscheme_name}.fish
      source ${dir}/functions.fish
      set fish_greeting
      set fzf_preview_dir_cmd exa -al --color=always --icons

      if [ ${my.config.colorscheme_name} = \"onedark\" ];
        set_onedark
      end
      ";

    shellAliases = {
      # progam overrides;
      ls = "exa";
      ll = "exa -l --icons";
      la = "exa -a --icons";
      lla = "exa -al --icons";
      tree = "exa --tree --icons";
      cat = "bat --theme ansi";

      # Colorize grep output (good for log files);
      grep = "grep --color=auto";
      egrep = "egrep --color=auto";
      fgrep = "fgrep --color=auto";

      # confirm before overwriting something;
      cp = "cp -iv";
      mv = "mv -iv";
      rm = "rm -iv";
      mkdir = "mkdir -pv";

      # git;
      g = "git";
      gs = "git status";
      gc = "git commit";
      gd = "git diff";
      ga = "git add";
      gap = "git add -p";
      gp = "git push";
      gpt = "git push --follow-tags";
      gtree = "tree -a -I \".git\"";

      neofetch = "neofetch --config ~/.config/nixpkgs/applications/neofetch/config.conf";
      nix-shell = "nix-shell --command 'fish'";
      dotfiles = "cd ${my.config.nixpkgs}";
    };

    functions = {
      hms = ''home-manager switch --impure --cores 12 --flake ${my.config.nixpkgs}#$argv'';
      nrs = "sudo nixos-rebuild switch --impure -j 12 --flake ${my.config.nixpkgs}#$argv";
    };
  };
}
