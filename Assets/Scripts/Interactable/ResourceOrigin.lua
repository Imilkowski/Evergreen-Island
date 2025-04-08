--!Type(Client)

local SaveModule = require("SaveModule")
local SessionModule = require("SessionModule")

--!SerializeField
local resources : { Resource } = {}

function GetCurrentTool()
    tool = SessionModule.GetCurrentTool()
    toolsOwned = SaveModule.GetTools()

    toolLevel = 0
    for k, v in pairs(toolsOwned) do
        if(k == tool) then
            toolLevel = v
        end
    end

    return tool, toolLevel
end

function FindMatchingResources(tool, toolLevel)
    items = {}
    itemsCount = {}
    itemsFound = false
    
    for i, v in ipairs(resources) do
        if(v.GetTool() == tool) then
            if(v.GetToolLevel() == toolLevel) then
                items, itemsCount = v.GetItems()
                itemsFound = true
            end
        end
    end

    if(itemsFound) then
        return items, itemsCount
    end

    --if not found, check if a tool with lower level is needed
    for i, v in ipairs(resources) do
        if(v.GetTool() == tool) then
            if(v.GetToolLevel() < toolLevel) then
                items, itemsCount = v.GetItems()
                itemsFound = true
            end
        end
    end

    if(itemsFound) then
        return items, itemsCount
    end

    --if not found, check if no tool is needed
    for i, v in ipairs(resources) do
        if(v.GetTool() == "") then
            items, itemsCount = v.GetItems()
            itemsFound = true
        end
    end

    if(itemsFound) then
        return items, itemsCount
    else
        return nil
    end
end

-- Connect to the Tapped event
self.gameObject:GetComponent(TapHandler).Tapped:Connect(function()
    tool, toolLevel = GetCurrentTool()
    items, itemsCount = FindMatchingResources(tool, toolLevel)

    if(items == nil) then
        --print("Can't get resources with the current tool")
        return
    end

    seasonId = SessionModule.GetCurrentSeasonId()
    
    for i, item in ipairs(items) do
        if(item.GetSeasons()[seasonId]) then
            SaveModule.ChangeInventoryItem(true, item.GetName(), itemsCount[i])
        end
    end
end)