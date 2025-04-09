--!Type(Module)

--!SerializeField
local recourcesTracked : { ResourceOrigin } = {}

local gatheredResources = {}

function self:ClientStart()
    for i, resource in ipairs(recourcesTracked) do
        resource.MarkAsTracked()
    end

    Timer.Every(1, function()
        CheckGatheredResources()
    end)
end

function ResourceGathered(resource : ResourceOrigin, uniqueID, gatheredTime)
    gatheredResources[uniqueID] = {resource, gatheredTime}
    print("Resource gathered", resource.name)
end

function CheckGatheredResources()
    now = os.time(os.date("*t"))

    clearTable = {}
    for k, v in pairs(gatheredResources) do
        timeDiff = now - v[2]
        renewTime = v[1].GetRenewTime()

        --print(v[1].name, timeDiff)

        if(timeDiff >= renewTime) then
            v[1].Renew()
            table.insert(clearTable, k)
        end
    end

    for i, v in clearTable do
        gatheredResources[v] = nil
    end
end