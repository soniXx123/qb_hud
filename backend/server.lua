ESX = exports['es_extended']:getSharedObject()

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(5000)
        local xPlayers = ESX.GetExtendedPlayers()
        TriggerClientEvent('hud:updateplayers', -1, #xPlayers)
        Citizen.Wait(30000)
    end
end)

RegisterCommand("announce", function(source, args)
    local src = source 
    local xPlayer = ESX.GetPlayerFromId(src)

    if xPlayer then
        if isAdmin(xPlayer.getGroup()) then 
            TriggerClientEvent('hud:announce', -1, table.concat(args, " "), 12500)
            Citizen.Wait(1500)
            TriggerClientEvent("hud:notification", src, "success", "success", Hud.Locales["Success"], 5000)
        else
            TriggerClientEvent("hud:notification", src, "error", "ERROR", Hud.Locales["No Rights"], 5000)

        end
    end
end)

function isAdmin(group)
    for _, aGroup in pairs(Hud.AllowedToSendAnnounce) do 
        if group == aGroup then 
            return true 
        end
    end
    return false
end

RegisterNetEvent("hud_sonix:saveMessage")
AddEventHandler("hud_sonix:saveMessage", function(object)
    local loadFile = LoadResourceFile(GetCurrentResourceName(), "./chat.json")
    local messages = json.decode(loadFile) or {}

    table.insert(messages, object)
    SaveResourceFile(GetCurrentResourceName(), "./chat.json", json.encode(messages), -1) 
    TriggerEvent("hud_sonix:getFile")
end)

function GetFile()
    local loadFile = LoadResourceFile(GetCurrentResourceName(), "./chat.json")
    local messages = json.decode(loadFile) or {}
    return messages
end

function ClearChatFile()
    local emptyData = {}
    local emptyJson = json.encode(emptyData)

    SaveResourceFile(GetCurrentResourceName(), "./chat.json", emptyJson, -1) 
end

RegisterNetEvent("hud_sonix:getFile", function()
    local messages = GetFile()
    TriggerClientEvent("hud_sonix:receiveFile", -1, messages)
end)

AddEventHandler("onResourceStart", function(resourceName)
    if GetCurrentResourceName() == resourceName then
        ClearChatFile()
    end
end)

AddEventHandler("onResourceStop", function(resourceName)
    if GetCurrentResourceName() == resourceName then
        ClearChatFile()
    end
end)