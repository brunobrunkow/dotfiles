-- window-management.lua
-- Module for window positioning and sizing with hotkeys

local M = {}

--------------------------------------------------------------------------------
-- Helpers
--------------------------------------------------------------------------------

--- Executes a callback with the focused window and its screen frame
-- @param callback function(win, frame) Called with window and screen frame
local function withWindow(callback)
    local win = hs.window.focusedWindow()
    if not win then return end
    callback(win, win:screen():frame())
end

--- Moves window to a position defined by ratios of screen dimensions
-- @param xRatio number X position as ratio (0 = left edge, 0.5 = center)
-- @param yRatio number Y position as ratio (0 = top edge, 0.5 = center)
-- @param wRatio number Width as ratio of screen width
-- @param hRatio number Height as ratio of screen height
local function moveToPosition(xRatio, yRatio, wRatio, hRatio)
    withWindow(function(win, frame)
        win:setFrame({
            x = frame.x + (frame.w * xRatio),
            y = frame.y + (frame.h * yRatio),
            w = frame.w * wRatio,
            h = frame.h * hRatio
        })
    end)
end

--- Generic focus function for directional window focus
-- @param direction string One of: "West", "East", "North", "South"
local function focusDirection(direction)
    withWindow(function(win)
        win["focusWindow" .. direction](win, nil, true, true)
    end)
end

--- Generic swap function for swapping windows in a direction
-- @param direction string One of: "West", "East", "North", "South"
local function swapDirection(direction)
    withWindow(function(win)
        local targets = win["windowsTo" .. direction](win, nil, true, true)
        local targetWin = targets[1]
        if not targetWin then return end

        local winFrame = win:frame()
        local targetFrame = targetWin:frame()
        win:setFrame(targetFrame)
        targetWin:setFrame(winFrame)
    end)
end

--- Moves window to another display
-- @param direction string "West" or "East"
local function moveToDisplay(direction)
    withWindow(function(win)
        local targetScreen = win:screen()["to" .. direction](win:screen())
        if targetScreen then
            win:setFrame(targetScreen:frame())
        end
    end)
end

--------------------------------------------------------------------------------
-- Window Positioning
--------------------------------------------------------------------------------

function M.moveToLeft()       moveToPosition(0, 0, 0.5, 1) end
function M.moveToRight()      moveToPosition(0.5, 0, 0.5, 1) end
function M.maximize()         moveToPosition(0, 0, 1, 1) end
function M.moveToTopLeft()    moveToPosition(0, 0, 0.5, 0.5) end
function M.moveToTopRight()   moveToPosition(0.5, 0, 0.5, 0.5) end
function M.moveToBottomLeft() moveToPosition(0, 0.5, 0.5, 0.5) end
function M.moveToBottomRight() moveToPosition(0.5, 0.5, 0.5, 0.5) end

function M.center()
    withWindow(function(win, frame)
        local w, h = frame.w * 0.7, frame.h * 0.7
        win:setFrame({
            x = frame.x + (frame.w - w) / 2,
            y = frame.y + (frame.h - h) / 2,
            w = w, h = h
        })
    end)
end

--------------------------------------------------------------------------------
-- Focus Navigation
--------------------------------------------------------------------------------

function M.focusWindowLeft()  focusDirection("West") end
function M.focusWindowRight() focusDirection("East") end
function M.focusWindowUp()    focusDirection("North") end
function M.focusWindowDown()  focusDirection("South") end

--------------------------------------------------------------------------------
-- Window Swapping
--------------------------------------------------------------------------------

function M.swapWindowLeft()  swapDirection("West") end
function M.swapWindowRight() swapDirection("East") end
function M.swapWindowUp()    swapDirection("North") end
function M.swapWindowDown()  swapDirection("South") end

--------------------------------------------------------------------------------
-- Multi-Display
--------------------------------------------------------------------------------

function M.moveToLeftDisplay()  moveToDisplay("West") end
function M.moveToRightDisplay() moveToDisplay("East") end

--------------------------------------------------------------------------------
-- Hotkey Bindings
--------------------------------------------------------------------------------

function M.bindHotkeys(modifiers)
    hs.hotkey.bind(modifiers, "left", M.moveToLeft)
    hs.hotkey.bind(modifiers, "right", M.moveToRight)
    hs.hotkey.bind(modifiers, "up", M.maximize)
    hs.hotkey.bind(modifiers, "down", M.center)
end

function M.bindQuarterScreenHotkeys(modifiers)
    hs.hotkey.bind(modifiers, "u", M.moveToTopLeft)
    hs.hotkey.bind(modifiers, "i", M.moveToTopRight)
    hs.hotkey.bind(modifiers, "n", M.moveToBottomLeft)
    hs.hotkey.bind(modifiers, "m", M.moveToBottomRight)
end

function M.bindVimFocusHotkeys(modifiers)
    hs.hotkey.bind(modifiers, "k", M.focusWindowLeft)
    hs.hotkey.bind(modifiers, "o", M.focusWindowUp)
    hs.hotkey.bind(modifiers, "l", M.focusWindowDown)
    hs.hotkey.bind(modifiers, "ö", M.focusWindowRight)
end

function M.bindMultiDisplayHotkeys(modifiers)
    hs.hotkey.bind(modifiers, "left", M.moveToLeftDisplay)
    hs.hotkey.bind(modifiers, "right", M.moveToRightDisplay)
end

function M.bindWindowSwapHotkeys(modifiers)
    hs.hotkey.bind(modifiers, "k", M.swapWindowLeft)
    hs.hotkey.bind(modifiers, "o", M.swapWindowUp)
    hs.hotkey.bind(modifiers, "l", M.swapWindowDown)
    hs.hotkey.bind(modifiers, "ö", M.swapWindowRight)
end

return M
