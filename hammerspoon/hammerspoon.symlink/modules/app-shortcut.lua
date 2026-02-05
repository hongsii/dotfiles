-- Declare prefix key
local defaultPrefix = {"shift", "option", "ctrl"}

-- Declare class
local App = {}
local appTables = { __index = App }
function App:new(prefix, key, name, displayName)
    return setmetatable({ prefix = prefix, key = key, name = name, displayName = displayName or name }, appTables)
end

local apps = {
  App:new(defaultPrefix, "c", "Google Chrome", "Chrome"),
  App:new(defaultPrefix, "i", "IntelliJ IDEA"),
  App:new(defaultPrefix, "d", "DataGrip"),
  App:new(defaultPrefix, "l", "Calendar"),
  App:new(defaultPrefix, "f", "Finder"),
  App:new(defaultPrefix, "`", "Ghostty"),
  App:new(defaultPrefix, "k", "KakaoTalk", "카카오톡"),
  App:new(defaultPrefix, "n", "Notion"), 
  App:new(defaultPrefix, "s", "Slack"), 
  App:new(defaultPrefix, "v", "VMware Horizon Client"), 
  App:new(defaultPrefix, ",", "System Preferences", "시스템 환경설정"),
  App:new(defaultPrefix, "u", "Visual Studio Code")
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
    hs.hotkey.bind(app.prefix, app.key, function() toggleApplication(app.name, app.displayName) end)
  end
end

bindShortCut()
