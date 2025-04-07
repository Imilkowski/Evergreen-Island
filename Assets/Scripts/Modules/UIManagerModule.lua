--!Type(Module)

--!SerializeField
local inventoryUI : Inventory_UI = nil

function self:Start()
    --ShowInventory(false)
end

function ShowInventory(show:boolean)
    inventoryUI.gameObject:SetActive(show)
end