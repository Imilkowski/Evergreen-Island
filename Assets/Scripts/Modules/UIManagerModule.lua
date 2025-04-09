--!Type(Module)

local SaveModule = require("SaveModule")

--!SerializeField
local hudUI : HUD_UI = nil
--!SerializeField
local inventoryUI : Inventory_UI = nil
--!SerializeField
local objectInfoUI : ObjectInfo_UI = nil

function self:ClientStart()
    ShowInventory(false)
    objectInfoUI.gameObject:SetActive(false)
end

function ShowInventory(show:boolean)
    inventoryUI.gameObject:SetActive(show)

    if(show) then
        inventoryUI.UpdateItemsList(SaveModule.players_storage[client.localPlayer].inventory)
    end
end

function UpdateHUD_Season(season, seasonProgress)
    hudUI.UpdateSeasonInfo(season, seasonProgress)
end

function SetObjectInfo(objectName, startTime, totalTime)
    objectInfoUI.gameObject:SetActive(true)
    objectInfoUI.SetObjectInfo(objectName, startTime, totalTime)
end