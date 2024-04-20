RegisterNUICallback("hud_sonix:fetchToClient", function(data)
    local dataClient = data.data
    if dataClient.file == 'postIt' then
        if dataClient.label == 'hidePostIT' then
            showPostit(false)
        elseif dataClient.label == 'sendPostIT' then
            sendPostIT(dataClient.message, dataClient.distance)
            showPostit(false)
        end
    elseif dataClient.file == 'modalWindow' then
            if dataClient.label == 'recjeted' then
                showModalWindow(false)
            elseif dataClient.label == 'accepted' then 
                if dataClient.event then
                    TriggerEvent(dataClient.event)
                end
                showModalWindow(false)
            end
    elseif dataClient.file == 'chat' then
        if dataClient.label == 'sendMessage' then
            executeChatMessage(dataClient)
        elseif dataClient.label == 'loadTypeMessages' then 

        elseif dataClient.label == 'closeChat' then 
            SetNuiFocus(false, false)
        end
    else
        print('Ein Fehler ist Aufgetreten ' .. dataClient.label.. ' ist ein nicht Vorhandenes Label')
        return
    end
end)