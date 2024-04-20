RegisterNetEvent('pma-voice:setTalkingMode')
AddEventHandler('pma-voice:setTalkingMode', function(lvl)
    GetCurrentVoiceMode(lvl)
end)
function GetCurrentVoiceMode(val)
    talkingStage = val;
    SendNUIMessage({
        action = 'micStates', 
        range = talkingStage,
        muted = VoiceMute(),
        -- isTalkin = NetworkIsPlayerTalking(PlayerId()),
        -- isFunk = isFunk
    })
end

function VoiceMute(state)
    return exports['pma-voice']:voiceState(isMuted)
end

