<p align="center">
    <img src="https://i.imgur.com/YHr1OMl.png" align="center">
    <p align="center"> my custom config for terminals, editors, git, etc. </p>
</p>

![Alt text](https://github.com/Valeyard1/dotfiles/blob/master/scrot.png "scrot") <br />

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
- ansible  
- git  

After installing them, paste the following line into the terminal:


```bash
curl -fsSL bit.do/autism-sh | sh -s -- --autism master
```


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
