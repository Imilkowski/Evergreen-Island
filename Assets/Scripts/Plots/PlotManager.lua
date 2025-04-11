--!Type(Module)

local assignPlayerToPlotEvent = Event.new("Assign Player to a Shop") --Server
local returnPlotAssignmentsEvent = Event.new("Return Shop Assignments") --Client

-- [Server Side]

local shopsAssigned = {false, false, false, false, false, false, false, false} --Server
local shopsPlayers = {} --Server

function self:ServerAwake()
    server.PlayerConnected:Connect(function(player)
        print(player.name .. " connected to the server")
    end)

    server.PlayerDisconnected:Connect(function(player)
        print(player.name .. " disconnected from the server")

        UnAssignPlayer(player)
    end)

    assignPlayerToPlotEvent:Connect(function(player: Player)
        for i, v in ipairs(shopsAssigned) do
            if(v == false) then
                shopsAssigned[i] = true
                shopsPlayers[i] = player

                returnPlotAssignmentsEvent:FireAllClients(shopsPlayers, player)
                return
            end
        end

        print("Couldn't find a free plot for a player " .. player.name)
        returnPlotAssignmentsEvent:FireAllClients(shopsPlayers, player)
    end)
end

function UnAssignPlayer(player: Player)
    for k, p in pairs(shopsPlayers) do
        if(p == player) then
            shopsAssigned[k] = false
            shopsPlayers[k] = nil

            returnPlotAssignmentsEvent:FireAllClients(shopsPlayers)
            return
        end
    end
end

-- [Client Side]

--!SerializeField
local shops : { Plot } = {}

function self:ClientStart()
    returnPlotAssignmentsEvent:Connect(function(shopsPlayers, playerToUpdate)
        for i, shop in ipairs(shops) do
            shop.AssignPlayer(shopsPlayers[i])
        end
    end)

    Timer.After(0.1, function() 
        assignPlayerToPlotEvent:FireServer()
    end)
end