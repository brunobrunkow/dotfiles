source './osx/utils.sh'

# Setting up my OS X preferences

# Scroll direction natural : False
defaults write -g com.apple.swipescrolldirection -bool false
print_success "Scroll direction natural (Lion style) set to false."

# Automatically hide and show the Dock
defaults write com.apple.dock autohide -bool true
print_success "Automatically hide and show the Dock."

# Display full path in Finder title window
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true
print_success "Finder shows full path in title."

# Check for software updates daily, not just once per week
defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1
print_success "Software updates checking daily"

# Trackpad: enable tap to click for this user and for the login screen
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
print_success "Tap to click enabled at the trackpad"


# Automatically quit printer app once the print jobs complete
defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true
print_success "Printer app quit once the prints complete."


# Disable the “Are you sure you want to open this application?” dialog
defaults write com.apple.LaunchServices LSQuarantine -bool false
print_success "Are you sure you want to open this app dialog disabled."

print_in_green() {
    printf "\e[0;32m$1\e[0m"
}

print_success() {
    print_in_green "  [✔] $1\n"
}