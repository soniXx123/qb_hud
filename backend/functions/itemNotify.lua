RegisterNetEvent('hud:itemNotify')
AddEventHandler('hud:itemNotify', function(label, name, type, count)
    setItemNotify(label, name, type, count)
end)

function setItemNotify(label, name, type, count)   
    SendNUIMessage({
        action = "setItemNotify",
        label = label, 
        name = name, 
        type = type, 
        count = count
    })
end

RegisterCommand("itemNotify", function(source, args, rawCommand)
    TriggerEvent("hud:itemNotify", "Advanced Rifle", "advancedrifle", "added", 5)
end, false)

RegisterNetEvent('hud_sonix:addInventoryItem', function(item, count)
    TriggerEvent('hud:itemNotify', item.label, item.name, "added", count)
end)

RegisterNetEvent('hud_sonix:removeInventoryItem', function(item, count)
    TriggerEvent('hud:itemNotify', item.label, item.name, "removed", count)
end)
