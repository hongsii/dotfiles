-- Declare prefix key
local prefix = {"shift", "option", "ctrl"}

-- Declare class
local App = {}
local appTables = { __index = App }
function App:new(key, name, displayName)
    return setmetatable({ key = key, name = name, displayName = displayName or name }, appTables)
end

local apps = {
  App:new("c", "Google Chrome", "Chrome"),
  App:new("i", "IntelliJ IDEA"),
  App:new("l", "Calendar"),
  App:new("f", "Finder"),
  App:new("t", "iTerm 2", "iTerm2"),
  App:new("w", "카카오워크", "카카오워크"),
  App:new("k", "KakaoTalk", "카카오톡"),
  App:new("m", "MySQLWorkbench"), 
  App:new("n", "Notion"), 
  App:new("s", "Slack"), 
  App:new("v", "VMware Horizon Client"), 
  App:new(",", "System Preferences", "시스템 환경설정")
}

local function toggleApplication(name, displayName)
  local currentApp = hs.application.frontmostApplication()
  if currentApp:name() ~= displayName then
    hs.application.launchOrFocus(name)
  else
    currentApp:hide()
  end
end

local function bindShortCut()
  for key, app in pairs(apps) do
    hs.hotkey.bind(prefix, app.key, function() toggleApplication(app.name, app.displayName) end)
  end
end

bindShortCut()
