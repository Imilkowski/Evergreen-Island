--!Type(Client)

local UIManagerModule = require("UIManagerModule")

--!SerializeField
local triggerType: string = ""

function self:OnTriggerEnter(collider: Collider)
    local playerCharacter = collider.gameObject:GetComponent(Character)
    if (playerCharacter.player ~= client.localPlayer) then return end

    UIManagerModule.Show_NPC_Panel(triggerType)
end