local blacklistedStrings = {"<", ">", "http", "https", ".png", ".mp4", ".mp3", ".mov", ".webm"}

-- https://icon-sets.iconify.design/
local icons = {
    police = 'map:police',
    essen = 'mdi:food',
    trinken = 'mdi:cup-water',
    success = 'mdi:check-circle-outline',
    error = 'mdi:alert-circle-outline',
    warning = 'mdi:alert-octagon-outline',
    info = 'mdi:information-outline'
}

local colorBg = {
    police = {
        bg = 'rgba(50, 105, 255)',
        bar = '#3262ff',
        icon = "lightblue"
    },
    essen = {
        bg = 'rgba(255, 165, 0)',
        bar = 'orange',
        icon = "orange"
    },
    trinken = {
        bg = 'rgba(172, 190, 216)',
        bar = '#ACBED8',
        icon = "#ACBED8"
    },
    success = {
        bg = 'rgba(53, 255, 71)',
        bar = '#35FF69',
        icon = "#35FF69"
    },
    error = {
        bg = 'rgba(144, 11, 21)',
        bar = 'red',
        icon = "red"
    },
    warning = {
        bg = 'rgba(255, 255, 0)',
        bar = '#ffff00',
        icon = "yellow"
    },
    info = {
        bg = 'rgba(89, 89, 89)',
        bar = '#A5A5A5',
        icon = "CCCCCC"
    }
}

AddEventHandler("onResourceStart", function(resourceName)
    if GetCurrentResourceName() ~= resourceName then
        return
    end


end)

RegisterNetEvent('hud:notification')
AddEventHandler('hud:notification', function(is, title, message, duration)
    setNotification(is, title, message, duration)
end)

--[[
    Funktion: setNotification
    Beschreibung: Zeigt eine Benachrichtigung an.

    @params is (string): Der Typ der Benachrichtigung (optional, Standardwert: "info").
    @params title (string): Der Titel der Benachrichtigung (optional, Standardwert: "Information").
    @params message (string): Die Nachricht der Benachrichtigung (erforderlich).
    @params duration (number): Die Dauer der Benachrichtigung in Millisekunden (optional, Standardwert: 5000).

--]]

function setNotification(is, title, message, duration)
    if message == nil then return end
    if is == nil then type = "info" end
    if title == nil then title = "Information" end
    if duration == nil then duration = 5000 end

    if not checkString(title) or not checkString(message) then
        print("Blacklisted String gefunden (Titel oder Nachricht): " .. title .. " | " .. message)
        return
    end

    PlaySoundFrontend(-1, "ATM_WINDOW", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
    SendNUIMessage({
        action = "extraData",
        icons= icons, 
        colorBg = colorBg
    })
    SendNUIMessage({
        action = "setNotifys",
            type = is,
            label = title,
            message = message,
            duration = duration
        
    })
end

function checkString(str)
    for _, pattern in ipairs(blacklistedStrings) do
        if string.find(str, pattern) then
            return false
        end
    end
    return true
end

RegisterCommand("id", function(source, args, rawCommand)
    TriggerEvent("hud:notification", "info", "Deine ID:", "Deine ID Lautet: ".. GetPlayerServerId(PlayerId()), 6000)
end, false)

RegisterCommand("testnotifications", function(source, args, rawCommand)
    TriggerEvent("hud:notification", "police", "Polizei Benachrichtigung", "Es gibt eine Polizeiaktion in deiner Nähe.", 5000)
    TriggerEvent("hud:notification", "essen", "Essensbenachrichtigung", "Dein Essen ist fertig!", 5000)
    TriggerEvent("hud:notification", "trinken", "Getränkebenachrichtigung", "Dein Getränk ist bereit!", 5000)
    TriggerEvent("hud:notification", "success", "Erfolgsbenachrichtigung", "Erfolgreich!", 5000)
    TriggerEvent("hud:notification", "error", "Fehlerbenachrichtigung", "Ein Fehler ist aufgetreten.", 5000)
    TriggerEvent("hud:notification", "warning", "Warnungsbenachrichtigung", "Vorsicht!", 5000)
    TriggerEvent("hud:notification", "info", "Informationsbenachrichtigung", "Hier ist eine Information.", 5000)
end, false)
