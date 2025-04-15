--!Type(Module)

local SaveModule = require("SaveModule")

--!SerializeField
local generalQuests: { Quest } = {}

function GetQuest(questType)
    if(questType == "General") then
        generalQuestNumber = SaveModule.players_storage[client.localPlayer].generalInfo["Quests_General"] + 1
        return generalQuests[generalQuestNumber], generalQuestNumber
    end
end