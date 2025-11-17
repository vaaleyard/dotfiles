#!/bin/bash

# This script enables a set of "sane" defaults
set -eufo pipefail

# Disable all text "smart features"
defaults write -g NSAutomaticCapitalizationEnabled -int 0
defaults write -g NSAutomaticDashSubstitutionEnabled -int 0
defaults write -g NSAutomaticInlinePredictionEnabled -int 0
defaults write -g NSAutomaticPeriodSubstitutionEnabled -int 0
defaults write -g NSAutomaticQuoteSubstitutionEnabled -int 0
defaults write -g NSAutomaticSpellingCorrectionEnabled -int 0
defaults write -g NSAutomaticTextCorrectionEnabled -int 0
defaults write -g NSAutomaticWindowAnimationsEnabled -int 0

defaults write -g NSDocumentSaveNewDocumentsToCloud -int 0
defaults write -g NSUserDictionaryReplacementItems '()'
defaults write -g WebAutomaticSpellingCorrectionEnabled -int 0

defaults write -g InitialKeyRepeat -int 15
defaults write -g KeyRepeat -int 2

defaults write -g com.apple.swipescrolldirection -int 0 # disable "natural" scrolling
defaults write -g com.apple.trackpad.forceClick -int 0

defaults write com.apple.dock autohide -int 1
defaults write com.apple.dock show-recents -int 0

defaults write com.apple.finder FXPreferredViewStyle -string Nlsv
defaults write com.apple.finder _FXSortFoldersFirst -int 1
defaults write com.apple.finder FXRemoveOldTrashItems -int 1
defaults write com.apple.finder FXEnableExtensionChangeWarning -int 0
