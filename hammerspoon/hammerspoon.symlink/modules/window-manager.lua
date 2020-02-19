-- Declare prefix key
-- local prefix = {"⇧", "⌥", "⌃"}
local prefix = {"shift", "option", "ctrl"}

function round(value)
    return math.floor(value + 0.5)
end 

hs.hotkey.bind(prefix, "left", function()
    local window = hs.window.focusedWindow()
    local frame = window:frame()
    local screen = window:screen():frame()

    local halfWindowWidth = round(frame.w / 2)
    local isInRightArea = frame.x + halfWindowWidth > screen.x + (screen.w / 2)
    if isInRightArea then
        frame.x = screen.x + (screen.w / 2) - halfWindowWidth
    else 
        frame.x = screen.x
    end
    window:setFrameInScreenBounds(frame, 0)
end)

hs.hotkey.bind(prefix, "right", function()
    local window = hs.window.focusedWindow()
    local frame = window:frame()
    local screen = window:screen():frame()

    local halfWindowWidth = round(frame.w / 2)
    local isInLeftArea = frame.x + halfWindowWidth < screen.x + (screen.w / 2)
    if isInLeftArea then
        frame.x = screen.x + (screen.w / 2) - halfWindowWidth
    else 
        frame.x = screen.x + (screen.w - frame.w)
    end
    window:setFrameInScreenBounds(frame, 0)
end)

hs.hotkey.bind(prefix, "up", function()
    local window = hs.window.focusedWindow()
    local frame = window:frame()
    local screen = window:screen():frame()

    local halfWindowHeight = frame.h / 2
    local isInUpperArea = halfWindowHeight + frame.y <= screen.y + (screen.h / 2)
    if isInUpperArea then
        frame.y = screen.y
    else 
        frame.y = screen.y + (screen.h / 2 - frame.h / 2)
    end
    window:setFrameInScreenBounds(frame, 0)
end)

hs.hotkey.bind(prefix, "down", function()
    local window = hs.window.focusedWindow()
    local f = window:frame()
    local screen = window:screen()
    local max = screen:fullFrame() -- except for menubar

    local halfScreenHeight = max.h / 2
    if (f.y == screen:frame().y) then -- include menubar
        f.y = halfScreenHeight - (f.h / 2)
    else
        f.y = max.h
    end
    window:setFrameInScreenBounds(f, 0)
end)
