--!Type(UI)

local UIManagerModule = require("UIManagerModule")
local SaveModule = require("SaveModule")
local Database = require("Database")

--!Bind
local _Title: UILabel = nil
--!Bind
local _Tip: UILabel = nil
--!Bind
local _ItemName: UILabel = nil
--!Bind
local _ItemLocations: UILabel = nil

--!Bind
local _CloseButton: VisualElement = nil

--!Bind
local _ItemsParent: VisualElement = nil
--!Bind
local _ItemSeasons: VisualElement = nil

local itemsType = "Resources"

function self:Awake()
    SetTexts()
end

function SetTexts()
    _Title:SetPrelocalizedText("Items Journal")
    _Tip:SetPrelocalizedText("Visit Museum to donate items")
end

function GetDiscoveredItems(discoveredItems)
    matchedItems = {}

    items = Database.GetItems(itemsType)

    for i, v in ipairs(items) do
        for i, dv in ipairs(discoveredItems) do
            if(v.GetName() == dv) then
                table.insert(matchedItems, v)
            end
        end
    end

    return matchedItems
end

function UpdateItemsList(discoveredItems)
    items = GetDiscoveredItems(discoveredItems)
    ClearItemDetails()

    _ItemsParent:Clear()

    for i, v in ipairs(items) do
        local _itemFrame = VisualElement.new();
        _itemFrame:AddToClassList("item-frame")
        _ItemsParent:Add(_itemFrame)

        local _itemIcon = Image.new();
        _itemIcon:AddToClassList("item-icon")
        _itemIcon.image = v.GetIcon();
        _itemFrame:Add(_itemIcon)

        -- Register a callback for when the button is pressed
        _itemFrame:RegisterPressCallback(function()
            SetItemDetails(v)
        end)
    end
end

function SetItemDetails(item:Item)
    _ItemName:SetPrelocalizedText(item.GetName());

    locationsText = "";

    first = true
    for i, v in ipairs(item.GetLocations()) do
        if(v) then
            if(first) then
                locationsText = locationsText .. Database.GetLocation(i + 1)
                first = false
            else
                locationsText = locationsText .. ", " .. Database.GetLocation(i + 1)
            end
        end
    end

    _ItemLocations:SetPrelocalizedText(locationsText);

    _ItemSeasons:Clear()

    for i, v in ipairs(item.GetSeasons()) do
        if(v) then
            local _seasonIcon = Image.new();
            _seasonIcon:AddToClassList("season-icon")
            _seasonIcon.image = Database.GetSeason(i).icon
            _ItemSeasons:Add(_seasonIcon)
        end
    end
end

function ClearItemDetails()
    _ItemName:SetPrelocalizedText("");
    _ItemLocations:SetPrelocalizedText("");
    _ItemSeasons:Clear()
end

-- Register a callback for when the button is pressed
_CloseButton:RegisterPressCallback(function()
    UIManagerModule.ClosePanel(self)
end)