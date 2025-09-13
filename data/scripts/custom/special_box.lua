SPECIAL_BOX = {
    STORAGE_DUMMY_SKIN = 23999
}

local EARN_TYPE = {
    ITEM = 1,
    OUTFIT = 2
}

local CONFIG = {
    ATTRIBUTE = "ATTRIBUTE_SPECIAL_BOX_OWNER",
    ITEMS = {
        [5582] = {
            STORAGES = {24000},
            EARNS = {
                {
                    TYPE = EARN_TYPE.ITEM,
                    ITEMS = {
                        [5576] = 1,
                        [5544] = 1,
                        [5108] = 3,
                        [5550] = 3,
                        [5092] = 200,
                        [5547] = 1,
                    }
                },
                {
                    TYPE = EARN_TYPE.OUTFIT,
                    OUTFIT = {
                        [0] = 335,
                        [1] = 336,
                    },
                    ADDONS = 3
                }
            },
            EFFECT_ON_EARN = CONST_ME_MAGIC_GREEN,
            MESSAGE_ON_EARN = {
                "You received Outfit Full",
                "You received 1 Ravenor Bronze Founders Trophy",
                "You received 1 Ravenor Backpack",
                "You received 3 Ticket Dummy",
                "You received 3 Roleta Coins",
                "You received 200 Ravenor Coins",
                "You received 1 Ravenor Ring",
                "Check it in your storeinbox."
            }
        },

        [5583] = {
            STORAGES = {24001, 235001, 235004},
            EARNS = {
                {
                    TYPE = EARN_TYPE.ITEM,
                    ITEMS = {
                        [5578] = 1,
                        [5544] = 1,
                        [5108] = 10,
                        [5550] = 5,
                        [5092] = 300,
                        [5547] = 1,
                        [5549] = 1,
                    }
                },
                {
                    TYPE = EARN_TYPE.OUTFIT,
                    OUTFIT = {
                        [0] = 329,
                        [1] = 330,
                    },
                    ADDONS = 3
                }
            },
            EFFECT_ON_EARN = CONST_ME_MAGIC_GREEN,
            MESSAGE_ON_EARN = {
                "You received Outfit Full",
                "You received 1 Ravenor Silver Founders Trophy",
                "You received 1 Ravenor Backpack",
                "You received 10 Ticket Dummy",
                "You received 5 Roleta Coins",
                "You received 300 Ravenor Coins",
                "You received 1 Ravenor Ring",
                "You received 1 Ravenor Boots",
                "You received 1 Skin Dummy",
                "Check it in your storeinbox."
            }
        },

        [5584] = {
            STORAGES = {24002, 235001, 235004},
            EARNS = {
                {
                    TYPE = EARN_TYPE.ITEM,
                    ITEMS = {
                        [5580] = 1,
                        [5544] = 1,
                        [5108] = 15,
                        [5550] = 15,
                        [5092] = 500,
                        [5549] = 1,
                        [5548] = 1,
                    }
                },
                {
                    TYPE = EARN_TYPE.OUTFIT,
                    OUTFIT = {
                        [0] = 350,
                        [1] = 351,
                    },
                    ADDONS = 3
                }
            },
            EFFECT_ON_EARN = CONST_ME_MAGIC_GREEN,
            MESSAGE_ON_EARN = {
                "You received Outfit Full",
                "You received 1 Ravenor Gold Founders Trophy",
                "You received 1 Ravenor Backpack",
                "You received 15 Ticket Dummy",
                "You received 15 Roleta Coins",
                "You received 500 Ravenor Coins",
                "You received 1 Ravenor Boots",
                "You received 1 Ravenor Shield",
                "You received 1 Skin Dummy",
                "Check it in your storeinbox."
            }
        }
    }
}

