-- Declare prefix key
-- local prefix = {"⇧", "⌥", "⌃"}
local prefix = {"shift", "option", "ctrl"}

function round(value)
    return math.floor(value + 0.5)
end 

hs.hints.hintChars = {"Q", "W", "E", "R", "A", "S", "D", "F", "Z", "X", "C", "V"}
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
    local isInUpperArea = halfWindowHeight + frame.y < screen.y + (screen.h / 2) - 1
    if isInUpperArea then
        frame.y = screen.y + (screen.h / 2) - halfWindowHeight
    else 
        frame.y = screen.y + (screen.h - frame.h)
    end
    window:setFrameInScreenBounds(frame, 0)
end)

-- resize
local resize_prefix = {"shift", "command", "ctrl"}
local RESIZE_CONST = 4

function applyResize(size) return size / RESIZE_CONST end
function increaseHeight()
    local win = hs.window.focusedWindow()
    local f = win:frame()
    f.h = f.h + applyResize(f.h)
    win:setFrame(f)
end
function decreaseHeight()
    local win = hs.window.focusedWindow()
    local f = win:frame()
    f.h = f.h - applyResize(f.h)
    win:setFrame(f)
end
function increaseWidth()
    local win = hs.window.focusedWindow()
    local f = win:frame()
    f.w = f.w + applyResize(f.w)
    win:setFrame(f)
end
function decreaseWidth()
    local win = hs.window.focusedWindow()
    local f = win:frame()
    f.w = f.w - applyResize(f.w)
    win:setFrame(f)
end

hs.window.animationDuration = 0
hs.hotkey.bind(resize_prefix, 'UP', decreaseHeight, nil, decreaseHeight)
hs.hotkey.bind(resize_prefix, 'DOWN', increaseHeight, nil, increaseHeight)
hs.hotkey.bind(resize_prefix, 'LEFT', decreaseWidth, nil, decreaseWidth)
hs.hotkey.bind(resize_prefix, 'RIGHT', increaseWidth, nil, increaseWidth)
