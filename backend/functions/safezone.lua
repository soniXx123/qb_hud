local function showsafeZone(boolean)
    SendNUIMessage({
        action = "showsafeZone",
        boolean = boolean
    })
end

local function enterSafezone(player, vehicle)
    NetworkSetFriendlyFireOption(false)
    SetEntityCanBeDamaged(vehicle, false)
    ClearPlayerWantedLevel(PlayerId())
    SetCurrentPedWeapon(player, GetHashKey("WEAPON_UNARMED"), true)
    showsafeZone(true)
end

local function leaveSafezone(player, vehicle)
    NetworkSetFriendlyFireOption(true)
    showsafeZone(false)
    if Hud.speedlimitinSafezone then
        SetVehicleMaxSpeed(vehicle, 1000.00)
    end
    SetEntityCanBeDamaged(vehicle, true)
end

local function findClosestSafezone(x,y,z)
    local closestZone = nil
    local closestDist = nil

    for zone, data in pairs(Hud.Safezones) do
        local dist = Vdist(data.pos.x, data.pos.y, data.pos.z, x, y, z)
        if closestDist == nil or dist < closestDist then
            closestDist = dist
            closestZone = zone
        end
    end
    return closestZone
end

Citizen.CreateThread(function()
    local SafezoneIn = false
    local SafezoneOut = false

    while true do
        local player = PlayerPedId()
        local x, y, z = table.unpack(GetEntityCoords(player, true))
        local closestZone = findClosestSafezone(x,y,z)
        local dist = Vdist(Hud.Safezones[closestZone].pos.x, Hud.Safezones[closestZone].pos.y, Hud.Safezones[closestZone].pos.z, x, y, z)
        local vehicle = GetVehiclePedIsIn(player, false)
        local speed = GetEntitySpeed(vehicle)

        if dist <= Hud.Safezones[closestZone].radius then
            if not SafezoneIn then
                enterSafezone(player, vehicle)
                SafezoneIn = true
                SafezoneOut = false
            end
        else
            if not SafezoneOut then
                leaveSafezone(player, vehicle)
                SafezoneOut = true
                SafezoneIn = false
            end
        end

        if SafezoneIn then
            Citizen.Wait(10)
            -- Deaktiviere bestimmte Aktionen innerhalb der Safezone
            DisablePlayerFiring(player, true)
            SetPlayerCanDoDriveBy(player, false)
            DisableControlAction(2, 37, true)
        end

        Citizen.Wait(200)
    end
end)
