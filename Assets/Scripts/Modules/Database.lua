--!Type(Module)

--!SerializeField
local locations : { string } = {}

--!SerializeField
local seasonIcons : { Texture } = {}
--!SerializeField
local seasonColors : { Color } = {}

local seasons = {}

--!SerializeField
local items : { Item } = {}

function self:Awake()
    seasons = {
        {name = "Spring", icon = seasonIcons[1], color = seasonColors[1]},
        {name = "Summer", icon = seasonIcons[2], color = seasonColors[2]},
        {name = "Autumn", icon = seasonIcons[3], color = seasonColors[3]},
        {name = "Winter", icon = seasonIcons[4], color = seasonColors[4]}
    }
end

function GetItem(itemName)
    for i, item in ipairs(items) do
        if(item.GetName()  == itemName) then 
            return item
        end
    end
end

function GetLocation(id)
    return locations[id]
end

function GetSeason(id)
    return seasons[id]
end