-- Declare prefix key
-- local prefix = {"⇧", "⌥", "⌃"}
local prefix = {"shift", "option", "ctrl"}

function round(value)
    return math.floor(value + 0.5)
end 

hs.hotkey.bind(prefix, '.', hs.hints.windowHints)
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
    local frame = window:frame()
    local screen = window:screen():frame()

    local halfWindowHeight = frame.h / 2
    local isInUpperArea = halfWindowHeight + frame.y < screen.y + (screen.h / 2)
    if isInUpperArea then
        frame.y = screen.y + (screen.h / 2) - halfWindowHeight
    else 
        frame.y = screen.y + (screen.h - frame.h)
    end
    window:setFrameInScreenBounds(frame, 0)
end)

-- resize
local resize_prefix = {"shift", "command", "ctrl"}
hs.grid.MARGINX 	= 0
hs.grid.MARGINY 	= 0
hs.grid.GRIDWIDTH 	= 7
hs.grid.GRIDHEIGHT 	= 6

hs.window.animationDuration = 0
hs.hotkey.bind(resize_prefix, 'UP', hs.grid.resizeWindowShorter)
hs.hotkey.bind(resize_prefix, 'DOWN', hs.grid.resizeWindowTaller)
hs.hotkey.bind(resize_prefix, 'RIGHT', hs.grid.resizeWindowWider)
hs.hotkey.bind(resize_prefix, 'LEFT', hs.grid.resizeWindowThinner)
