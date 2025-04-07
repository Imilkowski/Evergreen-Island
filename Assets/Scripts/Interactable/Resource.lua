--!Type(Client)

SaveModule = require("SaveModule")

-- Connect to the Tapped event
self.gameObject:GetComponent(TapHandler).Tapped:Connect(function()
    print("Tapped")
    SaveModule.IncreaseScore(1)
end)