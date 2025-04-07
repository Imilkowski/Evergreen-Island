--!Type(UI)

local UIManagerModule = require("UIManagerModule")
local SaveModule = require("SaveModule")

--!Bind
local _Title: UILabel = nil
--!Bind
local _ItemName: UILabel = nil
--!Bind
local _ItemLocations: UILabel = nil

--!Bind
local _CloseButton: VisualElement = nil

--!Bind
local _ItemsParent: VisualElement = nil

--!SerializeField
local placeholderIcon : Texture = nil

function self:Awake()
    SetTexts()
end

function SetTexts()
    _Title:SetPrelocalizedText("Inventory")
    _ItemName:SetPrelocalizedText("Oak Wood")
    _ItemLocations:SetPrelocalizedText("Lushful Forest, Sunny Shore")
end

function UpdateItemsList(items)
    _ItemsParent:Clear()

    slotsNum = SaveModule.GetInventorySize();

    for k, v in pairs(items) do
        local _itemFrame = VisualElement.new();
        _itemFrame:AddToClassList("item-frame")
        _ItemsParent:Add(_itemFrame)

        local _itemIcon = Image.new();
        _itemIcon:AddToClassList("item-icon")
        _itemIcon.image = placeholderIcon;
        _itemFrame:Add(_itemIcon)

        local _countLabel = UILabel.new()
        _countLabel:AddToClassList("item-count-label")
        _countLabel:AddToClassList("text-title")
        _countLabel:SetPrelocalizedText(v)
        _itemFrame:Add(_countLabel)

        slotsNum -= 1;
    end

    for i = 1, slotsNum do
        local _itemFrame = VisualElement.new();
        _itemFrame:AddToClassList("item-frame")
        _ItemsParent:Add(_itemFrame)
    end
end

-- Register a callback for when the button is pressed
_CloseButton:RegisterPressCallback(function()
    UIManagerModule.ShowInventory(false)
end)