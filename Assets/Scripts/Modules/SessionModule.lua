--!Type(Module)

local Database = require("Database")
local UIManagerModule = require("UIManagerModule")

local currentTool = "None"

local currentSeason = nil

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

function self:ClientStart()
    UpdateSeasonTime() 
    Timer.Every(60, function() 
        UpdateSeasonTime() 
    end)
end