--!Type(UI)

local UIManagerModule = require("UIManagerModule")

--!Bind
local _Inventory_Button: VisualElement = nil

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
_Inventory_Button:RegisterPressCallback(function()
    UIManagerModule.ShowInventory(true)
end)