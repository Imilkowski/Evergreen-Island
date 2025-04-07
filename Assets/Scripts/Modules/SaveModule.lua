--!Type(Module)

-- Server Side

local trackPlayer = Event.new("Track Player")

local playerInventoryChange = Event.new("Player Inventory Change")

players_storage = {}

function self:ServerAwake()
    --Track Player
    trackPlayer:Connect(function(player: Player)
        players_storage[player] = {
            player = player,
            inventory = {}
        }
    end)

    --Untrack Player
    game.PlayerDisconnected:Connect(function(player)
        players_storage[player] = nil
    end)

    --Player Inventory Change
    playerInventoryChange:Connect(function(player: Player, add:boolean, itemName, amount)
        slotsOccupied = CountDictonaryItems(players_storage[player].inventory)

        if(players_storage[player].inventory[itemName] == nil) then
            if(slotsOccupied >= 2) then return end

            players_storage[player].inventory[itemName] = amount
        else
            if(not add) then
                amount *= -1
            end

            players_storage[player].inventory[itemName] += amount
        end
    end)
end

function CountDictonaryItems(t)
    local c = 0
    for _ in pairs(t) do c = c + 1 end
    return c
end



-- Client Side



function self:ClientAwake()
    trackPlayer:FireServer(client.localPlayer)
end

function PlayerInventoryChange(add, itemName, amount)
    playerInventoryChange:FireServer(add, itemName, amount)
end