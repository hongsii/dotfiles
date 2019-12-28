-- Based on https://github.com/johngrib/hammerspoon-config/blob/master/modules/inputsource_aurora.lua

local boxes = {}
local inputEnglish = "com.apple.keylayout.ABC"
local box_height = 23.3
local default_color = { hex = "#EC0000", alpha = 0.4 }

-- 입력소스 변경 이벤트에 이벤트 리스너를 달아준다
hs.keycodes.inputSourceChanged(function()
    disable_show()
    if hs.keycodes.currentSourceID() ~= inputEnglish then
        enable_show()
    end
end)

function enable_show()
    reset_boxes()
    hs.fnutils.each(hs.screen.allScreens(), function(scr)
        local frame = scr:fullFrame()

        -- top
        draw_rectangle(frame.x, 0, frame.w, box_height, default_color)

        -- bottom
        -- draw_rectangle(frame.x, frame.h - 10, frame.w, box_height, default_color)
    end)
end

function disable_show()
    hs.fnutils.each(boxes, function(box)
        if box ~= nil then
            box:delete()
        end
    end)
    reset_boxes()
end

function newBox()
    return hs.drawing.rectangle(hs.geometry.rect(0,0,0,0))
end

function reset_boxes()
    boxes = {}
end

function draw_rectangle(x, y, width, height, color)
  local box = newBox()
  table.insert(boxes, box)

  -- 그릴 영역 크기를 잡는다
  box:setSize(hs.geometry.rect(x, y, width, height))
  -- 그릴 영역의 위치를 잡는다
  box:setTopLeft(hs.geometry.point(x, y))

  -- box:setAlpha(color.alpha)
  box:setFillColor(color)
  box:setFill(true)
  box:setLevel(hs.drawing.windowLevels.overlay)
  box:setStroke(false)
  box:setBehavior(hs.drawing.windowBehaviors.canJoinAllSpaces)
  box:show()
end
