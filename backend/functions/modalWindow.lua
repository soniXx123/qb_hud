RegisterNetEvent('hud:modalWindow')
AddEventHandler('hud:modalWindow', function(label,message,strong,event)
    setModalWindow(label,message,strong,event)
end)

function showModalWindow(boolean)
    SendNUIMessage({
        action = "showModalWindow",
        boolean = boolean
    })
    SetNuiFocus(boolean,boolean)
end

function setModalWindow(label, message, strong, event)
    -- Message Dort rein wird das Haupt Item gesetzt ->[] "Du wurdest eingeladen der Fraktion [Test] beizutreten.",
    SendNUIMessage({
        action = "setModalWindow",
        label = label,
        message = message,
        strong = strong,
        event = event
    })
    showModalWindow(true)
end

RegisterCommand("modalWindow", function(source, args, rawCommand)
    TriggerEvent("hud:modalWindow", "Fraktions Einladung", "Du wurdest eingeladen der Fraktion [Test] beizutreten.", "Polizei", "fraction:invite")
end, false)