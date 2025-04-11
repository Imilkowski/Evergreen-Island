--!Type(Client)

local UIManagerModule = require("UIManagerModule")
local SessionModule = require("SessionModule")

--!SerializeField
local returning: boolean = false
--!SerializeField
local travelPoints: { Transform } = {}

function Travel(travelPoint)
    SessionModule.TransportPlayer(travelPoints[travelPoint].position)
end

-- Connect to the Tapped event
self.gameObject:GetComponent(TapHandler).Tapped:Connect(function()
    if (returning) then
        Travel(1)
    else
        UIManagerModule.ShowBus(self)
    end
end)