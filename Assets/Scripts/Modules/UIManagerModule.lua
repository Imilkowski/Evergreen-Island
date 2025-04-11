--!Type(Module)

local SaveModule = require("SaveModule")

--!SerializeField
local hudUI : HUD_UI = nil
--!SerializeField
local objectInfoUI : ObjectInfo_UI = nil

--!SerializeField
local inventoryUI : Inventory_UI = nil
--!SerializeField
local busUI : Bus_UI = nil

function self:ClientStart()
    objectInfoUI.gameObject:SetActive(false)

    ClosePanel(inventoryUI)
    ClosePanel(busUI)
end

function UpdateHUD_Season(season, seasonProgress)
    hudUI.UpdateSeasonInfo(season, seasonProgress)
end

function SetObjectInfo(objectName, startTime, totalTime)
    objectInfoUI.gameObject:SetActive(true)
    objectInfoUI.SetObjectInfo(objectName, startTime, totalTime)
end

function ClosePanel(panel)
    panel.gameObject:SetActive(false)
end

function ShowInventory()
    show = not inventoryUI.gameObject.activeSelf

    inventoryUI.gameObject:SetActive(show)

    if(show) then
        inventoryUI.UpdateItemsList(SaveModule.players_storage[client.localPlayer].inventory)
    end
end

function ShowBus()
    show = not busUI.gameObject.activeSelf

    busUI.gameObject:SetActive(show)

    if(show) then
        busUI.CreateButtonsList()
    end
end