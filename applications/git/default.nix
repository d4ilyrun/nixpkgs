{ pkgs, ... }:

{
  programs.git = {
    enable = true;

    aliases = {
      ui = "!lazygit";

      # push
      p = "push";
      pf = "push --force-with-lease";
      pt = "push --follow-tags";
      psu = "push --set-upstream";

      # commit
      c = "commit";
      ca = "commit --amend";
      ce = "commit --allow-empty";
      cf = "commit --fixup";

      # rebase
      rb = "rebase";
      rbi = "rebase -i";
      rba = "rebase --abort";
      rbc = "rebase --continue";
      mt = "mergetool";

      # log
      lo = "log --oneline";
      lg = "log --pretty=format:\"%C(yellow)%h%C(reset) %C(black)•%C(reset) %<(50)%s %C(green)(%cr) [%an] %C(auto)%d%C(reset)\" --abbrev-commit -30";
      graph = "log --graph --pretty=oneline --all --decorate=full";
      st = "status -s  --ignore-submodules=untracked";
      dc = "diff --cached";
      info = "log -n 1"; # Show last commit info
      history = "!git log --oneline | fzf | cut -d ' ' -f '1'"; # Find hash of an older commit using fuzzy finding

      # branches
      co = "checkout";
      cob = "checkout -b";
      del = "branch -D";
      br = "branch --format='%(HEAD) %(align:15,left)%(color:yellow)%(refname:short)%(color:reset)%(end) %(color:black)•%(color:reset) %(align:50,left)%(contents:subject)%(end) %(color:green)(%(committerdate:relative)) [%(authorname)]%(color:reset)' --sort=-committerdate";
      bra = "br -a";

      # reset
      res = "reset --hard";
      undo = "reset HEAD~1";
      nuke = "!git reset --hard && git clean -df";

      # submodules
      sb = "submodule";
      sbu = "submodule update --init";

      # files
      ls = "!git ls-tree -r --name-only HEAD";
      search = "!git ls | fzf";
      edit = "!$EDITOR $(git search)";
      tree = "!git ls | tree --fromfile .";
    };

    delta.enable = true;

    extraConfig = {
      color.ui = true;

      core.editor = "nvim";

      merge.tool = "nvimdiff";
      mergetool.nvimdiff.cmd = "nvim -c 'DiffviewOpen'";

      pager = {
        status = false;
        commit = false;
      };

      push.default = "simple";
      pull = { ff = "only"; rebase = true; };
      merge = { ff = false; }; # semi-linear

      init.defaultBranch = "master";

      rebase.autosquash = true;
    };
  };

  programs.fish.functions = {
    gcf = "git commit $argv --fixup (git history | cut -d ' ' - -f 1)";
    groot = "cd (git rev-parse --show-toplevel)";
  };
}
