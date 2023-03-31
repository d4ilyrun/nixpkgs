if [[ $# -eq 0 ]]; then
    OPT="default"
else
    OPT=$1
fi

case $OPT in
    "area") scrot -s -e 'xclip -selection clipboard -t image/png -i $f';;
    "window") scrot -ub -e 'xclip -selection clipboard -t image/png -i $f';;
    "save") scrot -e 'mv $f ~/Images/Screenshots/';;
    "*") scrot -e 'xclip -selection clipboard -t image/png -i $f';;
esac
