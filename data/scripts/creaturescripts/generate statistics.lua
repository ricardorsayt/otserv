local enabledStats = false

function isStatisticsModeOn()
    return enabledStats
end

function Monster:checkStatisticsMode()
    if not isStatisticsModeOn() then
        return true
    end

    self:registerEvent("HealthStatisticsMode")
end

local talkaction = TalkAction("/enablestats")

function talkaction.onSay(player, words, param)

    if not player:getGroup():getAccess() then
		return true
	end

	if player:getAccountType() < ACCOUNT_TYPE_GOD then
		return false
	end

    player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Statistics mode on! Logout to shutdown on your character")
    player:registerEvent("HealthStatisticsMode")
    enabledStats = true
    return true
end

talkaction:separator(" ")
talkaction:register()

local healthEvent = CreatureEvent("HealthStatisticsMode")
function healthEvent.onHealthChange(creature, attacker, damage, type, origin)
    local file = io.open("health statistics.txt", "a+")
    if file then
        file:write(os.date("%Y-%m-%d %H:%M:%S") .. " - " .. attacker:getName() .. " dealt " .. damage .. " damage of ".. creature:getName() ..".\n")
        file:close()
    end

    return damage, type
end

healthEvent:register()