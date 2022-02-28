# inspired by https://github.com/junegunn/fzf/issues/868

function __fzf_ls_files
    git ls-tree -r --name-only HEAD 2>/dev/null; or fd --type f --hidden --follow --exclude .git
end

function __fzf_grep_last
    set -l cmd (commandline)
    # default complete all, and compatible with fzf `**<TAB>`
    if str_endswith "$cmd" ' '; or test $cmd = '**'
        cat
    else
        grep (echo $cmd | awk '{print $NF}')
    end
end

function fzf_complete
    set -l last_word (commandline | awk '{print $NF}')

    begin; complete -C; __fzf_ls_files; end \
        | sort | uniq | __fzf_grep_last \
        | fzf -d \t -1 -0 --ansi --header="$last_word" --height="80%" --tabstop=4 \
        | read -l token

    # Remove description
    set token (string replace -r \t'.*' '' -- $token)
    commandline -rt "$token"
end

function fzf_tab_binding
    bind \ch 'fzf_complete; commandline -f repaint'
end
