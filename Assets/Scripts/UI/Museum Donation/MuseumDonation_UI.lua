--!Type(UI)

local UIManagerModule = require("UIManagerModule")
local SaveModule = require("SaveModule")
local Database = require("Database")

--!Bind
local _Title: UILabel = nil
--!Bind
local _DonateLabel: UILabel = nil

--!Bind
local _CloseButton: VisualElement = nil
--!Bind
local _DonateButton: VisualElement = nil

--!Bind
local _ItemsParent: VisualElement = nil

local selectedItem = nil

function self:Awake()
    SetTexts()
end

function SetTexts()
    _Title:SetPrelocalizedText("Museum Donations")
    _DonateLabel:SetPrelocalizedText("Donate")
end

function DesactivateDonateButton()
    _DonateLabel:SetPrelocalizedText("Donate")
    _DonateButton:RemoveFromClassList("active-button")
    _DonateButton:AddToClassList("inactive-button")
end

function GetMatch(inventoryItem:string, discoveredItems)
    for i, dv in ipairs(discoveredItems) do
        if(inventoryItem == dv) then
            return true
        end
    end

    return false
end

function GetDiscoveredItems(inventoryItems)
    unmatchedItems = {}

    discoveredItems = SaveModule.GetDiscoveredItems()

    for k, v in pairs(inventoryItems) do
        matched = GetMatch(k, discoveredItems)
        if(not matched) then
            unmatchedItems[k] = v
        end
    end

    return unmatchedItems
end

function UpdateItemsList(inventoryItems)
    _ItemsParent:Clear()
    DesactivateDonateButton()
    selectedItem = nil

    items = GetDiscoveredItems(inventoryItems)

    for k, v in pairs(items) do
        local _itemFrame = VisualElement.new();
        _itemFrame:AddToClassList("item-frame")
        _ItemsParent:Add(_itemFrame)

        local _itemIcon = Image.new();
        _itemIcon:AddToClassList("item-icon")
        _itemIcon.image = Database.GetItem(k).GetIcon();
        _itemFrame:Add(_itemIcon)

        local _countLabel = UILabel.new()
        _countLabel:AddToClassList("item-count-label")
        _countLabel:AddToClassList("text-title")
        _countLabel:SetPrelocalizedText(v)
        _itemFrame:Add(_countLabel)

        -- Register a callback for when the button is pressed
        _itemFrame:RegisterPressCallback(function()
            selectedItem = k
            ChangeDonateButton()
        end)
    end
end

function ChangeDonateButton()
    _DonateLabel:SetPrelocalizedText("Donate " .. selectedItem)
    _DonateButton:RemoveFromClassList("inactive-button")
    _DonateButton:AddToClassList("active-button")
end

-- Register a callback for when the button is pressed
_CloseButton:RegisterPressCallback(function()
    UIManagerModule.ClosePanel(self)
end)

-- Register a callback for when the button is pressed
_DonateButton:RegisterPressCallback(function()
    if(selectedItem == nil) then return end

    SaveModule.ChangeInventoryItem(selectedItem, -1)
    SaveModule.AddDiscoveredItem(selectedItem)

    print("Donated " .. selectedItem)

    UpdateItemsList(SaveModule.players_storage[client.localPlayer].inventory)
end)
