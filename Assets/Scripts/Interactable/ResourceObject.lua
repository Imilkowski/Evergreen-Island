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
    itemsFound = false
    
    for i, v in ipairs(resources) do
        if(v.GetTool() == tool) then
            if(v.GetToolLevel() == toolLevel) then
                items = v.GetItems()
                itemsFound = true
            end
        end
    end

    if(itemsFound) then
        return items
    end

    --if not found, check if a tool with lower level is needed
    for i, v in ipairs(resources) do
        if(v.GetTool() == tool) then
            if(v.GetToolLevel() < toolLevel) then
                items = v.GetItems()
                itemsFound = true
            end
        end
    end

    if(itemsFound) then
        return items
    end

    --if not found, check if no tool is needed
    for i, v in ipairs(resources) do
        if(v.GetTool() == "") then
            items = v.GetItems()
            itemsFound = true
        end
    end

    if(itemsFound) then
        return items
    else
        return nil
    end
end

-- Connect to the Tapped event
self.gameObject:GetComponent(TapHandler).Tapped:Connect(function()
    tool, toolLevel = GetCurrentTool()
    items = FindMatchingResources(tool, toolLevel)

    if(items == nil) then
        print("Can't get resources with the current tool")
    else
        print("Got items with " .. tool)
    end
    
    --SaveModule.ChangeInventoryItem(true, itemName, 1)
end)