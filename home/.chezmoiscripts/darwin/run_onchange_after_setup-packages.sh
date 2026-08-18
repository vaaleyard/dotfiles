#!/usr/bin/env bash

set -euo pipefail

# Set fish as default
FISH_PATH="$(brew --prefix)/bin/fish"
if ! grep -Fxq "$FISH_PATH" /etc/shells; then
  echo "$FISH_PATH" | sudo tee -a /etc/shells >/dev/null
fi
CURRENT_SHELL="$(dscl . -read "$HOME" UserShell | awk '{print $2}')"
if [ "$CURRENT_SHELL" != "$FISH_PATH" ]; then
  chsh -s "$FISH_PATH"
fi
# Set Fish's built-in "arrow" prompt
"$FISH_PATH" -c 'fish_config prompt save arrow'

# LazyVim
if [ ! -d "$HOME/.config/nvim" ]; then
  git clone https://github.com/LazyVim/starter "$HOME/.config/nvim"
  rm -rf "$HOME/.config/nvim/.git"
fi

# Login Items
add_login_item() {
  local name="$1"
  local path="$2"

  if [ ! -d "$path" ]; then
    echo "Skipping login item: $name is not installed"
    return
  fi

  osascript <<EOF
tell application "System Events"
    if not (exists login item "$name") then
        make login item at end with properties {name:"$name", path:"$path", hidden:false}
    end if
end tell
EOF
}

add_login_item "Shottr" "/Applications/Shottr.app"
add_login_item "AeroSpace" "/Applications/AeroSpace.app"
add_login_item "Raycast" "/Applications/Raycast.app"
add_login_item "Stats" "/Applications/Stats.app"
