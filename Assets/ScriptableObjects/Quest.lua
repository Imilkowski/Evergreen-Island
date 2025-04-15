--!Type(ScriptableObject)

--!SerializeField
local expReward: number = 0;
--!SerializeField
local description: string = ""

--!SerializeField
local itemsRequired: { Item } = {}
--!SerializeField
local itemsCount: { number } = {}

function GetExpReward()
    return expReward
end

function GetDescription()
    return description
end

function GetItemsRequired()
    return itemsRequired, itemsCount
end