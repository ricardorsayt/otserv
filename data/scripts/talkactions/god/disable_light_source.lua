-- Disable player light sources

local talkaction = TalkAction("!disablelight")
function talkaction.onSay(player, words, param)
    if not player:getGroup():getAccess() then
        return true
    end
    local name = param:split(",")[1]:trim()
    local source = param:split(",")[2]:trim()

    local target = Player(name)
    if not target then
        player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, "Player not found.")
        return false
    end

    local lightCondition

    if source == "scroll" then
        lightCondition = target:getCondition(CONDITION_FULLLIGHT)
    elseif source == "clean" then
        lightCondition = target:getCondition(CONDITION_LIGHT)
        target:getPosition():sendMagicEffect(CONST_ME_MAGIC_RED)
        target:removeCondition(CONDITION_LIGHT)
        target:removeCondition(CONDITION_LIGHT, CONDITIONID_DEFAULT, 100)
        target:removeCondition(CONDITION_FULLLIGHT, CONDITIONID_DEFAULT)

        player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, "Player light source cleaned.")
        return true
    else
        lightCondition = target:getCondition(CONDITION_LIGHT)
    end

    if not lightCondition then
        player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, "Player does not have a light source.")
        return true
    end

    target:removeCondition(lightCondition)
    target:getPosition():sendMagicEffect(CONST_ME_MAGIC_RED)
    player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, "Player light source removed.")

    return true
end

talkaction:separator(" ")
talkaction:register()
