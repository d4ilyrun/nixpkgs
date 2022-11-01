{ pkgs, my, ... }:

{
  enable = true;

  aliases = {
    ui = "!lazygit";

    # push
    p = "push";
    pf = "push -f";
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
    info = "log -n 1"; # Show last commit info

    # branches
    co = "checkout";
    cob = "checkout -b";
    del = "branch -D";
    br = "branch --format='%(HEAD) %(align:15,left)%(color:yellow)%(refname:short)%(color:reset)%(end) %(color:black)•%(color:reset) %(align:50,left)%(contents:subject)%(end) %(color:green)(%(committerdate:relative)) [%(authorname)]%(color:reset)' --sort=-committerdate";

    # reset
    res = "reset --hard";
    undo = "reset HEAD~1";
    nuke = "!git reset --hard && git clean -df";

    # submodules
    sb = "submodule";
    sbu = "submodule update --init";
  };

  includes = [
    {
      condition = "gitdir:~/School/";
      contents.user = {
        name = "Léo DUBOIN";
        address = "leo.duboin@epita.fr";
        email = "leo.duboin@epita.fr";
      };
    }
  ];

  userEmail = "leo@duboin.com";
  userName = "Léo DUBOIN";

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

    init.defaultBranch = "master";

    rebase.autosquash = true;
  };
}
