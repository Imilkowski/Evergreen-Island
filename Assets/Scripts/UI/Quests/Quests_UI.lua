--!Type(UI)

local UIManagerModule = require("UIManagerModule")
local SaveModule = require("SaveModule")
local Database = require("Database")

--!Bind
local _Title: UILabel = nil
--!Bind
local _CollectRewards: UILabel = nil
--!Bind
local _RewardsValue: UILabel = nil
--!Bind
local _Level: UILabel = nil
--!Bind
local _Experience: UILabel = nil

--!Bind
local _ProgressBar: VisualElement = nil

--!Bind
local _CloseButton: VisualElement = nil

local questsType = "General"

function self:Awake()
    SetTexts()
end

function SetTexts()
    _Title:SetPrelocalizedText("Quests")
    _CollectRewards:SetPrelocalizedText("Collect level up rewards:")
    _RewardsValue:SetPrelocalizedText("250")
    _Level:SetPrelocalizedText("12")
    _Experience:SetPrelocalizedText("300/400")
end

-- Register a callback for when the button is pressed
_CloseButton:RegisterPressCallback(function()
    UIManagerModule.ClosePanel(self)
end)