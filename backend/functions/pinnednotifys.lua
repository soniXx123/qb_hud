local blacklistedStrings = {"<", ">", "http", "https", ".png", ".mp4", ".mp3", ".mov", ".webm"}

RegisterNetEvent('hud:pinnedNotify')
AddEventHandler('hud:pinnedNotify', function(is, title, icon, duration)
    setPinnedNotify(is, title, icon, duration)
end)

function setPinnedNotify(is, title, icon, duration)
    if icon == nil then return end
    if is == nil then type = "info" end
    if title == nil then title = "Information" end
    if duration == nil then duration = 5000 end

    if not checkString(title) then
        print("Blacklisted String gefunden (Titel oder Nachricht): " .. title)
        return
    end

    SendNUIMessage({
        action = "setPinnedNotify",
        type = is,
        label = title,
        message = icon,
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

RegisterCommand("pnotify", function(source, args, rawCommand)
    TriggerEvent("hud:pinnedNotify", "luck", "Glück", 'mdi:luck', 50000)
end, false)