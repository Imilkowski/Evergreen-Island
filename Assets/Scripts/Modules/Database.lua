--!Type(Module)

--!SerializeField
local locations : { string } = {}

--!SerializeField
local seasonIcons : { Texture } = {}
--!SerializeField
local seasonColors : { Color } = {}

local seasons = {}

--!SerializeField
local itemsResources : { Item } = {}
--!SerializeField
local itemsFarming : { Item } = {}
--!SerializeField
local itemsFishing : { Item } = {}

--!SerializeField
local toolIcons : { Texture } = {}
local tools = {}

function self:ClientAwake()
    seasons = {
        {id = 1, name = "Spring", icon = seasonIcons[1], color = seasonColors[1]},
        {id = 2, name = "Summer", icon = seasonIcons[2], color = seasonColors[2]},
        {id = 3, name = "Autumn", icon = seasonIcons[3], color = seasonColors[3]},
        {id = 4, name = "Winter", icon = seasonIcons[4], color = seasonColors[4]}
    }

    tools = {
        {name = "Axe", icon = toolIcons[1]},
        {name = "Pickaxe", icon = toolIcons[2]},
        {name = "Shovel", icon = toolIcons[3]},
    }
end

function GetItem(itemName)
    for i, item in ipairs(itemsResources) do
        if(item.GetName()  == itemName) then 
            return item
        end
    end

    for i, item in ipairs(itemsFarming) do
        if(item.GetName()  == itemName) then 
            return item
        end
    end

    for i, item in ipairs(itemsFishing) do
        if(item.GetName()  == itemName) then 
            return item
        end
    end
end

function GetItems(type)
    if(type == "Resources") then
        return itemsResources
    end

    if(type == "Farming") then
        return itemsFarming
    end

    if(type == "Fishing") then
        return itemsFishing
    end
end

function GetLocations()
    return locations
end

function GetLocation(id)
    return locations[id]
end

function GetSeason(id)
    return seasons[id]
end

function GetToolIcon(name)
    for i, v in ipairs(tools) do
        if(v.name  == name) then 
            return v.icon
        end
    end
end

function GetTools()
    return tools
end