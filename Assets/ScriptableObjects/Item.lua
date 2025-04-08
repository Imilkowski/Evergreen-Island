--!Type(ScriptableObject)

--!SerializeField
local itemName : string = ""
--!SerializeField
local itemIcon : Texture = nil
--!SerializeField
local itemType : string = ""
--!SerializeField
local seasons : { boolean } = {}
--!SerializeField
local locations : { boolean } = {}

function GetName()
    return itemName
end

function GetIcon()
    return itemIcon
end

function GetSeasons()
    return seasons
end

function GetLocations()
    return locations
end