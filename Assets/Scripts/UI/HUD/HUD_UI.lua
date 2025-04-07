--!Type(UI)

local UIManagerModule = require("UIManagerModule")

--!Bind
local _Inventory_Button: VisualElement = nil

-- Register a callback for when the button is pressed
_Inventory_Button:RegisterPressCallback(function()
    UIManagerModule.ShowInventory(true)
end)