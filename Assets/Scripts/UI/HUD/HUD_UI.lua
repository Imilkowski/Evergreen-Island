--!Type(UI)

local UIManagerModule = require("UIManagerModule")

--!Bind
local _InventoryButton: VisualElement = nil
--!Bind
local _TravelButton: VisualElement = nil
--!Bind
local _LibraryButton: VisualElement = nil

--!Bind
local _SeasonName: UILabel = nil
--!Bind
local _SeasonIcon: Image = nil
--!Bind
local _SeasonProgress: VisualElement = nil

function UpdateSeasonInfo(season, seasonProgress)
    _SeasonName:SetPrelocalizedText(season.name)
    _SeasonIcon.image = season.icon
    _SeasonProgress.style.backgroundColor = season.color
    _SeasonProgress.style.width = seasonProgress * 100
end

-- Register a callback for when the button is pressed
_InventoryButton:RegisterPressCallback(function()
    UIManagerModule.ShowInventory()
end)

-- Register a callback for when the button is pressed
_TravelButton:RegisterPressCallback(function()
    UIManagerModule.ShowBus()
end)

-- Register a callback for when the button is pressed
_LibraryButton:RegisterPressCallback(function()
    UIManagerModule.ShowLibrary()
end)