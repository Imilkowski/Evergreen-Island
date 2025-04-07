--!Type(Module)

--!SerializeField
local locations : { string } = {}

--!SerializeField
local seasons : { string } = {}

--!SerializeField
local items : { Item } = {}

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