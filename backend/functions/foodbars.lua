function updateStatus(status)
    for _, v in ipairs(status) do
        if v.name == "hunger" or v.name == "thirst" then
            local index = (v.name == "hunger") and 1 or 2
            SendNUIMessage({
                action = "updateStatus",
                index = index,
                int = v.percent
            })
        end
    end
end

local hunger, thirst = 0
Citizen.CreateThread(function()
    while true do 
        Citizen.Wait(5000)
        local stamina = 100 - GetPlayerSprintStaminaRemaining(PlayerId())
        TriggerEvent("esx_status:getStatus", "hunger", function(h)
            TriggerEvent("esx_status:getStatus", "thirst", function(t)
                hunger = h.getPercent()
                thirst = t.getPercent()
            end)
        end)
        
        SendNUIMessage({
            action = 'setFoodBars',
            leben = GetEntityHealth(PlayerPedId())-100,
            food = hunger,
            drink = thirst,
            blitz = stamina,
            shield = GetPedArmour(PlayerPedId())
        })
    end
end)