--!Type(Client)

local SaveModule = require("SaveModule")
local SessionModule = require("SessionModule")
local ResourceManagerModule = require("ResourceManagerModule")
local UIManagerModule = require("UIManagerModule")

--!SerializeField
local uniqueID : number = 0

--!SerializeField
local objectName : string = ""
--!SerializeField
local seasons : { boolean } = {}

--!SerializeField
local resources : { Resource } = {}
--!SerializeField
local renewTime : number = 0

--!SerializeField
local itemParticle: GameObject = nil

local resourceModel : GameObject = nil
local emptyMark : GameObject = nil

local gatheredTime = nil
local tracked = false

function self:Awake()
    resourceModel = self.transform:GetChild(0).gameObject
    emptyMark = self.transform:GetChild(1).gameObject
end

function self:Start()
    Timer.After(1, function()
        currentSeasonId = SessionModule.GetCurrentSeasonId()
        for i, s in ipairs(seasons) do
            if(i == currentSeasonId and not s) then
                self.gameObject:SetActive(false)
            end
        end

        -- if(not tracked) then
        --     print(self.gameObject.name .. " is not being tracked!")
        -- end
    end)
end

function MarkAsTracked()
    tracked = true
end

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

function SpawnItemParticle(icon)
    local particle = Object.Instantiate(itemParticle).gameObject
    particle:GetComponent(ItemParticle).SetUp(self.transform.position, icon)
end

function Collected()
    resourceModel:SetActive(false)
    emptyMark:SetActive(true)

    gatheredTime = os.time(os.date("*t"))
    ResourceManagerModule.ResourceGathered(self, uniqueID, gatheredTime)
end

function GetRenewTime()
    return renewTime * 60
end

function Renew()
    resourceModel:SetActive(true)
    emptyMark:SetActive(false)
end

-- Connect to the Tapped event
self.gameObject:GetComponent(TapHandler).Tapped:Connect(function()
    if(not resourceModel.activeSelf) then 
        UIManagerModule.SetObjectInfo(objectName, gatheredTime, GetRenewTime())
        return 
    end

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

            SpawnItemParticle(item.GetIcon())
            client.localPlayer.character:PlayEmote("mining-success", false)

            Collected()
        end
    end
end)