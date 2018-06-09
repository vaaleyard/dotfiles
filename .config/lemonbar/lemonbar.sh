#!/bin/bash

font="-*-cherry-*-*-*--*-*"
icon="-*-siji-medium-*-*--*-*"
icon1="Font Awesome"

clock() {
	TIME=$(date "+%H:%M")
	printf "%s\\n" "$TIME"
}

wifi() {
	WIFI=$(iwconfig wlp6s0 | sed -n 's/"//g; s/\s*$//g; s/.*ESSID://p')

	if [ "$wifi" == "off/any" ]; then
		WIFI_OUTPUT="no wifi"
	else
		WIFI_OUTPUT="${WIFI}"
	fi

	printf "%s\\n" "$WIFI_OUTPUT"
}

volume(){
	NOTMUTED=$( amixer sget Master | grep "\[on\]" )
	if [[ ! -z $NOTMUTED ]] ; then
		VOL=$(awk -F"[][]" '/dB/ { print $2 }' <(amixer sget Master) | sed 's/%//g')
		if [ $VOL -ge 55 ] ; then
			echo -e "%{F#5F8972} %{F#A9C4C6}${VOL}%"
		elif [ $VOL -ge 20 ] ; then
			echo -e "%{F#5F8972} %{F#A9C4C6}${VOL}%"
		else
			echo -e "%{F#5F8972} %{F#A9C4C6}${VOL}%"
		fi
	else
		echo -e "%{F#cc241d} %{F#cc241d}muted"
	fi
}

battery() {
	battery="$(</sys/class/power_supply/BAT0/capacity)"
	charging="$(</sys/class/power_supply/BAT0/status)"

	[ "$charging" == "Charging" ] && \
		battery="%{F#5F8972}%{F#A9C4C6} ${battery}%"

	case "$battery" in
		[0-9]|10)
			battery="%{F#5F8972}%{F#A9C4C6} ${battery}%"
			;;

		1[0-9]|2[0-5])
			battery="%{F#5F8972}%{F#A9C4C6} ${battery}%"
			;;

		2[6-9]|3[0-9]|4[0-9]|50)
			battery="%{F#5F8972}%{F#A9C4C6} ${battery}%"
			;;

		5[1-9]|6[0-9]|7[0-5])
			battery="%{F#5F8972}%{F#A9C4C6} ${battery}%"
			;;

		7[6-9]|8[0-9]|9[0-9]|100)
			battery="%{F#5F8972}%{F#A9C4C6} ${battery}%"
			;;
	esac

	printf "%s" "$battery"

}

works() {
	workspace_list=""
	i3_next="i3-msg workspace next_on_output, exec echo_ws"
	i3_prev="i3-msg workspace prev_on_output, exec echo_ws"

	while read -r workspace; do
		ws="${workspace/* }"
		case "$workspace" in
			*"*"*) workspace_list+="%{F#A9C4C6} $ws "
				;;
			*) workspace_list+="%{A:i3-msg workspace ${ws}:}%{F#5F8972} $ws %{A}%{F#676e7d}" ;;
		esac
	done < <(wmctrl -d)
	output="%{A4:${i3_next}:}%{A5:${i3_prev}:}${workspace_list}%{A}%{A}" 
	echo "$output"
}
workspaces() {
	workspacenext="A4:i3-msg workspace next_on_output:"
	workspaceprevious="A5:i3-msg workspace prev_on_output:"
	wslist=$(\
		wmctrl -d \
		| awk '/ / {print $2 $9, $10, $11, $12, $13, $14, $15, $16, $17, $18, $19, $20}' ORS=''\
		| sed -e 's/\s*  //g' \
		-e 's/\*[ 0-9A-Za-z]*[^ -~]*/  &  /g' \
		-e 's/\-[ 0-9A-Za-z]*[^ -~]*/%{B#282828}%{A:i3-msg workspace &:}  &  %{B#458588}/g' \
		-e 's/\*//g' \
		-e 's/ -/ /g' \
		)
			echo -n "%{$workspacenext}%{$workspaceprevious}$wslist%{A}%{A}"
}

while true; do
	output="%{l}$(works)%{c}%{F#5F8972}%{B-} %{F#A9C4C6}$(clock) %{B-}%{r} $(battery) %{B-} $(volume) %{B-} %{F#5F8972}%{F-}%{F#A9C4C6} $(wifi) %{B-}"
	echo "$output"
	sleep 1;
done |
lemonbar -p -d -B#101e22 -F#ebdbb2 \
	-f "$font" -f "$icon" -g 1000x22+175+10 | bash
