--!Type(UI)

--!Bind
local _ObjectName: UILabel = nil
--!Bind
local _Progress: VisualElement = nil
--!Bind
local _TimeLeft: UILabel = nil

local objectName = ""
local startTime = nil
local totalTime = 0

local updateTimer : Timer | nil = nil

function FormatTime(seconds)
    local h = math.floor(seconds / 3600)
    local m = math.floor((seconds % 3600) / 60)
    local s = seconds % 60

    local parts = {}

    if h > 0 then
        table.insert(parts, h .. "h")
    end
    if m > 0 then
        table.insert(parts, m .. "m")
    end
    if s > 0 or (#parts == 0) then
        table.insert(parts, s .. "s")
    end

    return table.concat(parts, " ")
end

function SetObjectInfo(name, time, total)
    startTime = time
    objectName = name
    totalTime = total

    UpdateObjectInfo()
    updateTimer = Timer.Every(1, function()
        UpdateObjectInfo()
    end)
end

function UpdateObjectInfo()
    local now = os.time(os.date("*t"))
    local secondsPassed = now - startTime
    progress = secondsPassed / totalTime

    if(progress >= 1) then
        if (updateTimer) then
            updateTimer:Stop()
            updateTimer = nil
        end

        self.gameObject:SetActive(false)
        return
    end

    _ObjectName:SetPrelocalizedText(objectName)
    --_Progress.style.backgroundColor = color
    _Progress.style.width = progress * 100
    _TimeLeft:SetPrelocalizedText(FormatTime(totalTime - secondsPassed))
end