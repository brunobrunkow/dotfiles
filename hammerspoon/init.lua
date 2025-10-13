-- ~/.hammerspoon/init.lua
-- Hammerspoon Configuration
--
-- This is the main configuration file for Hammerspoon.
-- Modules are loaded from the 'modules' directory to keep the config organized.
--
-- To reload this configuration: Cmd+Option+Ctrl+R (default Hammerspoon hotkey)

--------------------------------------------------------------------------------
-- Configuration
--------------------------------------------------------------------------------

-- Set window animation duration (0.2 is default)
hs.window.animationDuration = 0.2

-- Show a notification when config is loaded
hs.notify.new({title="Hammerspoon", informativeText="Config loaded"}):send()

--------------------------------------------------------------------------------
-- Load Modules
--------------------------------------------------------------------------------

local appToggle = require("modules.app-toggle")
local windowMgmt = require("modules.window-management")
local mediaControls = require("modules.media-controls")

--------------------------------------------------------------------------------
-- Application Hotkeys
--------------------------------------------------------------------------------

-- Ghostty Terminal Toggle
-- Cmd+Space: Show/hide Ghostty terminal
appToggle.bindToggle({"cmd"}, "space", "Ghostty")

-- Add more application hotkeys here:
-- appToggle.bindToggle({"cmd", "shift"}, "b", "Safari")
-- appToggle.bindToggle({"cmd", "shift"}, "c", "Visual Studio Code")

--------------------------------------------------------------------------------
-- Window Management Hotkeys
--------------------------------------------------------------------------------

-- Window positioning with Cmd+Option+Arrow keys
-- Cmd+Option+Left: Move window to left half of screen
-- Cmd+Option+Right: Move window to right half of screen
-- Cmd+Option+Up: Maximize window to full screen
-- Cmd+Option+Down: Center window on screen
windowMgmt.bindHotkeys({"cmd", "alt"})

-- Quarter-screen positioning with Cmd+Option+U/I/N/M
-- Cmd+Option+U: Move window to top-left quarter
-- Cmd+Option+I: Move window to top-right quarter
-- Cmd+Option+N: Move window to bottom-left quarter
-- Cmd+Option+M: Move window to bottom-right quarter
windowMgmt.bindQuarterScreenHotkeys({"cmd", "alt"})

-- Vim-style window focus navigation with Cmd+Option+K/O/L/Ö
-- Cmd+Option+K: Focus window to the left
-- Cmd+Option+O: Focus window above
-- Cmd+Option+L: Focus window below
-- Cmd+Option+Ö: Focus window to the right
windowMgmt.bindVimFocusHotkeys({"cmd", "alt"})

-- Multi-display window movement with Cmd+Option+Ctrl+Arrow keys
-- Cmd+Option+Ctrl+Left: Move window to left display
-- Cmd+Option+Ctrl+Right: Move window to right display
windowMgmt.bindMultiDisplayHotkeys({"cmd", "alt", "ctrl"})

-- Window swapping with Cmd+Option+Shift+K/O/L/Ö
-- Cmd+Option+Shift+K: Swap focused window with left neighbor
-- Cmd+Option+Shift+O: Swap focused window with above neighbor
-- Cmd+Option+Shift+L: Swap focused window with below neighbor
-- Cmd+Option+Shift+Ö: Swap focused window with right neighbor
windowMgmt.bindWindowSwapHotkeys({"cmd", "alt", "shift"})

--------------------------------------------------------------------------------
-- Media Controls
--------------------------------------------------------------------------------

-- Volume control with mouse buttons
-- Mouse Button 4 (side button): Increase volume
-- Mouse Button 5 (side button): Decrease volume
mediaControls.bindMouseButtons()

--------------------------------------------------------------------------------
-- Custom Hotkeys
--------------------------------------------------------------------------------

-- Add any additional custom hotkeys below

-- Sleep system
-- Ctrl+Option+Cmd+B: Put the Mac to sleep
hs.hotkey.bind({"ctrl", "alt", "cmd"}, "B", function()
    hs.caffeinate.systemSleep()
end)

-- Reload Hammerspoon config
-- Cmd+Option+Shift+R: Reload configuration
hs.hotkey.bind({"cmd", "alt", "shift"}, "R", function()
    hs.reload()
end)

--------------------------------------------------------------------------------
-- Initialization Complete
--------------------------------------------------------------------------------

print("Hammerspoon configuration loaded successfully")
