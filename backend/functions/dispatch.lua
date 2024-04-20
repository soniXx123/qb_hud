RegisterNetEvent('hud:setDispatch')
AddEventHandler('hud:setDispatch', function(is, code, name, message, street, duration)
    setDispatch(is, code, name, message, street, duration)
end)

function setDispatch(is, code, name, message, street, duration)

    SendNUIMessage({
        action = "setDispatcha",
        is = is, 
        code = code, 
        name = name, 
        street = street, 
        message = message, 
        duration = duration
    })
end

RegisterCommand("dispatch", function(source, args, rawCommand)
    local playerPed = PlayerPedId()
    local playerPos = GetEntityCoords(playerPed)
    local streetName,_ = GetStreetNameAtCoord(playerPos.x, playerPos.y, playerPos.z)
    streetName = GetStreetNameFromHashKey(streetName)

    TriggerEvent("hud:setDispatch", "police", "10-10", "Polizei", "Schlägerei von Personen", streetName, 4000)
    TriggerEvent("hud:setDispatch", "lsmd", "11-10", "Ambulance", "Verletzte Personen", streetName, 4000)
end, false)