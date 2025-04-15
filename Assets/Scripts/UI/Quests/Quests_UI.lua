--!Type(UI)

local UIManagerModule = require("UIManagerModule")
local SaveModule = require("SaveModule")
local QuestsManagerModule = require("QuestsManagerModule")

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
local _QuestContent: VisualElement = nil

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

function UpdateQuestInfo(generalInfo)
    quest, questNumber = QuestsManagerModule.GetQuest(questsType)
    print(quest.GetDescription())

    _QuestContent:Clear()

    local _questContainer = VisualElement.new();
    _questContainer:AddToClassList("quest-container")
    _QuestContent:Add(_questContainer)

    local _questHeader = VisualElement.new();
    _questHeader:AddToClassList("quest-header")
    _questContainer:Add(_questHeader)

    -- header
    local _questIcon = Image.new();
    _questIcon:AddToClassList("quest-icon")
    _questHeader:Add(_questIcon)

    local _questTitle = UILabel.new();
    _questTitle:AddToClassList("text-header")
    _questTitle:SetPrelocalizedText("Quest " .. questNumber)
    _questHeader:Add(_questTitle)

    local _experienceContainer = VisualElement.new();
    _experienceContainer:AddToClassList("experience-right")
    _questHeader:Add(_experienceContainer)

    local _expIcon = Image.new();
    _expIcon:AddToClassList("exp-icon")
    _experienceContainer:Add(_expIcon)

    local _experienceCount = UILabel.new();
    _experienceCount:AddToClassList("text-header-leveled")
    _experienceCount:SetPrelocalizedText(quest.GetExpReward())
    _experienceContainer:Add(_experienceCount)
    --

    local _questDetails = VisualElement.new();
    _questDetails:AddToClassList("quest-details")
    _questContainer:Add(_questDetails)

    -- quest details
    local _requirementsText = UILabel.new();
    _requirementsText:AddToClassList("text-header")
    _requirementsText:SetPrelocalizedText("Bring: ")
    _questDetails:Add(_requirementsText)

    -- local _itemFrame = VisualElement.new();
    -- _itemFrame:AddToClassList("item-frame")
    -- _questDetails:Add(_itemFrame)
    --

    local _questDetails_2 = VisualElement.new();
    _questDetails_2:AddToClassList("quest-details")
    _questContainer:Add(_questDetails_2)

    -- quest details 2
    local _rewardsText = UILabel.new();
    _rewardsText:AddToClassList("text-header")
    _rewardsText:SetPrelocalizedText("Reward: ")
    _questDetails_2:Add(_rewardsText)
    --

    local _questDescription = UILabel.new();
    _questDescription:AddToClassList("text-normal")
    _questDescription:AddToClassList("quest-description")
    _questDescription:SetPrelocalizedText(quest.GetDescription())
    _questContainer:Add(_questDescription)
end

-- Register a callback for when the button is pressed
_CloseButton:RegisterPressCallback(function()
    UIManagerModule.ClosePanel(self)
end)