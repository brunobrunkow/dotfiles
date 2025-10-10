-- window-management.lua
-- Module for window positioning and sizing with hotkeys
--
-- This module provides functions to quickly position and resize windows
-- using keyboard shortcuts. Supports half-screen layouts, maximize, and centering.

local M = {}

--- Gets the focused window
-- @return window|nil The currently focused window, or nil if none
local function getFocusedWindow()
    return hs.window.focusedWindow()
end

--- Moves and resizes a window to occupy the left half of the screen
function M.moveToLeft()
    local win = getFocusedWindow()
    if not win then return end

    local screen = win:screen()
    local frame = screen:frame()

    win:setFrame({
        x = frame.x,
        y = frame.y,
        w = frame.w / 2,
        h = frame.h
    })
end

--- Moves and resizes a window to occupy the right half of the screen
function M.moveToRight()
    local win = getFocusedWindow()
    if not win then return end

    local screen = win:screen()
    local frame = screen:frame()

    win:setFrame({
        x = frame.x + (frame.w / 2),
        y = frame.y,
        w = frame.w / 2,
        h = frame.h
    })
end

--- Maximizes a window to fill the entire screen
function M.maximize()
    local win = getFocusedWindow()
    if not win then return end

    local screen = win:screen()
    local frame = screen:frame()

    win:setFrame(frame)
end

--- Centers a window on the screen at a reasonable size
-- The window will be sized to 70% of screen width and height
function M.center()
    local win = getFocusedWindow()
    if not win then return end

    local screen = win:screen()
    local frame = screen:frame()

    -- Use 70% of screen dimensions for centered window
    local width = frame.w * 0.7
    local height = frame.h * 0.7

    win:setFrame({
        x = frame.x + (frame.w - width) / 2,
        y = frame.y + (frame.h - height) / 2,
        w = width,
        h = height
    })
end

--- Moves window to the display on the left (west)
function M.moveToLeftDisplay()
    local win = getFocusedWindow()
    if not win then return end

    local screen = win:screen()
    local targetScreen = screen:toWest()

    -- If there's no display to the left, do nothing
    if not targetScreen then return end

    -- Move window to target screen and maximize it
    local frame = targetScreen:frame()
    win:setFrame(frame)
end

--- Moves window to the display on the right (east)
function M.moveToRightDisplay()
    local win = getFocusedWindow()
    if not win then return end

    local screen = win:screen()
    local targetScreen = screen:toEast()

    -- If there's no display to the right, do nothing
    if not targetScreen then return end

    -- Move window to target screen and maximize it
    local frame = targetScreen:frame()
    win:setFrame(frame)
end

--- Binds all window management hotkeys
-- @param modifiers table Array of modifier keys (e.g., {"cmd", "alt"})
function M.bindHotkeys(modifiers)
    hs.hotkey.bind(modifiers, "left", M.moveToLeft)
    hs.hotkey.bind(modifiers, "right", M.moveToRight)
    hs.hotkey.bind(modifiers, "up", M.maximize)
    hs.hotkey.bind(modifiers, "down", M.center)
end

--- Binds multi-display hotkeys for moving windows between screens
-- @param modifiers table Array of modifier keys (e.g., {"cmd", "alt", "ctrl"})
function M.bindMultiDisplayHotkeys(modifiers)
    hs.hotkey.bind(modifiers, "left", M.moveToLeftDisplay)
    hs.hotkey.bind(modifiers, "right", M.moveToRightDisplay)
end

return M
