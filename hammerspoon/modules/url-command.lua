-- url-command.lua
-- Module for running terminal commands with clipboard URL

local M = {}

--- Runs a command in Ghostty with the clipboard contents
-- @param commandTemplate string Command template where %s is replaced with clipboard
function M.runInGhostty(commandTemplate)
    local clipboard = hs.pasteboard.getContents() or ""
    local command = string.format(commandTemplate, clipboard)

    local ghostty = hs.application.find("Ghostty")

    local function typeAndExecute()
        hs.eventtap.keyStrokes(command)
        hs.eventtap.keyStroke({}, "return")
    end

    if ghostty then
        ghostty:activate()
        hs.timer.doAfter(0.1, function()
            hs.eventtap.keyStroke({"cmd"}, "t")  -- new tab
            hs.timer.doAfter(0.2, typeAndExecute)
        end)
    else
        hs.application.launchOrFocus("Ghostty")
        hs.timer.doAfter(0.5, typeAndExecute)
    end
end

--- Binds a hotkey to run a command with clipboard URL
-- @param modifiers table Array of modifier keys
-- @param key string The key to bind
-- @param commandTemplate string Command template (%s = clipboard)
function M.bindHotkey(modifiers, key, commandTemplate)
    hs.hotkey.bind(modifiers, key, function()
        M.runInGhostty(commandTemplate)
    end)
end

return M