SPECIAL_BOX.process = function(player, item)
    local itemConfig = CONFIG.ITEMS[item:getId()]
    local storeInbox = player:getStoreInbox()

    if not storeInbox then
        player:sendTextMessage(MESSAGE_STATUS_WARNING, "Store Inbox não disponível.")
        return
    end

    -- resto do código normal pra entregar os itens
    for _, earn in ipairs(itemConfig.EARNS) do
        if earn.TYPE == EARN_TYPE.ITEM then
            -- Cria e envia a mochila vazia para o Store Inbox
            local backpack = Game.createItem(5544, 1) -- mochila
            if not backpack or not backpack:isContainer() then
                player:sendTextMessage(MESSAGE_STATUS_WARNING, "Falha ao criar mochila.")
                return
            end
            backpack:setStoreItem(true)
            local result = storeInbox:addItemEx(backpack)
            backpack:setStoreItem(false)

            if result ~= RETURNVALUE_NOERROR then
                player:sendTextMessage(MESSAGE_STATUS_WARNING, "Falha ao enviar mochila para o Store Inbox.")
                return
            end

            -- Agora adiciona os itens avulsos no Store Inbox (não dentro da mochila)
            for itemId, itemCount in pairs(earn.ITEMS) do
                if itemId ~= 5544 then -- evita mochila dentro da mochila
                    local itemType = ItemType(itemId)
                    if itemType and itemType:isStackable() then
                        while itemCount > 0 do
                            local stack = math.min(100, itemCount)
                            local newItem = Game.createItem(itemId, stack)
                            if newItem then
                                if itemId == 5576 or itemId == 5578 or itemId == 5580 then
                                    newItem:setCustomAttribute("ITEM_CUSTOM_ATTRIBUTE_DESCRIPTION", "This item belongs to " .. player:getName())
                                end
                                newItem:setStoreItem(true)
                                storeInbox:addItemEx(newItem)
                                newItem:setStoreItem(false)
                            end
                            itemCount = itemCount - stack
                        end
                    else
                        -- item não empilhável, cria um por um
                        for i = 1, itemCount do
                            local newItem = Game.createItem(itemId, 1)
                            if newItem then
                                if itemId == 5576 or itemId == 5578 or itemId == 5580 then
                                    newItem:setCustomAttribute("ITEM_CUSTOM_ATTRIBUTE_DESCRIPTION", "This item belongs to " .. player:getName())
                                end
                                newItem:setStoreItem(true)
                                storeInbox:addItemEx(newItem)
                                newItem:setStoreItem(false)
                            end
                        end
                    end
                end
            end

        elseif earn.TYPE == EARN_TYPE.OUTFIT then
            if earn.OUTFIT then
                for sexType, looktype in pairs(earn.OUTFIT) do
                    if looktype then
                        player:addOutfit(looktype)
                        if earn.ADDONS and earn.ADDONS > 0 then
                            player:addOutfitAddon(looktype, earn.ADDONS)
                        end
                    else
                        player:sendTextMessage(MESSAGE_STATUS_WARNING, "Erro ao aplicar outfit para o sexo " .. tostring(sexType) .. ".")
                    end
                end
            else
                player:sendTextMessage(MESSAGE_STATUS_WARNING, "Erro ao aplicar outfit.")
            end
        end        
    end

    -- Efeito visual
    player:getPosition():sendMagicEffect(itemConfig.EFFECT_ON_EARN)

    -- Mensagens com delay
    local messages = itemConfig.MESSAGE_ON_EARN
    player:sendTextMessage(MESSAGE_EVENT_ADVANCE, messages[1])
    for i = 2, #messages do
        addEvent(function(playerId)
            local p = Player(playerId)
            if p then
                p:sendTextMessage(MESSAGE_EVENT_ADVANCE, messages[i])
            end
        end, (i - 1) * 1500, player:getId())
    end

    -- Atributos do item especial
    item:setCustomAttribute(CONFIG.ATTRIBUTE, player:getName())
    item:setCustomAttribute("ITEM_CUSTOM_ATTRIBUTE_DESCRIPTION", "This item belongs to " .. player:getName())

    -- Atualiza storages
    for _, storage in ipairs(itemConfig.STORAGES or {itemConfig.STORAGE}) do
        player:setStorageValue(storage, 1)
    end

    -- Remove o item especial usado
    item:remove()
end



local action = Action()

function action.onUse(player, item, fromPosition, target, toPosition, isHotkey)

    if item:getCustomAttribute(CONFIG.ATTRIBUTE) then
        return false
    end

    for _, storage in ipairs(CONFIG.ITEMS[item:getId()].STORAGES) do
        if not (storage == 235004 or storage == 235001) then
            if player:getStorageValue(storage) ~= -1 then
                player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You can only use this item once.")
                return false
            end
        end
    end

    Modal.Send(player, json.encode({
        action = "Confirm",
        data = {
            title = "Confirm",
            type = 1,
            value = item:getRealUID()
        }
    }))
    return true
end

for id, _ in pairs(CONFIG.ITEMS) do
    action:id(id)
end
action:register()

SPECIAL_BOX.reciver = function(player, message)
    if message.accept then
        local item = Item(message.value)
        if item then
            SPECIAL_BOX.process(player, item)
        end
    end
end

Modal.NewModal("Confirm_Special_Box", SPECIAL_BOX.reciver)
