#!/bin/bash
################################################################################
# Copyright (c) 2015 Nick Parry
#
# MIT License
#
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
#
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
# LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
# WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
################################################################################
#
# This may be my ugliest, but most useful creation. - NP 08-08-14 
# The purpose of this is to get songlyrics. There are several different methods
# available.
#
# Examples:
#   Use dbus/osascript to see what song is playing right now on spotify:
#       songLyrics spotify
#
#   Use dbus interface to see what song is playing right now in Rythmbox:
#       songLyrics spotify
#
#   Look up a song by a provided artist and title of a song:
#       songLyrics "artist" "title"
#
#   Look up a songlyrics.com url:
#       songLyrics <songlyrics.com url> 
#
#   Look up a azlyrics.com ur:
#       songLyrics <azlyrics.com url>
#
# TODO: Provide this:
#   Look up lyrics on a song by artist and title, but show the top 10 google
#   results:
#       songLyrics [-g|--google[ "artist" "title"
################################################################################
# Setup some variables
USER_AGENT='Mozilla/5.0'
CURL="curl -s -A '$USER_AGENT'";

################################################################################
# This is used to get the url for the lyrics
################################################################################
function google { Q="$@"
    GOOG_URL='https://www.google.com/search?tbs=li:1&q='
    AGENT="Mozilla/4.0"
    stream=$(curl -A "$AGENT" -skLm 10 "${GOOG_URL}${Q//\ /+}")
    echo "$stream" | grep -o "href=\"/url[^\&]*&amp;" | sed 's/href=".url.q=\([^\&]*\).*/\1/'
}

################################################################################
# Get the lyrics from plyrics
################################################################################
function do_it_plyrics() {
    # If we passed in a url
    if [[ "$1" == "--url" ]];then
        URL="$2"
    else
        ALL=$(google "$1 $2 lyrics site:plyrics.com");
        URL="$(echo $ALL | tr ' ' '\n' | grep "plyrics.com" -m 1)";
    fi

    if [[ -z "$URL" ]];then
        echo "There were no plyrics.com results. Giving up now :(";
        exit 0;
    fi
    # Print the artist and title we are going to look up
    echo -e "($URL) $1 - $2: ";
    # Run the curl and store the lyrics into a var
    # This uniq is sketchy, but if a song's lyrics are very similar, maybe I
    # don't care if we squash them anyways.
    RESULT="$($CURL $URL | awk '/start of lyric/, /end of lyric/' \
        | perl -pe 's/<.*?>//g' \
        | sed 's/^\s*//' \
        | sed 's/’//g' \
        | sed 's/‘//g' \
        | sed 's/”/"/g' \
        | sed 's/“/"/g' \
        | sed 's/…/.../g' \
        | sed 's/[fF][uU][cC][kK]/[32mF***[39m/g' \
        | sed 's/[sS][hH][iI][tT]/[32mS***[39m/g' \
        | sed "s/&#039;/'/g" \
        | sed 's/&rsquo;//g' \
        | sed 's/&quot;//g' \
        | uniq
    )"



    # If we didn't get anything, lets give up. This is the last option.
    if [[ -z "$RESULT" ]];then
        echo "That URL sucked. Giving up now :(";
        exit 0;

    # We found something
    else
        echo "$RESULT"
    fi

}

