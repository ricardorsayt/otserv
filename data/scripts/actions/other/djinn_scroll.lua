local stors = {
    [278] = 3,
    [279] = 2,
    [280] = 2,
    [281] = 2,
    [282] = 2,
    [283] = 3,
    [286] = 3,
    [287] = 3,
    [288] = 3
}

local items = {
    [5099] = {
        storages = {
            [278] = 2,
            [280] = 2,
            [281] = 2,
            [282] = 2,
            [283] = 3
        },
        msg = "You have successfully proved your allegiance for the first time."
    },
    [5100] = {
        storages = {
            [278] = 3,
            [286] = 3,
            [287] = 3,
            [288] = 3
        },
        msg = "You have successfully proved your allegiance for the second time."
    }
}

local function onUse(player, item, fromPosition, target, toPosition, isHotkey)
    local itm = items[item.itemid]
    if itm then
        -- Verifique o nível do jogador aqui (substitua 45 pelo nível desejado)
        if player:getLevel() >= 1 then
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
                player:sendTextMessage(MESSAGE_EVENT_ADVANCE, itm.errorMsg or "You already successfully proved your allegiance.")
                player:getPosition():sendMagicEffect(CONST_ME_POFF)
            end
        else
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You need level 1 or higher to use this item.")
        end
    end
    return true
end

local action = Action()
function action.onUse(player, item, fromPosition, target, toPosition, isHotkey)
    return onUse(player, item, fromPosition, target, toPosition, isHotkey)
end

action:id(5099)
action:id(5100)
action:register()
