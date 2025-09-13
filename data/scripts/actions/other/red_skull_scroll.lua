local action = Action()

function action.onUse(player, item, fromPosition, target, toPosition, isHotkey)
    
    if player:getSkull() ~= SKULL_RED then
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You don't have a red skull.")
        return true
    end

    local sto = player:getStorageValue(51241)
    local missing = sto - os.time()
    if sto > 0 then
        local days = math.floor(missing / 86400)
        local hours = math.floor((missing % 86400) / 3600)
        local minutes = math.floor((missing % 3600) / 60)

        local message = "You can't use this item yet. You need to wait "
        if days > 0 then
            message = message .. days .. " days"
        end
        if hours > 0 then
            if days > 0 then
                message = message .. ", "
            end
            message = message .. hours .. " hours"
        end
        if minutes > 0 then
            if days > 0 or hours > 0 then
                message = message .. " and "
            end
            message = message .. minutes .. " minutes"
        end

        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, message .. ".")
        return true
    end

    player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "The Gods of Ravenor have forgive your sins.")
    player:getPosition():sendMagicEffect(CONST_ME_MAGIC_RED)
    player:setSkull(SKULL_NONE)
    player:setStorageValue(51241, os.time() + 7 * 24 * 60 * 60)
    player:removeKillerEnd()
    item:remove()
    return true
end

action:id(5498)
action:register()