################################################################################
# Get the lyrics of a song by googling it, and parsing result pages
################################################################################
function do_it_songLyrics() {
    # If we passed in a url
    if [[ "$1" == "--url" ]];then
        URL="$2"
    else
        ALL=$(google "$1 $2 lyrics site:songlyrics.com");
        URL="$(echo $ALL | tr ' ' '\n' | grep "songlyrics.com" -m 1)";
    fi

    if [[ -z "$URL" ]];then
        echo "There were no songlyrics.com results. Trying plyrics now...";
        do_it_plyrics "$1" "$2"
        exit 0;
    fi
    # Print the artist and title we are going to look up
    echo -e "($URL) $1 - $2: ";
    # Run the curl and store the lyrics into a var
    # This uniq is sketchy, but if a song's lyrics are very similar, maybe I
    # don't care if we squash them anyways.
    RESULT="$($CURL $URL | awk '/<p id=\"songLyricsDiv\"/, /<\/p>/' \
        | perl -pe 's/<.*?>//g' \
        | sed 's/^\s*//' \
        | sed 's/’//g' \
        | sed 's/‘//g' \
        | sed 's/”/"/g' \
        | sed 's/“/"/g' \
        | sed 's/…/.../g' \
        | sed 's/[fF][uU][cC][kK]/[32mF***[39m/g' \
        | sed 's/[sS][hH][iI][tT]/[32mS***[39m/g' \
        | sed "s/&#039;/'/g" \
        | sed 's/&rsquo;//g' \
        | sed 's/&quot;//g' \
        | uniq
    )"



    # If we didn't get anything, lets give up. This is the last option.
    if [[ -z "$RESULT" ]];then
        echo "That URL sucked. Trying plyrics now..."
        do_it_plyrics "$1" "$2"
        exit 0;

    # We found something
    else
        echo "$RESULT"
    fi

}

################################################################################
# The a-z lyrics method
################################################################################
function do_it_azlyrics() {
    # If we passed it a url, lets just get it
    if [[ "$1" == '--url' ]];then
        URL="$2"
    else
        # Or, lets google it and get one
        ALL=$(google "$1 $2 lyrics site:azlyrics.com");
        URL="$(echo $ALL | tr ' ' '\n' | grep "azlyrics.com" -m 1)";
    fi

    if [[ -z "$URL" ]];then
        echo "There was no azlyrics.com results. Lets try songlyrics.com...";
        #do_it_azlyrics "$1" "$2"
        do_it_songLyrics "$1" "$2"
        exit 0;
    fi

    # Print the artist and title we are going to look up
    echo -e "($URL) $1 - $2: ";
    # Run the curl and store the lyrics into a var
    # This uniq is sketchy, but if a song's lyrics are very similar, maybe I
    # don't care if we squash them anyways.
        # The old method
        #| awk '/<!-- Usage of azlyrics.com content by any third-party lyrics provider is prohibited by our licensing agreement. Sorry about that. -->/, /<!-- MxM banner -->/' \
    RESULT="$($CURL $URL \
        | awk '/<!-- Usage of azlyrics.com content by any third-party lyrics provider is prohibited by our licensing agreement. Sorry about that. -->/, /<\/div>/' \
        | perl -pe 's/<.*?>//g' \
        | sed 's/^\s*//' \
        | sed 's/’//g' \
        | sed 's/‘//g' \
        | sed 's/”/"/g' \
        | sed 's/“/"/g' \
        | sed 's/…/.../g' \
        | sed 's/[fF][uU][cC][kK]/[32mF***[39m/g' \
        | sed 's/[sS][hH][iI][tT]/[32mS***[39m/g' \
        | sed "s/&#039;/'/g" \
        | sed 's/&rsquo;//g' \
        | sed 's/&quot;//g' \
        | uniq
    )";


    # See if that worked, if it didn't, lets try songLyrics
    if [[ -z "$RESULT" ]];then
        echo "That URL sucked. Lets try songlyrics.com...";
        do_it_songLyrics "$1" "$2"
        exit 0;

    # We found something, print it
    else
        echo "$RESULT"
    fi


}
################################################################################
# Look up the title and artist in spotify
# Sets the global ARTIST and TITLE varibles
################################################################################
function lookupSpotifyInfo() {
    # Checks $OSTYPE to determine the proper command for artist/title query
    if [[ "$OSTYPE" == "linux-gnu" ]];then
      ARTIST="$(dbus-send --print-reply --session --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.freedesktop.DBus.Properties.Get string:'org.mpris.MediaPlayer2.Player' string:'Metadata' | grep -A 3 artist | grep string | grep -v xesam | sed 's/^\s*//' | cut -d ' ' -f 2- | tr '(' ' ' | tr ')' ' ' | tr '"' ' ' )";

      TITLE="$(dbus-send --print-reply --session --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.freedesktop.DBus.Properties.Get string:'org.mpris.MediaPlayer2.Player' string:'Metadata' | grep -A 3 title | grep string | grep -v xesam | sed 's/^\s*//' | sed 's/^variant\s*//' | cut -d ' ' -f 2- | tr '(' ' ' | tr ')' ' ' | tr '"' ' ' )";

    elif [[ "$OSTYPE" == "darwin"* ]];then
      ARTIST="$(osascript -e 'tell application "Spotify" to artist of current track as string')";

      TITLE="$(osascript -e 'tell application "Spotify" to name of current track as string')";

    else
      echo "Your OS doesn't appear to be supported"
    fi

    if [[ -z "$ARTIST" || -z "$TITLE" ]];then
        echo "There was a problem getting the currently playing info from spotify";
        exit 1;
    fi

}

