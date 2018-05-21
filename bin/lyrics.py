import requests
import sys
from bs4 import BeautifulSoup
import os
import re

try:
    from urllib.parse import quote_plus
except ImportError:
    from urllib import quote_plus


def get_lyrics(song_name):
    search_name = song_name + ' genius'
    name = quote_plus(search_name)
    hdr = {'User-Agent': 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.11'
           '(KHTML, like Gecko) Chrome/23.0.1271.64 Safari/537.11',
           'Accept-Language': 'en-US,en;q=0.8',
           'Connection': 'keep-alive'}

    url = 'http://www.google.com/search?q=' + name

    result = requests.get(url, headers=hdr).text
    link_start = result.find('https://genius.com')

    if(link_start == -1):
        return get_lyrics_musixmatch(song_name)
        
    link_end = result.find('"', link_start + 1)
    link = result[link_start:link_end]

    lyrics_html = requests.get(link, headers={
                               'User-Agent': 'Mozilla/5.0 (Macintosh; Intel'
                               'Mac OS X 10_12_1) AppleWebKit/537.36 (KHTML, '
                               'like Gecko) Chrome/55.0.2883.95 Safari/537.36'
                               }
                               ).text

    soup = BeautifulSoup(lyrics_html, "lxml")
    raw_lyrics = str(soup.findAll('div', attrs={'class': 'lyrics'}))
    lyrics = raw_lyrics[1:len(raw_lyrics)-1]
    lyrics = re.sub(r"<[^<>]*>", '', lyrics)
    return lyrics[2:len(lyrics)]

def get_lyrics_musixmatch(song_name):
    search_name += song_name + ' musixmatch'
    name = quote_plus(search_name)
    hdr = {'User-Agent': 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.11'
           '(KHTML, like Gecko) Chrome/23.0.1271.64 Safari/537.11',
           'Accept-Language': 'en-US,en;q=0.8',
           'Connection': 'keep-alive'}

    url = 'http://www.google.com/search?q=' + name

    result = requests.get(url, headers=hdr).text
    link_start = result.find('https://www.musixmatch.com')

    if(link_start == -1):
        return("Lyrics not found on genius or musixmatch")
        
    link_end = result.find('"', link_start + 1)
    link = result[link_start:link_end]

    lyrics_html = requests.get(link, headers={
                               'User-Agent': 'Mozilla/5.0 (Macintosh; Intel'
                               'Mac OS X 10_12_1) AppleWebKit/537.36 (KHTML, '
                               'like Gecko) Chrome/55.0.2883.95 Safari/537.36'
                               }
                               ).text

    soup = BeautifulSoup(lyrics_html, "lxml")
    raw_lyrics = str(soup.findAll('p', attrs={'class': 'mxm-lyrics__content'}))
    lyrics = raw_lyrics[1:len(raw_lyrics)-1]
    lyrics = re.sub(r"<[^<>]*>", '', lyrics)
    return lyrics

print(sys.argv[2].upper()+' - '+sys.argv[1].upper()+'\n')
print(get_lyrics(sys.argv[1]+' '+sys.argv[2]))
