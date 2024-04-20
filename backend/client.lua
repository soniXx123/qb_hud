ESX = exports['es_extended']:getSharedObject()

Citizen.CreateThread(function()
    SendNUIMessage({
        action = "setidentifier",
        id = GetPlayerServerId(PlayerId())
    })
    while not NetworkIsSessionStarted() do
        Citizen.Wait(0)
    end

    while ESX.GetPlayerData().job == nil do
        Citizen.Wait(0)
    end
end)

Citizen.CreateThread(function()    
    while true do 
        Citizen.Wait(4500)

        local playerData = ESX.GetPlayerData()
        if playerData then
            if playerData.accounts then
                for _, account in pairs(playerData.accounts) do 
                    if account.index == 1 then
                        money = account.money
                    elseif account.index == 3 then
                        blackmoney = account.money
                    end
                end

                SendNUIMessage({
                    action = "setmoney",
                    money = money,
                    blackmoney = blackmoney
                })
            end
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(5000)
        local streetName = GetStreetName(false)
        local crossingRoad = GetStreetName(true)

        SendNUIMessage({
            action = 'streets',
            street = streetName,
            crossingRoad = crossingRoad,
        })
    end
end)

function GetStreetName(zone)
    local coords = GetEntityCoords(PlayerPedId(), true)
    local zoneA = GetNameOfZone(coords.x, coords.y, coords.z)
    local streetName, crossingRoad = GetStreetNameAtCoord(coords.x, coords.y, coords.z)

    if zone then
        return GetLabelText(zoneA)
    else
        return GetStreetNameFromHashKey(streetName), GetStreetNameFromHashKey(crossingRoad)
    end
end

function updateplayers(players)
    SendNUIMessage({
        action = "setonlinePlayer",
        identifier = players,
    })
end

RegisterNetEvent('hud:updateplayers')
AddEventHandler('hud:updateplayers', function(iPlayers)
    updateplayers(iPlayers)
end)