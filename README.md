<p align="center">
    <img src="https://i.imgur.com/YHr1OMl.png" align="center">
</p>

![Alt text](https://i.imgur.com/F5AFwFc.png "scrot") <br />

## Tree
```
$HOME
  ├── bin
  ├── etc
  │   ├── X11
  │   ├── bash
  │   ├── bspwm
  │   ├── cmus
  │   ├── dconf
  │   ├── dunst
  │   ├── feh
  │   ├── git
  │   ├── i3
  │   ├── mpv
  │   ├── neomutt
  │   ├── newsboat
  │   ├── nvim
  │   ├── polybar
  │   ├── ranger
  │   ├── sxhkd
  │   ├── sxiv
  │   ├── tmux
  │   ├── weechat
  │   └── zathura
  ├── src
  │   ├── build
  │   ├── code
  ├── usr
  │   ├── desktop
  │   ├── docs
  │   ├── images
  │   ├── lib
  │   ├── music
  │   ├── suckless
  │   └── videos
  └── var
      └── share
```

## Setup

### CLI

- **newsboat**: RSS feed reader for text terminals.
- **mutt**: Fast and secure text-based mail client.
- **weechat**: IRC client.
- **ranger**: A vim-like & lightweight file manager.
- **mksh**: An alternative shell to bash, MirBSD Korn Shell.
- **tmux**: A terminal multiplexer.
- **vim**: Highly configurable text editor, I'm using with no plugins, only vanilla vim.
- **transmission-remote-cli**: Curses interface for the daemon of the BitTorrent client Transmission.
- **scrot**: Minimalist screen capture.
- **youtube-dl**: Open source program to download videos from YouTube.
- **surfraw**: Fast search engine from CLI.
- **kpcli**: Command Line password manager for KeePass.
- **cmus**: Music player.

### GUI

- **Pale Moon**: The only browser that's fast and doesn't consume so much memory.
- **dunst**: Lightweight notification-daemon.
- **zathura**: Minimalistic and highly customizable document viewer.
- **sxiv**: Lightweight and powerful image viewer.
- **mpv**: A free software command line video player highly customizable.

## Info

- Distro: `Void Linux`
- Window Manager: `dwm`
- Bar: `dwm custom bar`
- Terminal Emulator: `st`
- Editor: `vim`
- Font: `Hack`

## Install

### Requirements
The following packages need to be installed:  
- ansible  
- git  

After installing them, paste the following line into the terminal:


```
curl -fsSL bit.do/autism-sh | sh -s -- --autism master
```

## X11 files

To get touchpad working after a minimal install, copy the code below to the file `/etc/X11/xorg.conf.d/30-touchpad.conf`:

```
Section "InputClass"
        Identifier "touchpad"
        Driver "libinput"
        MatchIsTouchpad "on"
        Option "Tapping" "on"
        Option "XkbModel" "thinkpad60"
        Option "TappingButtonMap" "lmr"
        Option "TappingDrag" "on"
EndSection
```

Set keyboard to br-abnt2, but with thinkpad keyboard `/etc/X11/xorg.conf.d/00-keyboard.conf`
```
 Section "InputClass"
        Identifier "keyboard-all"
        MatchIsKeyboard "on"
        MatchDevicePath "/dev/input/event*"
        Driver "evdev"
        Option "XkbLayout" "br"
        Option "XkbModel" "thinkpad60"
        Option "XkbOptions" "terminate:ctrl_alt_bksp"
EndSection
```

Get audio working in thinkpads: `/etc/modprobe.d/alsa-base.conf` (don't ask me why it works)
```
options snd-hda-intel position_fix=1 model=lenovo
```

## Mutt config

I've configured my neomutt to work with gpg, so my passwords and emails are not stored in plain text files like it was before (that's why I hadn't pushed to the repo). They are encrypted with gpg, so only me can decrypt it.

To use my config just create a `$HOME/pass.gpg` with your information like this:

```
set my_user="<email-user>"       # Don't write what there's after @. Example: in email@potato.com, write only "email"
set my_pass="<your-password>"
set my_name="<your-name>"
```

Pay attention to the sed commands mixed with gpg in each email file I have.


---

My dotfiles are managed with a bare repository. I used to store my dots with gnu stow, but it causes some things I don't want to, so I'm trying to give it a try. Here are some links explaining a bare repo:
* [The best way to store your dotfiles: A bare Git repository](https://developer.atlassian.com/blog/2016/02/best-way-to-store-dotfiles-git-bare-repo/)
* [Manage Dotfiles With a Bare Git Repository](https://harfangk.github.io/2016/09/18/manage-dotfiles-with-a-git-bare-repository.html)

Posts about managing with GNU stow:
* [Managing dotfiles with GNU stow](http://blog.xero.nu/managing_dotfiles_with_gnu_stow)
* [Using GNU stow to manage your dotfiles](http://brandon.invergo.net/news/2012-05-26-using-gnu-stow-to-manage-your-dotfiles.html)
* [Dotfile management with GNU stow](https://jonleopard.com/dotfile-management-with-gnu-stow/)
* [Using GNU stow with your dotfiles](https://protesilaos.com/codelog/gnu-stow-dotfiles/)

Interesting read: [Why share your dotfiles](https://zachholman.com/2010/08/dotfiles-are-meant-to-be-forked/)
