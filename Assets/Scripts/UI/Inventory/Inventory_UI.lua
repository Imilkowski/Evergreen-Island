--!Type(UI)

--!Bind
local _Title: UILabel = nil
--!Bind
local _ItemName: UILabel = nil
--!Bind
local _ItemLocations: UILabel = nil

function self:Awake()
    SetTexts()
end

function SetTexts()
    _Title:SetPrelocalizedText("Inventory")
    _ItemName:SetPrelocalizedText("Oak Wood")
    _ItemLocations:SetPrelocalizedText("Lushful Forest, Sunny Shore")
end