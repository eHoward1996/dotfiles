if [[ ! -d "${HOME}/Pictures/.temp" ]]; then
    mkdir $HOME/Pictures/.temp

    for f in $HOME/Pictures/Wallpapers/*; do
        fname=${f##*/}
        fname=$(echo ${fname} | cut -d '.' -f 1)
        str=$"${HOME}/Pictures/.temp/${fname}.png"
        echo 'created' $str 'from' $f
        convert $f $str
    done;
fi;
newTheme=$(python /home/oonebaddog/Programs/dotfiles/.config/i3/imagePreview.py)
newTheme=${newTheme##*/}
newTheme=$(echo ${newTheme} | cut -d '.' -f 1)

if [[ -n $newTheme ]]; then
    newTheme="$HOME/Pictures/Wallpapers/${newTheme}.jpg"
    echo $newTheme
    $(sh ~/.config/i3/setColorScheme.sh ${newTheme})
fi;