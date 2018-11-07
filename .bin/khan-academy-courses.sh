#!/usr/bin/env sh

CACHEDIR="/tmp/videos/sedturbate"
CACHEFILE="/tmp/videos/sedturbate/cams.txt"

mkdir -p $CACHEDIR

# Primeiro sed:
# 1.1 - filtra o nome de cada camgirl
# 1.2 - filtra a quantidade de viewers que cada camgirl tem
# Segundo sed:
# 2.1 - Coloca a quantidade de views na frente do nome de cada camgirl (juntando a linha debaixo com)
# 2.2 - adiciona a palavra viewers no final da linha

curl -sL https://www.chaturbate.com/female-cams | sed -rne 's,^<a href="/(\w*)/">$,\1,p ; s/<li\ class="cams">[0-9]+ mins, ([0-9]+) viewers<\/li>/\1/p' | sed -rn 'N;s/\n/ - /; s/$/ viewers/p' > $CACHEFILE

NUM=$(wc -l $CACHEFILE | cut -d' ' -f1)

printf "Chaturbate - female cams\n"
nl -w 1 $CACHEFILE

printf "Choose a video: "
read op

VIDEO=$(nl -w 1 $CACHEFILE | sed -n "/^$op/p" | awk -F' ' '{print $2}')
if [ "$op" = "q" -o "$op" = "Q" ];
then
    printf "Canceled.\n"
    exit 0
else
    mpv --ytdl-format=slow-2 https://www.chaturbate.com/$VIDEO 2>/dev/null &
fi

