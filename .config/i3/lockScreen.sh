img="`cat ${HOME}/.cache/wal/wal`"
lockJPG="${HOME}/.config/i3/lockIMG.jpg"
lockPNG="${HOME}/.config/i3/lockIMG.png"

set -- $(< ${HOME}/.config/i3/colors)

cp ${img} ${lockJPG}
convert ${lockJPG} ${lockPNG}
i3lock --image="${lockPNG}" \
	--indpos w:h \
	--bar-indicator \
	--bar-position h \
	--bar-direction 1 \
	--bar-max-height 10 \
	--bar-color=${1}88 \
	--keyhlcolor=${2}88 \
	--bar-width 100 \
	--redraw-thread \
	--clock \
	--force-clock \
	--timepos 5:h-80 \
	--timecolor=${3}ff \
	--datepos tx:ty+15 \
	--datecolor ${4}ff \
	--date-align 1 \
	--time-align 1 \
	--ringvercolor ${5}88 \
	--ringwrongcolor ${6}88 \
	--statuspos 5:h-16 \
	--verif-align 2 \
	--wrong-align 2 \
	--verifcolor ffffffff \
	--wrongcolor ffffffff \
	--modifpos -150:-50 \

rm ${lockJPG} ${lockPNG}
