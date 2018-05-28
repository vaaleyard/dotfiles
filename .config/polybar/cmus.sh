#!/bin/bash


cmusstatus=$(cmus-remote -C status)
grep position <<< "$cmusstatus" 1>/dev/null 2>&1
if [ ! $? -eq 0 ]; then exit; fi

prepend_zero () {
    seq -f "%02g" $1 $1
}

strindex() { 
  x="${1%%$2*}"
  [[ "$x" = "$1" ]] && echo -1 || echo "${#x}"
}

get_all_but_first() {
  shift
  echo "$@"
}

get_stat() {
  line=$(grep "$1" -m 1 <<< "$cmusstatus")
  a=$(strindex "$line" "$1")
  sub="${line:a}"
  echo "$(get_all_but_first $sub)"
}



position=$(get_stat position)
minutes1=$(prepend_zero $(($position / 60 )))
seconds1=$(prepend_zero $(($position % 60)))

duration=$(get_stat duration)
minutes2=$(prepend_zero $(($position / 60)))
seconds2=$(prepend_zero $(($duration % 60)))

echo -n " $(cmus-remote -Q | egrep "tag artist|title" | sed 's/tag artist //;s/tag title //' | sed 'N;s/\n/ - /') [$minutes1:$seconds1 / $minutes2:$seconds2]"

