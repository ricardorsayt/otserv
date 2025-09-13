local stors = {
    [250] = 5
}

local items = {
    [5102] = {
        storages = {
            [250] = 5
        },
        msg = "You have successfully earned the title of Archpostman. You are now allowed to make use of certain mailboxes in dangerous areas."
    }
}

local function onUse(player, item, fromPosition, target, toPosition, isHotkey)
    local itm = items[item.itemid]
    if itm then
        -- Verifique o nível do jogador aqui (substitua 45 pelo nível desejado)
        if player:getLevel() >= 35 then
            local done = false
            for storage, value in pairs(stors) do
                if player:getStorageValue(storage) >= value then
                    done = true
                end
                if done then break end
            end
            if not done then
                for storage, value in pairs(itm.storages) do
                    player:setStorageValue(storage, value)
                end
                player:sendTextMessage(MESSAGE_EVENT_ADVANCE, itm.msg)
                player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
                item:remove()
            else
                player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You already have the title of Archpostman.")
                player:getPosition():sendMagicEffect(CONST_ME_POFF)
            end
        else
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You need level 35 or higher to use this item.")
        end
    end
    return true
end

local action = Action()
function action.onUse(player, item, fromPosition, target, toPosition, isHotkey)
    return onUse(player, item, fromPosition, target, toPosition, isHotkey)
end

action:id(5102)
action:register()
