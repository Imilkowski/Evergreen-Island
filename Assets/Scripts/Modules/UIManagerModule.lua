--!Type(Module)

local SaveModule = require("SaveModule")

--!SerializeField
local inventoryUI : Inventory_UI = nil

function self:Start()
    ShowInventory(false)
end

function ShowInventory(show:boolean)
    inventoryUI.gameObject:SetActive(show)

    if(show) then
        inventoryUI.UpdateItemsList(SaveModule.players_storage[client.localPlayer].inventory)
    end
end