--!Type(Module)

--!SerializeField
local inventorySize : number = 0;

local trackPlayer = Event.new("Track Player")

--Inventory
local getPlayerStorage = Event.new("Get Player Storage")
local getPlayerStorageResponse = Event.new("Get Player Storage Response")

local changeInventoryItem = Event.new("Change Inventory Item")
local changeInventoryResponse = Event.new("Change Inventory Response")

local addDiscoveredItem = Event.new("Add Discovered Item")
local addDiscoveredItemResponse = Event.new("Add Discovered Item Response")

players_storage = {}

-- [Server Side]

function self:ServerAwake()
    --Track Player
    trackPlayer:Connect(function(player: Player)
        players_storage[player] = {
            player = player,
            inventory = {},
            tools = {
                Axe = 2,
                Pickaxe = 2,
                Shovel = 2
            },
            discoveredItems = {
                "Acorn",
                "Daisy",
                "Iron",
                "Stone",
                "Tree Sap",
                "Wood"
            }
        }
    end)

    --Untrack Player
    game.PlayerDisconnected:Connect(function(player)
        players_storage[player] = nil
    end)

    --Track Player
    getPlayerStorage:Connect(function(player: Player)
        getPlayerStorageResponse:FireClient(player, players_storage[player])
    end)

    --Player Inventory Change
    changeInventoryItem:Connect(function(player: Player, itemName, amount)
        slotsOccupied = CountDictonaryItems(players_storage[player].inventory)

        if(players_storage[player].inventory[itemName] == nil) then
            if(slotsOccupied >= inventorySize) then return end

            players_storage[player].inventory[itemName] = amount
        else
            players_storage[player].inventory[itemName] += amount
        end

        changeInventoryResponse:FireClient(player, players_storage[player].inventory)
    end)

    --Player Donated Item
    addDiscoveredItem:Connect(function(player: Player, itemName)
        table.insert(players_storage[player].discoveredItems, itemName)

        addDiscoveredItemResponse:FireClient(player, players_storage[player].discoveredItems)
    end)
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

    --Get Player Storage Response
    getPlayerStorageResponse:Connect(function(storage)
        players_storage[client.localPlayer] = storage;
        print("Player storage received")
    end)
end

function self:ClientStart()
    getPlayerStorage:FireServer(client.localPlayer)
end

function Local_ChangeInventoryItem(itemName, amount)
    if(players_storage[client.localPlayer].inventory[itemName] == nil) then
        slotsOccupied = CountDictonaryItems(players_storage[client.localPlayer].inventory)
        if(slotsOccupied >= inventorySize) then return end

        players_storage[client.localPlayer].inventory[itemName] = amount
    else
        players_storage[client.localPlayer].inventory[itemName] += amount
    end
end

function Local_AddDiscoveredItem(itemName)
    table.insert(players_storage[client.localPlayer].discoveredItems, itemName)
end

function ChangeInventoryItem(itemName, amount)
    changeInventoryItem:FireServer(itemName, amount)

    Local_ChangeInventoryItem(itemName, amount)
end

function AddDiscoveredItem(itemName)
    addDiscoveredItem:FireServer(itemName)

    Local_AddDiscoveredItem(itemName)
end

function GetInventorySize()
    return inventorySize;
end

function GetTools()
    return players_storage[client.localPlayer].tools;
end

function GetDiscoveredItems()
    return players_storage[client.localPlayer].discoveredItems;
end