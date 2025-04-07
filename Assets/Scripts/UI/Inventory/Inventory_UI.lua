--!Type(UI)

local UIManagerModule = require("UIManagerModule")
local SaveModule = require("SaveModule")
local Database = require("Database")

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

function self:Awake()
    SetTexts()
end

function SetTexts()
    _Title:SetPrelocalizedText("Inventory")
    _ItemName:SetPrelocalizedText("Oak Wood")
    _ItemLocations:SetPrelocalizedText("Lushful Forest, Sunny Shore")
end

function UpdateItemsList(items)
    ClearItemDetails();

    _ItemsParent:Clear()

    slotsNum = SaveModule.GetInventorySize();

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

        slotsNum -= 1;

        -- Register a callback for when the button is pressed
        _itemFrame:RegisterPressCallback(function()
            SetItemDetails(Database.GetItem(k))
        end)
    end

    for i = 1, slotsNum do
        local _itemFrame = VisualElement.new();
        _itemFrame:AddToClassList("item-frame")
        _ItemsParent:Add(_itemFrame)
    end
end

function SetItemDetails(item:Item)
    _ItemName:SetPrelocalizedText(item.GetName());

    locationsText = "";

    first = true
    for i, v in ipairs(item.GetLocations()) do
        if(v) then
            if(first) then
                locationsText = locationsText .. Database.GetLocation(i)
                first = false
            else
                locationsText = locationsText .. ", " .. Database.GetLocation(i)
            end
        end
    end

    _ItemLocations:SetPrelocalizedText(locationsText);
end

function ClearItemDetails()
    _ItemName:SetPrelocalizedText("");
    _ItemLocations:SetPrelocalizedText("");
end

-- Register a callback for when the button is pressed
_CloseButton:RegisterPressCallback(function()
    UIManagerModule.ShowInventory(false)
end)