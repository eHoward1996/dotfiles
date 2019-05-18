img="${HOME}/Pictures/Wallpapers/"
walSelectedImg="`cat ${HOME}/.cache/wal/wal`"
walColorFile="${HOME}/.cache/wal/colors"
pyProcessColorFile="${HOME}/.config/i3/configColors.py"
colorsFile="${HOME}/.config/i3/colors"
colors=()

if [[ -z "$1" ]]; then
	wal -i "$img"
else
	wal -i "$1"
fi;
while read -r line || [[ -n "$line" ]]; do
	colors+=("$line")
done < "$walColorFile"

colors=( $(python "$pyProcessColorFile" ${colors[*]}) )
colorStr=""

if [ ! -f $colorsFile ]; then
	touch $colorsFile
fi
echo "" > $colorsFile

for c in "${!colors[@]}"; do
	echo -e "${colors[$c]}" >> $colorsFile  
	entry="*color${c}:\t${colors[$c]}\n"
	entry="${entry}*.color${c}:\t${colors[$c]}\n"
	if [[ $colorStr != "" ]]; then
		colorStr="${colorStr}\n${entry}"
	else
		colorStr="${entry}"
	fi
done
colorStr="${colorStr}\n*color${#colors[@]}:\t#333333\n"
colorStr="${colorStr}*.color${#colors[@]}:\t#333333"

if [ ! -f "${HOME}/.Xresources" ]; then
	touch "${HOME}/.Xresources"
fi
echo -e "$colorStr" > ~/.Xresources

termStr="[options]"
termStr="${termStr}\nallow_bold = true"
termStr="${termStr}\nclickable_url = true"
termStr="${termStr}\ndynamic_title = true"
termStr="${termStr}\nfont = Source Code Pro 11"
termStr="${termStr}\nicon_name = IuSeArCh"
termStr="${termStr}\nmouse_autohide = true"
termStr="${termStr}\nscroll_on_output = true"
termStr="${termStr}\nscrollback_lines = 10000"
termStr="${termStr}\nsearch_wrap = true"
termStr="${termStr}\nhyperlinks = true"
termStr="${termStr}\ncursor_blink = on"
termStr="${termStr}\ncursor_shape = ibeam"
termStr="${termStr}\npadding = 5px"
termStr="${termStr}\nroundness = 2.0\n\n\n[colors]\n" 
termStr="${termStr}background = rgba(63, 63, 63, .75)\n"
termStr="${termStr}highlight = #2f2f2f\n"

for c in ${!colors[@]}; do
	entry="color${c} = ${colors[$c]}"
	entry="${entry}\ncolor$((${c}+${#colors[@]})) = ${colors[$c]}"
	termStr="${termStr}${entry}\n"
done
echo -e "$termStr" > ~/.config/termite/config
