local function showHelpNotify(key, label, message)
    if not key or not label or not message then
        print("Error: Invalid parameters for showHelpNotify")
        return
    end
    SendNUIMessage({
        action = "showhelpnotify",
        boolean = true,
        helpnotify = {
            key = key,
            label = label,
            message = message
        }
    })
end

local function hideHelpNotify()
    SendNUIMessage({
        action = "showhelpnotify",
        boolean = false,
        helpnotify = {}
    })
end

RegisterNetEvent('hud:helpNotify')
AddEventHandler('hud:helpNotify', function(key, label, message)
    showHelpNotify(key, label, message)
end)

RegisterNetEvent('hud:hideHelpNotify')
AddEventHandler('hud:hideHelpNotify', function()
    hideHelpNotify()
end)

RegisterCommand("hideHelpNotify", function(source, args, rawCommand)
    hideHelpNotify()
end, false)

RegisterCommand("helpNotify", function(source, args, rawCommand)
    showHelpNotify("E", "Informations Stand", "Drücke E um zu Interagieren")
end, false)
