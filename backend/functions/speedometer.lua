Citizen.CreateThread(function()
    local sleep = 0

    while true do
        Citizen.Wait(sleep)

        local ped = PlayerPedId()
        local vehicle = GetVehiclePedIsUsing(ped)
        local inVeh = IsPedInAnyVehicle(ped, false)


        -- if inVeh == false then
        --     sleep = 1500
        -- end

        SendNUIMessage({
            action = "inVeh",
            boolean = inVeh,
        })

        if inVeh then

            SendNUIMessage({
                action = "setSpeed",
                speed = math.floor(GetEntitySpeed(vehicle) * 3.6),
            })

            local fuelLevel = GetVehicleFuelLevel(vehicle)
            local maxFuelLevel = 100

            SendNUIMessage({
                action = "setVehFuel",
                fuel = math.ceil(fuelLevel),
                max = maxFuelLevel
            })

            local lockStatus = GetVehicleDoorLockStatus(vehicle)
            local locked = (lockStatus == 2)
            local retval, lightsOn, highbeamsOn = GetVehicleLightsState(vehicle)

            SendNUIMessage({
                action = "setVehStates",
                locked = locked,
                seatbelt = highbeamsOn,
                engine = GetIsVehicleEngineRunning(vehicle),
            })
        end
    end
end)