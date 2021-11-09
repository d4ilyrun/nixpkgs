# tree and ls
alias ll="ls -l"
alias la="ls -a"
alias lla="ls -al"

# navigation
#.. = ' c d ..';
#... = ' c d ../..';
#. 3 = 'cd ../../..';
#. 4 = 'cd ../../../..';
#. 5 = 'cd ../../../../..';

# Colorize grep output (good for log files)
alias grep="grep --color=auto"
alias egrep="egrep --color=auto"
alias fgrep="fgrep --color=auto"

# confirm before overwriting something
alias cp="cp -iv"
alias mv="mv -iv"
alias rm="rm -iv"
alias mkdir="mkdir -pv"

# git
alias g="git"
alias gs="git status"
alias gc="git commit"
alias gd="git diff"
alias ga="git add"
alias gap="git add -p"
alias gp="git push"
alias gpt="git push --follow-tags"
alias gtree='tree -a -I ".git"'

# Nixos
alias hms="home-manager switch"
alias nrs="sudo nixos-rebuild switch"
