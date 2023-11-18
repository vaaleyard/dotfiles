set -g tide_character_icon '$'
set -g tide_time_format '%H:%M'
set -g tide_left_prompt_items pwd git character
set -g tide_right_prompt_items cmd_duration context jobs python rustc php ruby go terraform
set -g fish_key_bindings fish_vi_key_bindings

set fzf_preview_dir_cmd eza --all --color=always
set fzf_diff_highlighter delta --paging=never --width=20

# vars
set -x EDITOR nvim
set -x PATH "$PATH:$HOME/bin:$HOME/.local/bin:/opt/homebrew/bin"
set -x GPG_TTY (tty) # yubikey
set -x SSH_AUTH_SOCK (gpgconf --list-dirs agent-ssh-socket) # yubikey
gpgconf --launch gpg-agent # yubikey

source $HOME/.aliases
