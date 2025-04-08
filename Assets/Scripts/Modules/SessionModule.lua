--!Type(Module)

local currentTool = "None"
local currentSeason = 1

function GetCurrentTool()
    return currentTool
end

function SetCurrentTool(tool)
    currentTool = tool
end

function GetCurrentSeasonId()
    return currentSeason
end