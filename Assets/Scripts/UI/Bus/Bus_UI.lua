--!Type(UI)

local UIManagerModule = require("UIManagerModule")
local Database = require("Database")
local SessionModule = require("SessionModule")

--!Bind
local _CloseButton: VisualElement = nil
--!Bind
local _Title: UILabel = nil

--!Bind
local _Buttons: VisualElement = nil

function self:Awake()
    SetTexts()
end

function SetTexts()
    _Title:SetPrelocalizedText("Travel")
end

function CreateButtonsList()
    _Buttons:Clear()

    local locations = Database.GetLocations()

    for i, v in ipairs(locations) do
        local _button = VisualElement.new();
        _button:AddToClassList("travel-button")
        _Buttons:Add(_button)

        local _travelIcon = Image.new();
        _travelIcon:AddToClassList("travel-icon")
        _button:Add(_travelIcon)

        local _destinationLabel = UILabel.new();
        _destinationLabel:AddToClassList("text-normal")
        _destinationLabel:SetPrelocalizedText(v)
        _button:Add(_destinationLabel)

        -- Register a callback for when the button is pressed
        _button:RegisterPressCallback(function()
            SessionModule.TransportPlayer(i)
            UIManagerModule.ClosePanel(self)
        end)
    end
end

-- Register a callback for when the button is pressed
_CloseButton:RegisterPressCallback(function()
    UIManagerModule.ClosePanel(self)
end)