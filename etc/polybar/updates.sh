#!/usr/bin/env bash

#updates=$(xbps-install --update --dry-run --sync | wc -l)
#if [ "$updates" -gt 0 ]; then
#    echo "# $updates"
#else
#    echo ""
#fi


updates=$(xbps-install --update --dry-run --sync | wc -l)
warning_color='#ff5555'

if [ "$updates" -eq 0 ]; then
	echo ""
else
	echo "%{F${warning_color}}%{F-} ${updates}"
fi
