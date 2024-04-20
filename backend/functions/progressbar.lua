RegisterNetEvent('hud:progressbar')
AddEventHandler('hud:progressbar', function(time, color)
    setProgressbar(time, color)
end)

function setProgressbar(seconds, hash)
    if time == nil then time = 5 end
    if color == nil then color = "#ff3030" end

    SendNUIMessage({
        action = "setProgressbar",
        time = seconds,
        color = hash,
    })
end

RegisterCommand("progressbar", function(source, args, rawCommand)
    TriggerEvent("hud:progressbar", 5, "#ff3030")
end, false)