--!Type(Client)

--!SerializeField
local shopId: number = 0

assignedPlayer = nil

function GetShopId()
    return shopId
end

function AssignPlayer(playerToAssign: Player)
    if(playerToAssign == nil) then
        self.gameObject:SetActive(false)
        return
    end

    self.gameObject:SetActive(true)
    
    -- if(playerToAssign == client.localPlayer) then
    --     playerIndicator:SetActive(true)
    --     nameTag.SetText("")
    -- else
    --     playerIndicator:SetActive(false)
    --     nameTag.SetText(playerToAssign.name)
    -- end

    SetPlayer(playerToAssign)
end

function SetPlayer(player:Player)
    assignedPlayer = player

    -- if(player == client.localPlayer) then
    --     UtilsModule.localShop = self
    -- end
end