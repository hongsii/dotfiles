-- Based on https://github.com/johngrib/hammerspoon-config/blob/master/modules/inputsource_aurora.lua

-- Input source
local source_english = "com.apple.keylayout.ABC"

-- Aurora configuration
local boxes = {}
local box_height = 23.3
local box_color = { hex = "#00FF00", alpha = 0.3 }

-- 한/영 전환 이벤트
-- hs.keycodes.inputSourceChanged(function()
    -- showAurora(hs.window.frontmostWindow())
-- end)

function showAurora(window)
    if window == nil then
        return
    end

    removeBoxes()
    if hs.keycodes.currentSourceID() ~= source_english then
        local frame = window:screen():fullFrame()
        if window:isFullScreen() then
            drawBox(frame.x, frame.y, box_height, box_height, box_color)
        else
            drawBox(frame.x, frame.y, frame.w, box_height, box_color)
        end
    end
end

function removeBoxes()
    hs.fnutils.each(boxes, function(box)
        if box ~= nil then
            box:delete()
        end
    end)
    resetBoxes()
end

function drawBoxesOnAllScreens()
    hs.fnutils.each(hs.screen.allScreens(), function(scr)
        local frame = scr:fullFrame()

        -- top
        drawBox(frame.x, frame.y, frame.w, box_height, box_color)
    end)
end

function drawBox(x, y, width, height, color)
    local box = hs.drawing.rectangle(hs.geometry.rect(0,0,0,0))
    table.insert(boxes, box)

    box:setSize(hs.geometry.rect(x, y, width, height))
    box:setTopLeft(hs.geometry.point(x, y))

    -- box:setAlpha(color.alpha)
    box:setFillColor(color)
    box:setFill(true)
    box:setLevel(hs.drawing.windowLevels.overlay)
    box:setStroke(false)
    box:setBehavior(hs.drawing.windowBehaviors.canJoinAllSpaces)
    box:show()
end

function resetBoxes()
    boxes = {}
end
