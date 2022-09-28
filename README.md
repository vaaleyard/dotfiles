<p align="center">
    <img src="https://i.imgur.com/YHr1OMl.png" align="center">
    <p align="center"> my custom config for terminals, editors, git, etc. </p>
</p>

---

![Alt text](scrot.png "scrot") <br />

## Tree
```
$HOME
  ├── bin
  ├── etc
  │   ├── git
  │   ├── lvim
  │   ├── tmux
  │   └── weechat
  ├── src
  │   └── github.com
  └── usr
      ├── home
      ├── docs
      ├── images
      ├── lib
      ├── music
      ├── suckless
      └── videos
```
Explanation:
- bin: place to put custom scripts that must be in my PATH
- etc: configuration for programs (same use of `~/.config`)
- src: contains all my git clones, my git repositories and the ones I'm contributing
- usr: don't know how to explain but home dir contains files that must be in $HOME folder

## Setup

### CLI

- **weechat**: IRC client.
- **zsh**: The Z shell.
- **starship**: The minimal, blazing-fast, and infinitely customizable prompt for any shell!
- **tmux**: A terminal multiplexer.
- **lunarvim**: LunarVim is an opinionated, extensible, and fast IDE layer for Neovim.
- **brew**: The Missing Package Manager for macOS.
- **karabiner**: A powerful and stable keyboard customizer for macOS.
- **fig**: Fig adds IDE-style autocomplete to your existing terminal.
- **iTerm2**: Terminal emulator.

### GUI

- **raycast**: Raycast is a blazingly fast, totally extendable launcher.
- **iina**: The modern media player for macOS.
- **neovide**: GUI for Neovim.

## Info

- Distro: `macOS`
- Terminal Emulator: `iTerm2`
- Editor: `lunarvim (neovim)`
- Font: `JetBrains Mono Nerd Font`

## Install

### Requirements
The following packages need to be installed:  
- stow
- git  

After installing them as a bare repo (see links below), paste the following line into the terminal:

```bash
cd $HOME
stow etc --target=$HOME/.config
cd $HOME && stow home --target=$HOME

# unstow:
stow -D etc --target=$HOME/.config
```

---

My dotfiles are managed with a bare repository. I also "install" them with GNU stow. Here are some links explaining a bare repo:
* [The best way to store your dotfiles: A bare Git repository](https://developer.atlassian.com/blog/2016/02/best-way-to-store-dotfiles-git-bare-repo/)
* [Manage Dotfiles With a Bare Git Repository](https://harfangk.github.io/2016/09/18/manage-dotfiles-with-a-git-bare-repository.html)

And more links about managing it with GNU stow:
* [Using GNU stow to manage your dotfiles](http://brandon.invergo.net/news/2012-05-26-using-gnu-stow-to-manage-your-dotfiles.html)
* [Dotfile management with GNU stow](https://jonleopard.com/dotfile-management-with-gnu-stow/)
* [Using GNU stow with your dotfiles](https://protesilaos.com/codelog/gnu-stow-dotfiles/)

Interesting read:
* [Why share your dotfiles](https://zachholman.com/2010/08/dotfiles-are-meant-to-be-forked/)
* [Rob Pike: “Dotfiles” being hidden is a UNIXv2 mistake (2012)](https://web.archive.org/web/20180827160401/https://plus.google.com/+RobPikeTheHuman/posts/R58WgWwN9jp)
