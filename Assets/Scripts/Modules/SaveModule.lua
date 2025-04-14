--!Type(Module)

--!SerializeField
local inventorySize : number = 0;

local trackPlayer = Event.new("Track Player")

--Inventory
local getPlayerStorage = Event.new("Get Player Storage")
local getPlayerStorageResponse = Event.new("Get Player Storage Response")

local changeInventoryItem = Event.new("Change Inventory Item")
local changeInventoryResponse = Event.new("Change Inventory Response")

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
    changeInventoryItem:Connect(function(player: Player, add:boolean, itemName, amount)
        slotsOccupied = CountDictonaryItems(players_storage[player].inventory)

        if(players_storage[player].inventory[itemName] == nil) then
            if(slotsOccupied >= inventorySize) then return end

            players_storage[player].inventory[itemName] = amount
        else
            if(not add) then
                amount *= -1
            end

            players_storage[player].inventory[itemName] += amount
        end

        changeInventoryResponse:FireClient(player, players_storage[player].inventory)
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

    --Get Player Storage Response
    changeInventoryResponse:Connect(function(inventory)
        players_storage[client.localPlayer].inventory = inventory;
    end)

    --Change Inventory Response
    getPlayerStorageResponse:Connect(function(storage)
        players_storage[client.localPlayer] = storage;
        print("Player storage received")
    end)
end

function self:ClientStart()
    getPlayerStorage:FireServer(client.localPlayer)
end

function ChangeInventoryItem(add, itemName, amount)
    changeInventoryItem:FireServer(add, itemName, amount)
end

function GetInventorySize()
    return inventorySize;
end

function GetTools()
    return players_storage[client.localPlayer].tools;
end