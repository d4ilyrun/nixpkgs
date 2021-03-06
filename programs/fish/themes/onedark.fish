# TokyoNight Color Palette
set -l foreground a2bb2bf
set -l red be5046
set -l orange d19a66
set -l yellow e5c07b
set -l green 98c379
set -l purple c678dd
set -l cyan 56b6c2
set -l pink $magenta

set -l selection 364A82
set -l comment 5c6370

# Syntax Highlighting Colors
set -g fish_color_normal $foreground
set -g fish_color_command $cyan
set -g fish_color_keyword $pink
set -g fish_color_quote $yellow
set -g fish_color_redirection $cyan
set -g fish_color_end $orange
set -g fish_color_error $red
set -g fish_color_param $yellow
set -g fish_color_comment $comment
set -g fish_color_selection --background=$selection
set -g fish_color_search_match --background=$selection
set -g fish_color_operator $green
set -g fish_color_escape $pink
set -g fish_color_autosuggestion $comment

# Completion Pager Colors
set -g fish_pager_color_progress $comment
set -g fish_pager_color_prefix $cyan
set -g fish_pager_color_completion $foreground
set -g fish_pager_color_description $comment



