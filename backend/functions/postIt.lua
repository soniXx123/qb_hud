RegisterNetEvent('hud:showPostit')
AddEventHandler('hud:showPostit', function(boolean)
    showPostit(boolean)
end)

function showPostit(boolean)
    SendNUIMessage({
        action = "showPostit",
        boolean = boolean,
    })
    SetNuiFocus(boolean, boolean)
end

local postIts = {}

function sendPostIT(message, distance)
    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)

    local postIt = {
        message = message,
        coords = playerCoords,
        distance = distance
    }
    table.insert(postIts, postIt)
end

local notiySent = false
function checkPostITs()
    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)
    for _, postIt in ipairs(postIts) do
        local distance = GetDistanceBetweenCoords(playerCoords, postIt.coords, true)

        if distance <= postIt.distance then
            notiySent = true
            TriggerEvent("hud:notification", "info", "PostIT", postIt.message, 6000)
            Citizen.Wait(6000)
            notiySent = false
        end
    end
end

Citizen.CreateThread(function()
    while true do
        if not notiySent then
            checkPostITs()
        end
        Citizen.Wait(5000)
    end
end)



RegisterCommand("showPostit", function(source, args, rawCommand)
    TriggerEvent("hud:showPostit", true)
end, false)

