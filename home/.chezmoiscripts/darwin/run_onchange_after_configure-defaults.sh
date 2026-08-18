#!/usr/bin/env bash

# Enable a set of "sane" macOS defaults.
set -euo pipefail

# Text input
## Disable automatic text "smart features"
defaults write -g NSAutomaticCapitalizationEnabled -bool false
defaults write -g NSAutomaticDashSubstitutionEnabled -bool false
defaults write -g NSAutomaticInlinePredictionEnabled -bool false
defaults write -g NSAutomaticPeriodSubstitutionEnabled -bool false
defaults write -g NSAutomaticQuoteSubstitutionEnabled -bool false
defaults write -g NSAutomaticSpellingCorrectionEnabled -bool false
defaults write -g NSAutomaticTextCorrectionEnabled -bool false

defaults write -g NSUserDictionaryReplacementItems -array
defaults write -g WebAutomaticSpellingCorrectionEnabled -bool false

# Keyboard
## Repeat keys instead of showing the accent/special-character popup
defaults write -g ApplePressAndHoldEnabled -bool false

## Faster key repeat
defaults write -g InitialKeyRepeat -int 15
defaults write -g KeyRepeat -int 2

# Trackpad
## Disable "natural" scrolling
defaults write -g com.apple.swipescrolldirection -bool false

## Disable Force Click
defaults write -g com.apple.trackpad.forceClick -bool false

## Enable tap-to-click
defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults write -g com.apple.mouse.tapBehavior -int 1

## Enable three-finger drag
defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerDrag -bool true
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerDrag -bool true

# Windows / animations
## Disable window animations
defaults write -g NSAutomaticWindowAnimationsEnabled -bool false

# Documents
## Save new documents locally instead of iCloud by default
defaults write -g NSDocumentSaveNewDocumentsToCloud -bool false

# Dock
## Automatically hide the Dock
defaults write com.apple.dock autohide -bool true

## Don't show recent applications
defaults write com.apple.dock show-recents -bool false

## Remove all applications from the Dock
## Finder and Trash remain because they are special Dock items.
defaults write com.apple.dock persistent-apps -array

# Finder
## Use list view by default
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"

## Keep folders at the top when sorting
defaults write com.apple.finder _FXSortFoldersFirst -bool true

## Remove items from Trash after 30 days
defaults write com.apple.finder FXRemoveOldTrashItems -bool true

## Disable warning when changing a file extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

## Hide Tags section in Finder sidebar
defaults write com.apple.finder SidebarTagsSctionDisclosedState -bool false

# Show all file extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Keep folders at the top when sorting
defaults write com.apple.finder _FXSortFoldersFirst -bool true

# Show path bar
defaults write com.apple.finder ShowPathbar -bool true

# Show status bar
defaults write com.apple.finder ShowStatusBar -bool true

# Restart affected applications
killall Dock 2>/dev/null || true
killall Finder 2>/dev/null || true

echo "macOS defaults applied."
echo "Some trackpad settings may require logging out and back in to take effect."
