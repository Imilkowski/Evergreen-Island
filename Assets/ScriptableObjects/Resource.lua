--!Type(ScriptableObject)

--!SerializeField
local tool : string = ""
--!SerializeField
local toolLevel : number = 0
--!SerializeField
local items : { Item } = nil
--!SerializeField
local itemsCount : { number } = nil

function GetTool()
    return tool
end

function GetToolLevel()
    return toolLevel
end

function GetItems()
    return items, itemsCount
end