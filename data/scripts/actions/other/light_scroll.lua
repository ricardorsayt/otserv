local CONFIG = {
    ID = 100,
    ITEM_ID = 5119,
    TIME = 24, -- IN HOURS
    LIGHT_LEVEL = 9,
    ATTRIBUTES = {
        ITEM_OWNER = "ITEM_ATTRIBUTE_OWNER",
        ITEM_OWNER_NAME = "ITEM_ATTRIBUTE_OWNER_NAME",
        ITEM_TIME = "ITEM_ATTRIBUTE_EXPIRE",
    }
}

local event = EventCallback
function event.onLook(player, thing, position, distance)
    if thing:getId() == CONFIG.ITEM_ID then
        local time = "It is brand new."
        local itemTime = thing:getCustomAttribute(CONFIG.ATTRIBUTES.ITEM_TIME)
        local owner = thing:getCustomAttribute(CONFIG.ATTRIBUTES.ITEM_OWNER_NAME)
        local message = ""
        
        if itemTime then
            message = string.format("\nIt is owned by %s.", owner)
            local remainingTime =  itemTime - os.time()

            if remainingTime > 0 then
                if remainingTime >= 3600 then
                    local remainingHours = math.floor(remainingTime / 3600)
                    local remainingMinutes = math.floor((remainingTime % 3600) / 60)
                    if remainingMinutes == 0 then
                        time = string.format("It has %d hour%s left to expire.", remainingHours,
                            remainingHours > 1 and "s" or "")
                    else
                        time = string.format("It has %d hour%s and %d minute%s left to expire.", remainingHours,
                            remainingHours > 1 and "s" or "", remainingMinutes, remainingMinutes ~= 1 and "s" or "")
                    end
                elseif remainingTime >= 60 then
                    local remainingMinutes = math.floor(remainingTime / 60)
                    local remainingSeconds = remainingTime % 60
                    if remainingSeconds == 0 then
                        time = string.format("It has %d minute%s left to expire.", remainingMinutes,
                            remainingMinutes > 1 and "s" or "")
                    else
                        time = string.format("It has %d minute%s and %d second%s left to expire.", remainingMinutes,
                            remainingMinutes > 1 and "s" or "", remainingSeconds, remainingSeconds ~= 1 and "s" or "")
                    end
                else
                    time = string.format("It has %d second%s left to expire.", remainingTime,
                        remainingTime > 1 and "s" or "")
                end



            else
                time = ""
                message = string.format("It has expired.")
            end
        end
        
        thing:setAttribute(ITEM_ATTRIBUTE_DESCRIPTION, string.format("\n%s%s", time, message))
    end
end

event:register(-1)

local action = Action()
function action.onUse(player, item, fromPosition, target, toPosition, isHotkey)

    local time = item:getCustomAttribute(CONFIG.ATTRIBUTES.ITEM_TIME)
    local owner = item:getCustomAttribute(CONFIG.ATTRIBUTES.ITEM_OWNER)
    if time and time < os.time() then
        item:remove()
        player:getPosition():sendMagicEffect(CONST_ME_POFF)
        player:sendCancelMessage("The light scroll has expired.")
        return true
    end

    if not target or not target:isPlayer() then
        player:getPosition():sendMagicEffect(CONST_ME_POFF)
        return false
    end

    if owner and owner ~= target:getGuid() then
        player:getPosition():sendMagicEffect(CONST_ME_POFF)
        return false
    end

    if not item:getCustomAttribute(CONFIG.ATTRIBUTES.ITEM_OWNER) then
        item:setCustomAttribute(CONFIG.ATTRIBUTES.ITEM_OWNER, target:getGuid())
        item:setCustomAttribute(CONFIG.ATTRIBUTES.ITEM_OWNER_NAME, target:getName())
        item:setCustomAttribute(CONFIG.ATTRIBUTES.ITEM_TIME, os.time() + CONFIG.TIME * 60 * 60) -- HOURS
    end

    local time = item:getCustomAttribute(CONFIG.ATTRIBUTES.ITEM_TIME) - os.time()
        
    local condition = Condition(CONDITION_FULLLIGHT, CONDITIONID_DEFAULT)
    condition:setParameter(CONDITION_PARAM_LIGHT_LEVEL, CONFIG.LIGHT_LEVEL)
    condition:setParameter(CONDITION_PARAM_LIGHT_COLOR, 215)
    condition:setParameter(CONDITION_PARAM_TICKS, time * 1000)
    condition:setParameter(CONDITION_PARAM_LIGHT_REDUCE, false)
    target:addCondition(condition)
    target:getPosition():sendMagicEffect(CONST_ME_MAGIC_GREEN)
    
    return true
end

action:id(CONFIG.ITEM_ID)
action:register()