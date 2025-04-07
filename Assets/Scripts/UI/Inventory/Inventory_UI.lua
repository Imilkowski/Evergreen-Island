--!Type(UI)

local UIManagerModule = require("UIManagerModule")

--!Bind
local _Title: UILabel = nil
--!Bind
local _ItemName: UILabel = nil
--!Bind
local _ItemLocations: UILabel = nil

--!Bind
local _CloseButton: VisualElement = nil

function self:Awake()
    SetTexts()
end

function SetTexts()
    _Title:SetPrelocalizedText("Inventory")
    _ItemName:SetPrelocalizedText("Oak Wood")
    _ItemLocations:SetPrelocalizedText("Lushful Forest, Sunny Shore")
end

-- Register a callback for when the button is pressed
_CloseButton:RegisterPressCallback(function()
    UIManagerModule.ShowInventory(false)
end)