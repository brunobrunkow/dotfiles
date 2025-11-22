-- ~/.hammerspoon/init.lua
-- Hammerspoon Configuration

--------------------------------------------------------------------------------
-- Configuration
--------------------------------------------------------------------------------

hs.window.animationDuration = 0.2
hs.notify.new({title="Hammerspoon", informativeText="Config loaded"}):send()

--------------------------------------------------------------------------------
-- Load Modules
--------------------------------------------------------------------------------

local appToggle = require("modules.app-toggle")
local windowMgmt = require("modules.window-management")
local mediaControls = require("modules.media-controls")
local urlCommand = require("modules.url-command")

--------------------------------------------------------------------------------
-- Application Hotkeys
--------------------------------------------------------------------------------

-- Cmd+Space: Toggle Ghostty terminal
appToggle.bindToggle({"cmd"}, "space", "Ghostty")

--------------------------------------------------------------------------------
-- Window Management Hotkeys
--------------------------------------------------------------------------------

local winMod = {"cmd", "alt"}

-- Arrow keys: half-screen positioning + maximize + center
windowMgmt.bindHotkeys(winMod)

-- U/I/N/M: quarter-screen positioning
windowMgmt.bindQuarterScreenHotkeys(winMod)

-- K/O/L/Ö: vim-style focus navigation
windowMgmt.bindVimFocusHotkeys(winMod)

-- Ctrl+Arrow: move window between displays
windowMgmt.bindMultiDisplayHotkeys({"cmd", "alt", "ctrl"})

-- Shift+K/O/L/Ö: swap windows
windowMgmt.bindWindowSwapHotkeys({"cmd", "alt", "shift"})

--------------------------------------------------------------------------------
-- Media Controls
--------------------------------------------------------------------------------

-- Mouse buttons 4/5: volume control
mediaControls.bindMouseButtons()

--------------------------------------------------------------------------------
-- URL Commands
--------------------------------------------------------------------------------

-- Cmd+Shift+U: Download audio from clipboard URL
urlCommand.bindHotkey({"cmd", "shift"}, "U",
    "cd ~/Downloads && yt-dlp --cookies-from-browser firefox --audio-quality 0 -x --audio-format mp3 -o '%%(album)s/%%(playlist_index)02d-%%(title)s.%%(ext)s' %s")

--------------------------------------------------------------------------------
-- System Hotkeys
--------------------------------------------------------------------------------

-- Ctrl+Option+Cmd+B: Sleep Mac
hs.hotkey.bind({"ctrl", "alt", "cmd"}, "B", hs.caffeinate.systemSleep)

-- Cmd+Option+Shift+R: Reload config
hs.hotkey.bind({"cmd", "alt", "shift"}, "R", hs.reload)

--------------------------------------------------------------------------------
-- Initialization Complete
--------------------------------------------------------------------------------

print("Hammerspoon configuration loaded successfully")
