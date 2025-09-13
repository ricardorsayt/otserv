local NPC_QUEST_CONFIG = {
    ["Nah'bob"] = {
        STORAGES = {
            [283] = 3,
        },
        ERROR_MESSAGE = "I'm sorry, pal. You don't have Gabel's permission to trade with me."
    },
    ["Haroun"] = {
        STORAGES = {
            [283] = 3,
        },
        ERROR_MESSAGE = "I'm sorry, pal. You don't have Gabel's permission to trade with me."
    },
    ["Yaman"] = {
        STORAGES = {
            [288] = 3,
        },
        ERROR_MESSAGE = "I'm sorry, but you don't have Malor's permission to trade with me."
    },
    ["Alesar"] = {
        STORAGES = {
            [288] = 3,
        },
        ERROR_MESSAGE = "No chance, human. Malor doesn't want me to trade with strangers."
    },
}

function Npc:onStartTrade(player)
    local data = NPC_QUEST_CONFIG[self:getName()]
    if data then
       for storage, value in pairs(data.STORAGES) do
            if player:getStorageValue(storage) ~= value then
                return data.ERROR_MESSAGE
            end
       end
    end

    return ""
end