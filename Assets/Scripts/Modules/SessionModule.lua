--!Type(Module)

local Database = require("Database")
local UIManagerModule = require("UIManagerModule")

local currentTool = "None"

local currentSeason = nil

--!SerializeField
local seasonMaterial : Material = nil

local modifyPlayerScaleRequestEvent = Event.new("Modify Player Scale Event Request")
local modifyPlayerScaleEvent = Event.new("Modify Player Scale Event")

local transferPlayerRequestEvent = Event.new("Transfer Player Event Request")
local transferPlayerEvent = Event.new("Transfer Player Event")

function self:ClientAwake()
    modifyPlayerScaleEvent:Connect(function(player)
        players = client.players

        for i, p in ipairs(players) do
            p.character.transform.localScale = Vector3.new(0.8, 0.8, 0.8)
        end
    end)

    transferPlayerEvent:Connect(function(player, destination)
        player.character:Teleport(destination)

        if(player == client.localPlayer) then
            client.mainCamera:GetComponent(RTSCamera).CenterOn(destination)
        end
    end)
end

function self:ClientStart()
    ModifyPlayerScale()

    UpdateSeasonTime() 
    Timer.Every(60, function() 
        UpdateSeasonTime() 
    end)

    AdaptToSeason()
end

function GetCurrentTool()
    return currentTool
end

function SetCurrentTool(tool)
    currentTool = tool
end

function GetCurrentSeasonId()
    return currentSeason.id
end

function UpdateSeasonTime()
    local startDate = os.time({ year = 2025, month = 1, day = 1, hour = 0 })
    local today = os.time(os.date("*t"))

    local secondsPassed = today - startDate
    local daysPassedRaw = secondsPassed / (60 * 60 * 24)
    local daysPassed = math.floor(daysPassedRaw)

    local seasonProgress = daysPassedRaw - daysPassed

    seasonId = (daysPassed % 4) + 1
    currentSeason = Database.GetSeason(seasonId)

    -- print(secondsPassed, daysPassed, seasonProgress, seasonId)
    
    UIManagerModule.UpdateHUD_Season(currentSeason, seasonProgress)
end

function AdaptToSeason()
    if(currentSeason.id == 1) then
        ChangeSeasonMaterial(0.8, 0)
    elseif(currentSeason.id == 2) then
        ChangeSeasonMaterial(1, 0)
    elseif(currentSeason.id == 3) then
        ChangeSeasonMaterial(0.4, 0)
    else
        ChangeSeasonMaterial(0, 1)
    end
end

function ChangeSeasonMaterial(temperature, snow)
    seasonMaterial:SetFloat("_Temperature", temperature)
    seasonMaterial:SetFloat("_Snow", snow)
end

function ModifyPlayerScale()
    transferPlayerRequestEvent:FireServer()
end

function TransportPlayer(destination)
    transferPlayerRequestEvent:FireServer(destination)
end

-- [Server Side]

function self:ServerAwake()
    transferPlayerRequestEvent:Connect(function(player)
        modifyPlayerScaleEvent:FireAllClients(player)
    end)

    transferPlayerRequestEvent:Connect(function(player, destination)
        transferPlayerEvent:FireAllClients(player, destination)
    end)
end