--!Type(Module)

local SaveModule = require("SaveModule")

-- [Server Side]

function PrintErrorCode(errorCode)
    if(errorCode == not nil) then
        print(`The error code was {StorageError[errorCode]}`)
    end
end

function SavePlayerDataToCloud(player, storage)
    Storage.SetPlayerValue(player, "Inventory", storage.inventory, function(errorCode)
        PrintErrorCode(errorCode)
    end)

    Storage.SetPlayerValue(player, "Tools", storage.tools, function(errorCode)
        PrintErrorCode(errorCode)
    end)

    Storage.SetPlayerValue(player, "DiscoveredItems", storage.discoveredItems, function(errorCode)
        PrintErrorCode(errorCode)
    end)

    Storage.SetPlayerValue(player, "GeneralInfo", storage.generalInfo, function(errorCode)
        PrintErrorCode(errorCode)
    end)

    print(player.name .. " saved Data to cloud")
end

function LoadPlayerDataFromCloud(player)
    Storage.GetPlayerValue(player, "GeneralInfo", function(generalInfo)
        SaveModule.LoadData(player, "GeneralInfo", generalInfo)
    end)

    Storage.GetPlayerValue(player, "Inventory", function(inventory)
        SaveModule.LoadData(player, "Inventory", inventory)
    end)

    Storage.GetPlayerValue(player, "Tools", function(tools)
        SaveModule.LoadData(player, "Tools", tools)
    end)

    Storage.GetPlayerValue(player, "DiscoveredItems", function(discoveredItems)
        SaveModule.LoadData(player, "DiscoveredItems", discoveredItems)
    end)

    print(player.name .. " loaded Data from cloud")
end

-- [Client Side]

