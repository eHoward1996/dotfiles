# Get the colors from the current theme here.
colorsFile="${HOME}/.config/i3/colors"
finalTheme="${HOME}/.config/rofi/rofi-theme.rasi"
baseTheme="${HOME}/.config/rofi/base.rasi"

colors=()

while read -r line || [[ -n "$line" ]]; do
	colors+=("$line")
done < "$colorsFile"

python ~/Programs/dotfiles/.config/i3/setRofiTheme.py ${colors[*]}
cat $baseTheme >> $finalTheme

rofi -modi "drun,run" \
	-show drun \
	-show-icons papirus-icon-theme-master \
	-theme ~/.config/rofi/rofi-theme