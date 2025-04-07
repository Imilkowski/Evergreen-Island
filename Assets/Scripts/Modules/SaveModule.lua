--!Type(Module)

-- Server Side

local trackPlayer = Event.new("Track Player")

local increasePlayerScore = Event.new("Increase Player Score")

players_storage = {}

function self:ServerAwake()
    --Track Player
    trackPlayer:Connect(function(player: Player)
        players_storage[player] = {
            player = player,
            score = 0,
        }
    end)

    --Untrack Player
    game.PlayerDisconnected:Connect(function(player)
        players_storage[player] = nil
    end)

    --Increase Player Score
    increasePlayerScore:Connect(function(player: Player, scoreChange)
        players_storage[player].score += scoreChange

        print(player.name .. " new score: " .. players_storage[player].score)
    end)
end

-- Client Side

function self:ClientAwake()
    trackPlayer:FireServer(client.localPlayer)
end

function IncreaseScore(scoreChange)
    increasePlayerScore:FireServer(scoreChange)
end