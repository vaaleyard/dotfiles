#!/usr/bin/env bash
#
# by mhess

[ "$UID" -ne "0" ] && {
    printf '%b\n' "Only Root!"
    exit 1
}

CURRENT_RELEASE="$(curl -s http://linux.palemoon.org/download/mainline/ | sed -rn 's/^\s.*Latest release: ([0-9.]+).*$/\1/p')"

printf '%s\n\n%s\n%s\n\n' 'What do you want?' '1) Install palemoon' '2) Check for updates'
read number

if [ "$number" = '1'  ]; then
	wget --progress=bar:force -P /tmp http://linux.palemoon.org/datastore/release/palemoon-${CURRENT_RELEASE}.linux-x86_64.tar.bz2

	tar xvjf /tmp/palemoon* -C /opt/
	mkdir -p /opt/bin
	ln -s /opt/palemoon/palemoon /opt/bin/palemoon

else

BIN=$(whereis palemoon)
BIN=${BIN#* }
LOCAL=$(ls -l "$BIN" | grep '\->')
LOCAL=${LOCAL##* }
LOCAL=${LOCAL%/*}
FINAL_DIR=${LOCAL%/*}
CURRENT_VERSION="$(palemoon --version | grep -o '[0-9.]\+')"

	if [ "$CURRENT_VERSION" != "$CURRENT_RELEASE" ]
		then
			printf '%s\n' 'There is a new release available!'
		else
			printf '%s\n' 'You are using the last release'
			exit 0
	fi

	while true; do
		printf 'Do you want to upgrade now? [Y/n] '
		read input
		case "$input" in
			Y|y) wget --progress=bar:force -P /tmp https://linux.palemoon.org/datastore/release/palemoon-${CURRENT_RELEASE}.linux-x86_64.tar.bz2 && break ;;
			N|n) exit 0 ;;
			*) echo "Invalid option!" ;;
		esac
	done

	printf '\nEnter your password to continue\n'
	if [ -z "$LOCAL"  ]
	then
		rm -r "$BIN"
	else
		rm -r "$LOCAL"
		rm -r "$BIN"
	fi

	tar xvjf /tmp/palemoon-* -C "$FINAL_DIR"
	ln -s ${LOCAL}/palemoon "$BIN"

	printf '\nUpdate completed!\n'
fi
