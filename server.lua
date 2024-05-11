-- Configuration
local staffRole = "amezrial.staff"
local peopleOnDuty = {}
local discordWebhookUrl = 'YOUR_DISCORD_WEBHOOK_URL'

-- Command to toggle staff duty
RegisterCommand("staffduty", function(source)
    local name = GetPlayerName(source)
    if IsPlayerAceAllowed(source, staffRole) then
        if peopleOnDuty[name] then
            -- Staff going off duty
            local endTime = os.time()
            local totalTime = endTime - peopleOnDuty[name].startTime
            local hours = math.floor(totalTime / 3600)
            local minutes = math.floor((totalTime % 3600) / 60)

            TriggerClientEvent('chat:addMessage', source, {
                args = {"^7[ ^1Staff Duty ^7]", "^1" .. name .. " is now OFF duty. Total time on Duty: " .. hours .. "hr " .. minutes .. "min"},
                color = 255, 0, 0
            })
            sendToDiscord(name, false, hours, minutes)
            peopleOnDuty[name] = nil
        else
            -- Staff going on duty
            peopleOnDuty[name] = {startTime = os.time()}
            TriggerClientEvent('chat:addMessage', source, {
                args = {"^7[ ^2Staff Duty ^7]", "^2" .. name .. " is now ON duty"},
                color = 0, 255, 0
            })
            sendToDiscord(name, true)
        end
    else
        TriggerClientEvent('chat:addMessage', source, {
            args = {"Staff Duty", "You do not have permission to use this command."},
            color = 255, 0, 0
        })
    end
end, false)

-- Event when a player drops
AddEventHandler('playerDropped', function(reason) 
    local name = GetPlayerName(source)
    if peopleOnDuty[name] then
        local endTime = os.time()
        local totalTime = endTime - peopleOnDuty[name].startTime
        local hours = math.floor(totalTime / 3600)
        local minutes = math.floor((totalTime % 3600) / 60)

        TriggerClientEvent('chat:addMessage', -1, {
            args = {"^7[ ^3Staff Duty ^7] (^3" .. name .. "^7)", " is now ^8OFF ^7duty due to disconnection. Total time on Duty: " .. hours .. "hr " .. minutes .. "min"},
            color = 255, 0, 0
        })
        sendToDiscord(name, false, hours, minutes)
        peopleOnDuty[name] = nil
    end
end)


-- Function to send messages to Discord
function sendToDiscord(name, isOnDuty, hours, minutes)
    local timeMessage = ""
    if not isOnDuty then
        timeMessage = " Total time on Duty: " .. hours .. "hr " .. minutes .. "min."
    end
    local message = name .. (isOnDuty and " is now ON duty." or " has gone OFF duty." .. timeMessage)
    PerformHttpRequest(discordWebhookUrl, function(err, text, headers) end, 'POST', json.encode({content = message}), {['Content-Type'] = 'application/json'})
end
