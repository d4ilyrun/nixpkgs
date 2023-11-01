{ config, pkgs, lib, ... }:

let

  dir = ./.;
  dotfiles = config.dotfiles;
  theme = dotfiles.theme;
  theme_file = "${theme.directory}/${theme.name}.fish";

in

{
  imports = [
    ./bat.nix
    ./fzf.nix
    ../starship
  ];

  home.packages = with pkgs; [
    starship
    eza
    bat
    neofetch
  ];

  programs.fish = {
    enable = true;

    # FIXME: Deprecated buildFishPlugin, so install those packages through fisher for the time being
    plugins = with pkgs.fishPlugins; [
      #done
      #forgit
    ];

    shellInit = ''
      source ${dir}/functions.fish
      set fish_greeting
      set fzf_preview_dir_cmd exa -al --color=always --icons

      if [ ${theme.name} = \"onedark\" ];
        set_onedark
      end

      if [ -f ${theme_file} ]
        source ${theme_file}
      else
        echo "ERROR: NO THEME FILE AVAILABLE" &>2
      end
    '';

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
      dotfiles = "cd ${dotfiles.repository}";
    };

    functions = {
      hms = ''home-manager switch --impure --cores 12 --flake ${dotfiles.repository}#$argv'';
      nrs = "sudo nixos-rebuild switch --impure -j 12 --flake ${dotfiles.repository}#$argv";
    };
  };
}
