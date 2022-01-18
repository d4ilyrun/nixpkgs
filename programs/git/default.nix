{ pkgs, my, ... }:

{
  enable = true;

  aliases = {
    st = "status";
    ci = "commit";
    co = "checkout";
    sw = "switch";
    b = "branch";
    graph = "log --graph --pretty=oneline --all --decorate=full";
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

    core.editor = "${pkgs.neovim}/bin/nvim";

    merge.tool = "vimdiff";
    mergetool.vimdiff.cmd = "${pkgs.neovim}/bin/nvim -d $LOCAL $REMOTE $MERGED";

    pager.status = false;
    pager.commit = false;

    push.default = "simple";
    pull.ff = "only";

    init.defaultBranch = "master";
  };
}
