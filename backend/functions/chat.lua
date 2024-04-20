ESX = exports['es_extended']:getSharedObject()

RegisterNetEvent('hud:progressbar')
AddEventHandler('hud:progressbar', function(time, color)
    setProgressbar(time, color)
end)

function chat(boolean)

    SetTextChatEnabled(false)
    
    SendNUIMessage({
        action = "showChat",
        boolean = boolean,
    })
    loadMessages()
    SendNUIMessage({
        action = "setCurrentUser",
        currentUser = {
            name = GetPlayerName(PlayerId()),
            job = ESX.PlayerData.job.name
        }
    })
    
    SetNuiFocus(boolean, boolean)
end


RegisterCommand('chat', function()
    chat(true)
end, false)

RegisterKeyMapping('chat', 'Chat', 'keyboard', 'T')

function executeChatMessage(object)
    local message = object.message
    if type(message) == "string" then
        if string.sub(message, 1, 1) == '/' then
            ExecuteCommand(message:sub(2))
            SetNuiFocus(false, false)
        else
            if object.type == "Organisation" then
                local playerJob = ESX.PlayerData.job.name or "No Job" -- Annahme: Verwende ESX für Spielerdaten
                object.job = playerJob
            end
            saveMessasges(object)
        end
    end
end

function saveMessasges(message)
    TriggerServerEvent("hud_sonix:saveMessage", message)
end

function loadMessages()
    TriggerServerEvent("hud_sonix:getFile")
end

RegisterNetEvent("hud_sonix:receiveFile", function(messages)
    SendNUIMessage({
        action = "pushMessages",
        messages = messages
    })
end)