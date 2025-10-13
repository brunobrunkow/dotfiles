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

--- Moves and resizes a window to occupy the top-left quarter of the screen
function M.moveToTopLeft()
    local win = getFocusedWindow()
    if not win then return end

    local screen = win:screen()
    local frame = screen:frame()

    win:setFrame({
        x = frame.x,
        y = frame.y,
        w = frame.w / 2,
        h = frame.h / 2
    })
end

--- Moves and resizes a window to occupy the top-right quarter of the screen
function M.moveToTopRight()
    local win = getFocusedWindow()
    if not win then return end

    local screen = win:screen()
    local frame = screen:frame()

    win:setFrame({
        x = frame.x + (frame.w / 2),
        y = frame.y,
        w = frame.w / 2,
        h = frame.h / 2
    })
end

--- Moves and resizes a window to occupy the bottom-left quarter of the screen
function M.moveToBottomLeft()
    local win = getFocusedWindow()
    if not win then return end

    local screen = win:screen()
    local frame = screen:frame()

    win:setFrame({
        x = frame.x,
        y = frame.y + (frame.h / 2),
        w = frame.w / 2,
        h = frame.h / 2
    })
end

--- Moves and resizes a window to occupy the bottom-right quarter of the screen
function M.moveToBottomRight()
    local win = getFocusedWindow()
    if not win then return end

    local screen = win:screen()
    local frame = screen:frame()

    win:setFrame({
        x = frame.x + (frame.w / 2),
        y = frame.y + (frame.h / 2),
        w = frame.w / 2,
        h = frame.h / 2
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

--- Focuses the window to the left of the current window
function M.focusWindowLeft()
    local win = getFocusedWindow()
    if not win then return end

    win:focusWindowWest(nil, true, true)
end

--- Focuses the window below the current window
function M.focusWindowDown()
    local win = getFocusedWindow()
    if not win then return end

    win:focusWindowSouth(nil, true, true)
end

--- Focuses the window above the current window
function M.focusWindowUp()
    local win = getFocusedWindow()
    if not win then return end

    win:focusWindowNorth(nil, true, true)
end

--- Focuses the window to the right of the current window
function M.focusWindowRight()
    local win = getFocusedWindow()
    if not win then return end

    win:focusWindowEast(nil, true, true)
end

--- Swaps the focused window with the window to the left
function M.swapWindowLeft()
    local win = getFocusedWindow()
    if not win then return end

    local targetWin = win:windowsToWest(nil, true, true)[1]
    if not targetWin then return end

    -- Get both window frames
    local winFrame = win:frame()
    local targetFrame = targetWin:frame()

    -- Swap positions
    win:setFrame(targetFrame)
    targetWin:setFrame(winFrame)
end

--- Swaps the focused window with the window below
function M.swapWindowDown()
    local win = getFocusedWindow()
    if not win then return end

    local targetWin = win:windowsToSouth(nil, true, true)[1]
    if not targetWin then return end

    -- Get both window frames
    local winFrame = win:frame()
    local targetFrame = targetWin:frame()

    -- Swap positions
    win:setFrame(targetFrame)
    targetWin:setFrame(winFrame)
end

--- Swaps the focused window with the window above
function M.swapWindowUp()
    local win = getFocusedWindow()
    if not win then return end

    local targetWin = win:windowsToNorth(nil, true, true)[1]
    if not targetWin then return end

    -- Get both window frames
    local winFrame = win:frame()
    local targetFrame = targetWin:frame()

    -- Swap positions
    win:setFrame(targetFrame)
    targetWin:setFrame(winFrame)
end

--- Swaps the focused window with the window to the right
function M.swapWindowRight()
    local win = getFocusedWindow()
    if not win then return end

    local targetWin = win:windowsToEast(nil, true, true)[1]
    if not targetWin then return end

    -- Get both window frames
    local winFrame = win:frame()
    local targetFrame = targetWin:frame()

    -- Swap positions
    win:setFrame(targetFrame)
    targetWin:setFrame(winFrame)
end

--- Binds all window management hotkeys
-- @param modifiers table Array of modifier keys (e.g., {"cmd", "alt"})
function M.bindHotkeys(modifiers)
    hs.hotkey.bind(modifiers, "left", M.moveToLeft)
    hs.hotkey.bind(modifiers, "right", M.moveToRight)
    hs.hotkey.bind(modifiers, "up", M.maximize)
    hs.hotkey.bind(modifiers, "down", M.center)
end

--- Binds quarter-screen positioning hotkeys
-- @param modifiers table Array of modifier keys (e.g., {"cmd", "alt"})
function M.bindQuarterScreenHotkeys(modifiers)
    hs.hotkey.bind(modifiers, "u", M.moveToTopLeft)
    hs.hotkey.bind(modifiers, "i", M.moveToTopRight)
    hs.hotkey.bind(modifiers, "n", M.moveToBottomLeft)
    hs.hotkey.bind(modifiers, "m", M.moveToBottomRight)
end

--- Binds Vim-style window focus navigation hotkeys
-- @param modifiers table Array of modifier keys (e.g., {"cmd", "alt"})
function M.bindVimFocusHotkeys(modifiers)
    hs.hotkey.bind(modifiers, "k", M.focusWindowLeft)
    hs.hotkey.bind(modifiers, "o", M.focusWindowUp)
    hs.hotkey.bind(modifiers, "l", M.focusWindowDown)
    hs.hotkey.bind(modifiers, "ö", M.focusWindowRight)
end

--- Binds multi-display hotkeys for moving windows between screens
-- @param modifiers table Array of modifier keys (e.g., {"cmd", "alt", "ctrl"})
function M.bindMultiDisplayHotkeys(modifiers)
    hs.hotkey.bind(modifiers, "left", M.moveToLeftDisplay)
    hs.hotkey.bind(modifiers, "right", M.moveToRightDisplay)
end

--- Binds window swapping hotkeys
-- @param modifiers table Array of modifier keys (e.g., {"cmd", "alt", "shift"})
function M.bindWindowSwapHotkeys(modifiers)
    hs.hotkey.bind(modifiers, "k", M.swapWindowLeft)
    hs.hotkey.bind(modifiers, "o", M.swapWindowUp)
    hs.hotkey.bind(modifiers, "l", M.swapWindowDown)
    hs.hotkey.bind(modifiers, "ö", M.swapWindowRight)
end

return M