################################################################################
# Look up the song info for the currently playing song in Rhythmbox
# Sets the global ARTIST and TITLE varibles
################################################################################
function lookupRhythmboxInfo() {
    # This is a nasty one-liner that returns data like this:
    # string "artist"
    # variant             string "City and Colour"
    # --
    # string "title"
    # variant             string "Like Knives"

    # Get the Artist out of the dbus call
    ARTIST="$(rhythmbox-client --print-playing-format %ta)";
    # Get the Title out of the dbus call
    TITLE="$(rhythmbox-client --print-playing-format %tt)";
    
}

################################################################################
# Usage info
################################################################################
function usage() {
    echo "$(basename $0) - Find out the songlyrics for a currently playing song."
    echo "This script is capable of finding out the Artist and Title of the currently"
    echo "playing song. If, you are using Rhythmbox or Spotify. See usage message below."
    echo
    echo "Do it like this:"
    echo "$(basename $0) <artist> <title>       - To display lyrics for a song"
    echo "$(basename $0) spotify                - To look up info for the currently playing song in Spotify"
    echo "$(basename $0) rhythmbox|rbox         - To look up info for the currently playing song in Rhythmbox"
    echo "$(basename $0) <songlyrics.com url>   - To display the lyrics from a given songlyrics.com url"
    echo "$(basename $0) <azlyrics.com url>     - To display the lyrics from a given songlyrics.com url"
    # Print the args if any were passed
    if [[ -n "$1" ]];then
        echo -e "\nERROR:\n$1"
    fi
    exit 0;
}
################################################################################
# Main (Arg parsing crap)
################################################################################
########################################
# If given a songlyrics url 
########################################
if [[ "$(echo $1 | grep 'http://.*songlyrics.com' -i)" ]];then
    do_it_songLyrics --url "$1"
    exit; 

########################################
# Or an azlyrics url
########################################
elif [[ "$(echo $1 | grep 'http://.*azlyrics.com' -i)" ]];then
    do_it_azlyrics --url "$1"
    exit; 

elif [[ "$(echo $1 | grep 'http://.*plyrics.com' -i)" ]];then
    do_it_plyrics --url "$1"
    exit; 

########################################
# look up the lyrics using the Rhythmbox dbus api
########################################
elif [[ "$1" == 'rhythmbox' || "$1" == 'rbox' ]]; then
    lookupRhythmboxInfo
    echo "Looking up title by Rhythmbox artist and title...";
    echo "Artist: $ARTIST";
    echo "TITLE: $TITLE";

    do_it_azlyrics "$ARTIST" "$TITLE";
    exit 0;

########################################
# look up the lyrics from the currently playing spotify song
########################################
elif [[ "$1" == 'spotify' ]]; then
    # Sets the global ARTIST and TITLE vars
    lookupSpotifyInfo
    echo "Looking up title by Spotify artist and title...";
    echo "Artist: $ARTIST";
    echo "Title: $TITLE";

    do_it_azlyrics "$ARTIST" "$TITLE";
    exit 0;

########################################
# Artist Title args to look up
########################################
elif [[ -n "$1" && -n "$2" ]];then
    do_it_azlyrics "$1" "$2";
    exit 0;
else
    usage 
fi
