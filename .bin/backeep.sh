#!/usr/bin/env sh

KEEPASS_FILE=~/syncthing/keepass/keepass.kdbx
KEEPASS_FILE_MD5=$(md5sum $KEEPASS_FILE | awk '{ print $1 }')

OLD_KEEPASS_FILE=~/keepass.kdbx
OLD_KEEPASS_FILE_MD5=$(md5sum $OLD_KEEPASS_FILE | awk '{ print $1 }')

if [ "$KEEPASS_FILE_MD5" != "$OLD_KEEPASS_FILE_MD5" ]; then
    mv $OLD_KEEPASS_FILE ~/syncthing/keepass/old-keepass.kdbx
    #rm -f ~/syncthing/keepass/old-old-keepass.kdbx

    cp "$KEEPASS_FILE" $OLD_KEEPASS_FILE
    cp "$KEEPASS_FILE" ~/Documents
    echo "$KEEPASS_FILE_MD5, $(date)" > ~/.keepass-md5
fi


