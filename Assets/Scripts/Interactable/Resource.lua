--!Type(Client)

SaveModule = require("SaveModule")

--!SerializeField
local itemName : string = ""

-- Connect to the Tapped event
self.gameObject:GetComponent(TapHandler).Tapped:Connect(function()
    SaveModule.PlayerInventoryChange(true, itemName, 1)
end)