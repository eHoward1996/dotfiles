img="${HOME}/Pictures/Wallpapers/"
walSelectedImg="`cat ${HOME}/.cache/wal`"
walColorFile="${HOME}/.cache/wal/colors"
pyProcessColorFile=".config/i3/configColors.py"
colors=()

wal -i "$img"
feh --bg-scale "${walSelectedImg}"

while read -r line || [[ -n "$line" ]]; do
	colors+=("$line")
done < "$walColorFile"

colors=( $(python "$HOME/$pyProcessColorFile" ${colors[*]}) )
colorStr=""

for c in "${!colors[@]}"; do
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
termStr="${termStr}background = rgba(63, 63, 63, 0.6)\n"
termStr="${termStr}highlight = #2f2f2f\n"

for c in ${!colors[@]}; do
	entry="color${c} = ${colors[$c]}"
	entry="${entry}\ncolor$((${c}+${#colors[@]})) = ${colors[$c]}"
	termStr="${termStr}${entry}\n"
done
echo -e "$termStr" > ~/.config/termite/config
