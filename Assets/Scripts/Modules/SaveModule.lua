--!Type(Module)

local CloudSaveModule = require("CloudSaveModule")

--!SerializeField
local saveToCloudInterval : number = 0;

--!SerializeField
local inventorySize : number = 0;

local trackPlayer = Event.new("Track Player")

local savePlayerDataToCloud = Event.new("Save Player Data To Cloud")
local loadPlayerDataFromCloud = Event.new("Load Player Data From Cloud")

local playerStorageLoadedResponse = Event.new("Player Storage Loaded Response")

local changeInventoryItem = Event.new("Change Inventory Item")
local changeInventoryResponse = Event.new("Change Inventory Response")

local addDiscoveredItem = Event.new("Add Discovered Item")
local addDiscoveredItemResponse = Event.new("Add Discovered Item Response")

local dataLoaded = false

players_storage = {}

-- [Server Side]

function self:ServerAwake()
    --Track Player
    trackPlayer:Connect(function(player: Player)
        players_storage[player] = {
            player = player,
            generalInfo = {
                Coins = 0,
                Gems = 0,
                Level = 0,
                Experience = 0,
                Quests_General = 0
            },
            tools = {
                Axe = 2,
                Pickaxe = 2,
                Shovel = 2
            },
            inventory = {},
            discoveredItems = {}
        }
    end)

    --Untrack Player
    game.PlayerDisconnected:Connect(function(player)
        CloudSaveModule.SavePlayerDataToCloud(player, players_storage[player])
        players_storage[player] = nil
    end)

    --Save Player Data To Cloud
    savePlayerDataToCloud:Connect(function(player: Player)
        CloudSaveModule.SavePlayerDataToCloud(player, players_storage[player])
    end)

    --Load Player Data From Cloud
    loadPlayerDataFromCloud:Connect(function(player: Player)
        CloudSaveModule.LoadPlayerDataFromCloud(player)

        Timer.After(1, function()
            playerStorageLoadedResponse:FireClient(player, players_storage[player])
        end)
    end)

    --Player Inventory Change
    changeInventoryItem:Connect(function(player: Player, itemName, amount)
        slotsOccupied = CountDictonaryItems(players_storage[player].inventory)

        if(players_storage[player].inventory[itemName] == nil) then
            if(slotsOccupied >= inventorySize) then return end

            players_storage[player].inventory[itemName] = amount
        else
            players_storage[player].inventory[itemName] += amount

            if(players_storage[player].inventory[itemName] <= 0) then
                players_storage[player].inventory[itemName] = nil
            end
        end

        changeInventoryResponse:FireClient(player, players_storage[player].inventory)
    end)

    --Player Donated Item
    addDiscoveredItem:Connect(function(player: Player, itemName)
        table.insert(players_storage[player].discoveredItems, itemName)

        addDiscoveredItemResponse:FireClient(player, players_storage[player].discoveredItems)
    end)
end

function LoadData(player, dataType, data)
    if(data == nil) then
        return
    end

    if(dataType == "GeneralInfo") then
        players_storage[player].generalInfo = data
    end

    if(dataType == "Inventory") then
        players_storage[player].inventory = data
    end

    if(dataType == "Tools") then
        players_storage[player].tools = data
    end

    if(dataType == "DiscoveredItems") then
        players_storage[player].discoveredItems = data
    end
end

function CountDictonaryItems(t)
    local c = 0
    for _ in pairs(t) do c = c + 1 end
    return c
end



-- [Client Side]



function self:ClientAwake()
    trackPlayer:FireServer(client.localPlayer)

    --Change Inventory Response
    changeInventoryResponse:Connect(function(inventory)
        players_storage[client.localPlayer].inventory = inventory;
    end)

    --Add Discovered Item Response
    addDiscoveredItemResponse:Connect(function(discoveredItems)
        players_storage[client.localPlayer].discoveredItems = discoveredItems;
    end)

    --Player Storage Loaded Response
    playerStorageLoadedResponse:Connect(function(storage)
        players_storage[client.localPlayer] = storage;

        dataLoaded = true
        print("Player storage loaded")
    end)
end

function self:ClientStart()
    loadPlayerDataFromCloud:FireServer(client.localPlayer)

    Timer.Every(saveToCloudInterval, function()
        if (dataLoaded) then
            savePlayerDataToCloud:FireServer(client.localPlayer)
        end
    end)
end

-- Local

function Local_ChangeInventoryItem(itemName, amount)
    if(players_storage[client.localPlayer].inventory[itemName] == nil) then
        slotsOccupied = CountDictonaryItems(players_storage[client.localPlayer].inventory)
        if(slotsOccupied >= inventorySize) then return end

        players_storage[client.localPlayer].inventory[itemName] = amount
    else
        players_storage[client.localPlayer].inventory[itemName] += amount

            if(players_storage[client.localPlayer].inventory[itemName] <= 0) then
                players_storage[client.localPlayer].inventory[itemName] = nil
            end
    end
end

function Local_AddDiscoveredItem(itemName)
    table.insert(players_storage[client.localPlayer].discoveredItems, itemName)
end

-- Set Values

function ChangeInventoryItem(itemName, amount)
    changeInventoryItem:FireServer(itemName, amount)

    Local_ChangeInventoryItem(itemName, amount)
end

function AddDiscoveredItem(itemName)
    addDiscoveredItem:FireServer(itemName)

    Local_AddDiscoveredItem(itemName)
end

-- Get Values

function GetInventorySize()
    return inventorySize;
end

function GetTools()
    return players_storage[client.localPlayer].tools;
end

function GetDiscoveredItems()
    return players_storage[client.localPlayer].discoveredItems;
end

function GetGeneralInfo()
    return players_storage[client.localPlayer].generalInfo;
end