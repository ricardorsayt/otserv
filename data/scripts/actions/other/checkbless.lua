local action = Action()

action:id(5116)

-- define blessings
local blessings = {
    {id = 1, name = 'Wisdom of Solitude', storage = 101},
    {id = 2, name = 'Spark of the Phoenix', storage = 102},
    {id = 3, name = 'Fire of the Suns', storage = 103},
    {id = 4, name = 'Spiritual Shielding', storage = 104},
    {id = 5, name = 'Embrace of Tibia', storage = 105}
}

function Player.updateBlessingStorages(self)
    for _, bless in pairs(blessings) do
        local storage = bless.storage
        if self:hasBlessing(bless.id) then
            self:setStorageValue(storage, 1)
        else
            self:setStorageValue(storage, -1)
        end
    end
end

-- define action function
function action.onUse(player, item, fromPosition, target, toPosition, isHotkey)
    local result, bless = 'Received blessings:'
    for i = 1, #blessings do
        bless = blessings[i]
        result = player:hasBlessing(bless.id) and result .. '\n' .. bless.name or result
    end

    player:sendTextMessage(MESSAGE_EVENT_ADVANCE, 20 > result:len() and 'No blessings received.' or result)
    return true
end

-- register action
action:register()
