-- useful functions
--[[

Game.isItemInPosition(position, itemid)
doRelocate({x = 32792, y = 31581, z = 07},{x = 32792, y = 31582, z = 07})
Game.createItem(4799, 1, {x = 32627, y = 31699, z = 10})
Game.transformItemInPosition({x = 32628, y = 31699, z = 10}, 1284, 493)
Game.removeItemInPosition({x = 32627, y = 31699, z = 10}, 4801)

]]
local StepActions = {}

-- local action = Action()

-- function action.onUse(player, item, fromPosition, target, toPosition)

--     return true
-- end

-- action:aid(2008)
-- action:register()

-- Etapa 1
---AID 6601 Alavanca de entrada - 32801 32336 11 adicionar item (406) no sqm indicado ao puxar alavanca.

local LEVER_OFF = 1945
local LEVER_ON = 1946

local function switch_lever(lever, to)
    if lever then
        if to then
            lever:transform(to, 1)
        else
            if lever:getId() == LEVER_OFF then -- desativada
                lever:transform(LEVER_ON, 1)   -- ativada
            else
                lever:transform(LEVER_OFF, 1)
            end
        end

        lever:decay()
    end
end

local Step1 = Action()

function Step1.onUse(player, item, fromPosition, target, toPosition)
    local splash = Tile(toPosition):getItemByGroup(ITEM_GROUP_SPLASH)
    if not splash or splash:getSubType() ~= 7 then
        player:say("The lever is creaking and rusty.", TALKTYPE_MONSTER_SAY)
        toPosition:sendMagicEffect(CONST_ME_POFF)
        return true
    end

    local passagem = Position(32801, 32336, 11)
    local function return_passage()
        if Game.isItemInPosition(passagem, 406) then
            local tile = Tile(passagem)
            if tile then
                for _, creature in pairs(tile:getCreatures()) do
                    creature:teleportTo(Position(32798, 32336, 11))
                end
            end

            passagem:sendMagicEffect(CONST_ME_POFF)

            Game.createItem(493, 1, passagem)
            Game.removeItemInPosition(passagem, 406)
            Game.createItem(4801, 1, passagem)
            Game.createItem(4803, 1, passagem)
            Game.createItem(4802, 1, passagem)
            Game.createItem(4800, 1, passagem)
            switch_lever(item, LEVER_OFF)
            toPosition:sendMagicEffect(CONST_ME_POFF)
        end
    end

    if not Game.isItemInPosition(passagem, 406) then
        Game.createItem(406, 1, passagem)
        Game.removeItemInPosition(passagem, 4801)
        Game.removeItemInPosition(passagem, 4803)
        Game.removeItemInPosition(passagem, 4802)
        Game.removeItemInPosition(passagem, 4800)
        toPosition:sendMagicEffect(CONST_ME_POFF)
        switch_lever(item, LEVER_ON)
        addEvent(return_passage, 5 * 1000)
    else
        toPosition:sendMagicEffect(CONST_ME_POFF)
    end

    return true
end

Step1:aid(6601)
Step1:register()

-- Etapa 2
-- AID 6602 Destruir pedra/use - 32810,32335,11 substituir lava no chão por terra/Earth item (351)

local grounds = {
    [1] = {
        [1] = {
            ["y"] = 32337,
            ["z"] = 11,
            ["x"] = 32805
        },
        [2] = 598
    },
    [2] = {
        [1] = {
            ["y"] = 32338,
            ["z"] = 11,
            ["x"] = 32805
        },
        [2] = 598
    },
    [3] = {
        [1] = {
            ["y"] = 32339,
            ["z"] = 11,
            ["x"] = 32805
        },
        [2] = 598
    },
    [4] = {
        [1] = {
            ["y"] = 32337,
            ["z"] = 11,
            ["x"] = 32806
        },
        [2] = 598
    },
    [5] = {
        [1] = {
            ["y"] = 32338,
            ["z"] = 11,
            ["x"] = 32806
        },
        [2] = 598
    },
    [6] = {
        [1] = {
            ["y"] = 32339,
            ["z"] = 11,
            ["x"] = 32806
        },
        [2] = 598
    },
    [7] = {
        [1] = {
            ["y"] = 32334,
            ["z"] = 11,
            ["x"] = 32807
        },
        [2] = 598
    },
    [8] = {
        [1] = {
            ["y"] = 32335,
            ["z"] = 11,
            ["x"] = 32807
        },
        [2] = 598
    },
    [9] = {
        [1] = {
            ["y"] = 32336,
            ["z"] = 11,
            ["x"] = 32807
        },
        [2] = 598
    },
    [10] = {
        [1] = {
            ["y"] = 32337,
            ["z"] = 11,
            ["x"] = 32807
        },
        [2] = 598
    },
    [11] = {
        [1] = {
            ["y"] = 32338,
            ["z"] = 11,
            ["x"] = 32807
        },
        [2] = 598
    },
    [12] = {
        [1] = {
            ["y"] = 32334,
            ["z"] = 11,
            ["x"] = 32808
        },
        [2] = 598
    },
    [13] = {
        [1] = {
            ["y"] = 32335,
            ["z"] = 11,
            ["x"] = 32808
        },
        [2] = 601
    },
    [14] = {
        [1] = {
            ["y"] = 32336,
            ["z"] = 11,
            ["x"] = 32808
        },
        [2] = 599
    },
    [15] = {
        [1] = {
            ["y"] = 32337,
            ["z"] = 11,
            ["x"] = 32808
        },
        [2] = 601
    },
    [16] = {
        [1] = {
            ["y"] = 32338,
            ["z"] = 11,
            ["x"] = 32808
        },
        [2] = 598
    },
    [17] = {
        [1] = {
            ["y"] = 32333,
            ["z"] = 11,
            ["x"] = 32809
        },
        [2] = 598
    },
    [18] = {
        [1] = {
            ["y"] = 32334,
            ["z"] = 11,
            ["x"] = 32809
        },
        [2] = 598
    },
    [19] = {
        [1] = {
            ["y"] = 32335,
            ["z"] = 11,
            ["x"] = 32809
        },
        [2] = 599
    },
    [20] = {
        [1] = {
            ["y"] = 32336,
            ["z"] = 11,
            ["x"] = 32809
        },
        [2] = 598
    },
    [21] = {
        [1] = {
            ["y"] = 32337,
            ["z"] = 11,
            ["x"] = 32809
        },
        [2] = 598
    },
    [22] = {
        [1] = {
            ["y"] = 32338,
            ["z"] = 11,
            ["x"] = 32809
        },
        [2] = 598
    },
    [23] = {
        [1] = {
            ["y"] = 32339,
            ["z"] = 11,
            ["x"] = 32809
        },
        [2] = 598
    },
    [24] = {
        [1] = {
            ["y"] = 32333,
            ["z"] = 11,
            ["x"] = 32810
        },
        [2] = 600
    },
    [25] = {
        [1] = {
            ["y"] = 32334,
            ["z"] = 11,
            ["x"] = 32810
        },
        [2] = 601
    },
    [26] = {
        [1] = {
            ["y"] = 32335,
            ["z"] = 11,
            ["x"] = 32810
        },
        [2] = 598
    },
    [27] = {
        [1] = {
            ["y"] = 32336,
            ["z"] = 11,
            ["x"] = 32810
        },
        [2] = 598
    },
    [28] = {
        [1] = {
            ["y"] = 32337,
            ["z"] = 11,
            ["x"] = 32810
        },
        [2] = 600
    },
    [29] = {
        [1] = {
            ["y"] = 32338,
            ["z"] = 11,
            ["x"] = 32810
        },
        [2] = 598
    },
    [30] = {
        [1] = {
            ["y"] = 32339,
            ["z"] = 11,
            ["x"] = 32810
        },
        [2] = 598
    },
    [31] = {
        [1] = {
            ["y"] = 32333,
            ["z"] = 11,
            ["x"] = 32811
        },
        [2] = 599
    },
    [32] = {
        [1] = {
            ["y"] = 32334,
            ["z"] = 11,
            ["x"] = 32811
        },
        [2] = 600
    },
    [33] = {
        [1] = {
            ["y"] = 32335,
            ["z"] = 11,
            ["x"] = 32811
        },
        [2] = 598
    },
    [34] = {
        [1] = {
            ["y"] = 32336,
            ["z"] = 11,
            ["x"] = 32811
        },
        [2] = 598
    },
    [35] = {
        [1] = {
            ["y"] = 32337,
            ["z"] = 11,
            ["x"] = 32811
        },
        [2] = 598
    },
    [36] = {
        [1] = {
            ["y"] = 32338,
            ["z"] = 11,
            ["x"] = 32811
        },
        [2] = 598
    },
    [37] = {
        [1] = {
            ["y"] = 32334,
            ["z"] = 11,
            ["x"] = 32812
        },
        [2] = 600
    },
    [38] = {
        [1] = {
            ["y"] = 32334,
            ["z"] = 11,
            ["x"] = 32813
        },
        [2] = 598
    }
}

function onUsePick(player, item, fromPosition, target, toPosition)

    if target and target:getActionId() == 6602 then
        local positions = { fromx = 32805, tox = 32813, fromy = 32333, toy = 32339, z = 11 }
        for x = positions.fromx, positions.tox do
            for y = positions.fromy, positions.toy do
                local position = { x = x, y = y, z = positions.z }
                local tile = Tile(position)
                if tile then
                    local ground = tile:getGround()
                    if ground then
                        local id = ground:getId()
                        if id >= 598 and id <= 601 then
                            -- table.insert(grounds, {position, id}) --INFO: dev mode
                            ground:transform(351)
                        end
                    end
                end
            end
        end

        -- pdump(grounds) --INFO: dev mode
        local id = target:getId()
        addEvent(function()
                local stone = Game.createItem(id, 1, toPosition)
                stone:setActionId(6602)

                for _, groundInfo in pairs(grounds) do
                    local tile = Tile(groundInfo[1])
                    if tile then
                        local ground = tile:getGround()
                        if ground then
                            local creatures = tile:getCreatures()
                            if creatures then
                                for _, creature in pairs(creatures) do
                                    creature:teleportTo(Position(32798, 32336, 11))
                                end
                            end

                            ground:transform(groundInfo[2])
                        end
                    end
                end
            end,
            5 * 1000)

        target:getPosition():sendMagicEffect(CONST_ME_POFF)
        target:remove()
        return true
    end

    return onUsePick_original(player, item, fromPosition, target, toPosition)
end

-- special fires

local fires = {
    [4] = {
        Position(32830, 32328, 11),
        Position(32830, 32327, 11),
        Position(32830, 32326, 11),
        Position(32830, 32325, 11),
        Position(32830, 32324, 11),
        Position(32830, 32323, 11),
        Position(32830, 32322, 11),
        Position(32830, 32321, 11),
        Position(32829, 32321, 11),
        Position(32828, 32321, 11),
        Position(32827, 32321, 11)
    },
    [2] = {
        Position(32832, 32329, 11),
        Position(32833, 32329, 11),
        Position(32834, 32329, 11),
        Position(32835, 32329, 11),
        Position(32836, 32329, 11),
        Position(32837, 32329, 11),
        Position(32838, 32329, 11),
        Position(32838, 32328, 11),
        Position(32838, 32327, 11),
        Position(32839, 32327, 11),
        Position(32840, 32327, 11)
    },
    [1] = {
        Position(32830, 32338, 11),
        Position(32830, 32339, 11),
        Position(32830, 32340, 11),
        Position(32830, 32341, 11),
        Position(32830, 32342, 11),
        Position(32830, 32343, 11),
        Position(32830, 32344, 11),
        Position(32830, 32345, 11),
        Position(32829, 32345, 11),
        Position(32828, 32345, 11),
        Position(32827, 32345, 11)
    },
    [3] = {
        Position(32832, 32337, 11),
        Position(32833, 32337, 11),
        Position(32834, 32337, 11),
        Position(32835, 32337, 11),
        Position(32836, 32337, 11),
        Position(32837, 32337, 11),
        Position(32838, 32337, 11),
        Position(32838, 32338, 11),
        Position(32838, 32339, 11),
        Position(32839, 32339, 11),
        Position(32840, 32339, 11)
    }
}

local build_poi_fire = GlobalEvent("PoiStartup")

function build_poi_fire.onStartup()
    for i = 1, 4 do
        local positions = fires[i]
        for _, position in pairs(positions) do
            local fire = Game.createItem(5542, 1, position)
            fire:setActionId(6637)
        end
    end

    local door3700 = Game.createItem(1209, 1, Position(32827, 32246, 10))
    door3700:setAttribute(ITEM_ATTRIBUTE_KEYHOLENUMBER, 3700)

    local key = Game.createItem(2090, 3700, Position(32847, 32233, 8))
    local poison = Game.createItem(1496, 1, Position(32847, 32233, 8)) -- hide key

    
    return true
end

build_poi_fire:register()

fires[8] = fires[4]
fires[7] = fires[3]
fires[6] = fires[2]
fires[5] = fires[1]

local moveevent = MoveEvent()

function moveevent.onStepIn(creature, item, position, fromPosition)
    
    
    if creature:isPlayer() then
        local index, vocation
        local pvoc = creature:getVocation():getId()

        for voc, positions in ipairs(fires) do
            for k, pos in pairs(positions) do
                if pos.x == position.x and pos.y == position.y and pos.z == position.z then
                    index = k
                    vocation = voc

                    if voc == pvoc then
                        return true
                    end
                end
            end
        end

        
        if not index or not vocation then
            return true
        end


        local damage = - 200 * index
        
        doTargetCombatHealth(0, creature, COMBAT_FIREDAMAGE, damage, damage)
    end

    return true
end

moveevent:aid(6637)
moveevent:register()

-- Etapa 3
-- AID 6603/AID 6604/AID 6605/AID 6606 - 4 alavancas cada uma abre uma porta na posição ref: 32831 32333 11 (No global cada alavanca representa uma vocação/mas isso fica a critério de vocês.

local config = {
    [6603] = { doorPosition = { x = 32831, y = 32333, z = 11 }, vocationIds = { 4, 8 } }, -- ok
    [6604] = { doorPosition = { x = 32833, y = 32333, z = 11 }, vocationIds = { 2, 6 } },
    [6605] = { doorPosition = { x = 32835, y = 32333, z = 11 }, vocationIds = { 3, 7 } },
    [6606] = { doorPosition = { x = 32837, y = 32333, z = 11 }, vocationIds = { 1, 5 } }
}

local function doTransformDoors(position)
    local tile = Tile(Position(position))
    if tile then
        Game.transformItemInPosition(position, 1209, 1211)
    end
end

local Step3 = Action()

function Step3.onUse(player, item, fromPosition, target, toPosition)
    local configValue = config[item:getActionId()]
    -- if isInArray(configValue.vocationIds, player:getVocation():getId()) then
        doTransformDoors(configValue.doorPosition)
        Position(configValue.doorPosition):sendMagicEffect(CONST_ME_FIREAREA)
        switch_lever(item, LEVER_ON)
        -- return true
    -- end

    return true
end

Step3:aid(6603)
Step3:aid(6604)
Step3:aid(6605)
Step3:aid(6606)
Step3:register()

-- Etapa 4
-- AID 6607 - puxar todas as 15 alavancas para liberar a passagem removendo as pedras da coordenada 32851 32333 12

local LeverMazePositions = {
    [1] = Position(32874, 32334, 12),
    [2] = Position(32891, 32328, 14),
    [3] = Position(32843, 32352, 14),
    [4] = Position(32889, 32349, 15),
    [5] = Position(32887, 32330, 12),
    [6] = Position(32846, 32318, 12),
    [7] = Position(32887, 32355, 13),
    [8] = Position(32853, 32359, 14),
    [9] = Position(32843, 32359, 12),
    [10] = Position(32847, 32332, 13),
    [11] = Position(32886, 32337, 13),
    [12] = Position(32874, 32365, 13),
    [13] = Position(32850, 32366, 13),
    [14] = Position(32859, 32364, 13),
    [15] = Position(32874, 32354, 14),
}

local function from_pos_to_string(position)
    return string.format("%d,%d,%d", position.x, position.y, position.z)
end

local LeverMazeIdByPosition = {}

for leverId, position in pairs(LeverMazePositions) do
    LeverMazeIdByPosition[from_pos_to_string(position)] = leverId
end

local function get_lever_id(position)
    return LeverMazeIdByPosition[from_pos_to_string(position)]
end


local text = {
    [1] = 'first',
    [2] = 'second',
    [3] = 'third',
    [4] = 'fourth',
    [5] = 'fifth',
    [6] = 'sixth',
    [7] = 'seventh',
    [8] = 'eighth',
    [9] = 'ninth',
    [10] = 'tenth',
    [11] = 'eleventh',
    [12] = 'twelfth',
    [13] = 'thirteenth',
    [14] = 'fourteenth',
    [15] = 'fifteenth'
}

local stones = {
    Position(32851, 32333, 12),
    Position(32852, 32333, 12)
}

local function return_stones()
    for i = 1, #stones do
        Game.createItem(1304, 1, stones[i])
    end
end

local Step4 = Action()

function Step4.onUse(player, item, fromPosition, target, toPosition)

    local id = get_lever_id(toPosition)
    
    if not id then
        return false
    end
    
    if item:getId() == LEVER_ON then
        player:say('You flipped the ' .. text[id] .. ' lever. Hurry up and find the next one!', TALKTYPE_MONSTER_SAY,
        false, player, toPosition)
        return true
    end

    for i = 1, id - 1 do
        local lever = Tile(LeverMazePositions[i]):getItemById(LEVER_ON)
        if not lever then

            if id == 15 then
                player:say('The final lever won\'t budge... yet.', TALKTYPE_MONSTER_SAY)
                return false
            end

            return false
        end
    end

    player:say('You flipped the ' .. text[id] .. ' lever. Hurry up and find the next one!', TALKTYPE_MONSTER_SAY, false, player, toPosition)
    if id == 15 then

        for _, position in pairs(stones) do
            local stone = Tile(position):getItemById(1304)
            if stone then
                stone:remove()
                position:sendMagicEffect(CONST_ME_EXPLOSIONAREA)
            end
        end

        addEvent(function()
            for i = 1, #stones do
                if not Game.isItemInPosition(stones[i], 1304) then
                    Game.createItem(1304, 1, stones[i])
                end
            end
        end, 15 * 60 * 1000)
    end

    switch_lever(item, LEVER_ON)
    addEvent(function()
        local tile = Tile(toPosition)
        if tile then
            local leverItem = tile:getItemById(LEVER_ON)
            if leverItem then
                leverItem:transform(LEVER_OFF)
            end
        end
    end, 15 * 60 * 1000)

    return true
end

Step4:aid(6607)
Step4:register()

local Step4_in = MoveEvent()

function Step4_in.onStepIn(creature, item, position, fromPosition)
    local passagem = Position(32851, 32309, 11)

    local tile = Tile(passagem)
    if tile then
        local ground = tile:getGround()
        if ground then
            ground:transform(1284)
        end
    end
    
    Game.removeItemInPosition(passagem, 4810)
    Game.removeItemInPosition(passagem, 4808)
    return true
end

local Step4_out = MoveEvent()
function Step4_out.onStepOut(creature, item, position, fromPosition)
    local passagem = Position(32851, 32309, 11)
    local tile = Tile(passagem)
    if tile then
        local ground = tile:getGround()
        if ground then
            ground:transform(598)
        end
    end
    
    Game.createItem(4810, 1, passagem)
    Game.createItem(4808, 1, passagem)
    return true
end

Step4_in:aid(6638)
Step4_in:register()
Step4_out:aid(6638)
Step4_out:register()

local Step4_lever1 = Action()

function Step4_lever1.onUse(player, item, fromPosition, target, toPosition)
    Game.removeItemInPosition(Position(32860, 32313, 11), 387)
    switch_lever(item, LEVER_ON)
    return true
end

Step4_lever1:aid(6639)
Step4_lever1:register()

local Step4_lever2 = Action()

function Step4_lever2.onUse(player, item, fromPosition, target, toPosition)

    local passagem = Position(32861, 32304, 11)
    local tile = Tile(passagem)
    if tile then
        local ground = tile:getGround()
        if ground then
            ground:transform(1284)
        end
    end

    Game.removeItemInPosition(passagem, 4810)
    Game.removeItemInPosition(passagem, 4808)
    
    switch_lever(item, LEVER_ON)
    return true
end

Step4_lever2:aid(6640)
Step4_lever2:register()

-- A última alavaca mantém a pedra por 15 minutos e depois "volta"

-- Etapa 5
-- AID 6608 - um player precisa ficar em cima do sqm indicado na posição 32862 32285 12 para aparecer a escada item (1386) no sqm  32854 32321 11 ( obs: caso o player saída do sqm, a escada é removida )

local Step5_in = MoveEvent()

function Step5_in.onStepIn(creature, item, position, fromPosition)
    if not Game.isItemInPosition(Position(32854, 32321, 11), 1386) then
        Game.createItem(1386, 1, Position(32854, 32321, 11))
    end
    return true
end

local Step5_out = MoveEvent()

function Step5_out.onStepOut(creature, item, position, fromPosition)
    Game.removeItemInPosition(Position(32854, 32321, 11), 1386)
    return true
end

Step5_in:uid(1008)
Step5_in:register()

Step5_out:uid(1008)
Step5_out:register()

-- Etapa 6
-- AID 1009 - Alvanca para remover a pedra  32852 32319 9

local Step6 = Action()

function Step6.onUse(player, item, fromPosition, target, toPosition)
    local groundPosition = Position(32852, 32319, 9)
    Game.removeItemInPosition(groundPosition, 1304)
    switch_lever(item, LEVER_ON)
    return true
end

Step6:uid(1009)
Step6:register()

-- Etapa 7
-- LABIRINTO
-- AID 6610 - Teleporte para o sqm {x = 32827, y = 32314, z = 9}
-- AID 6611 - Teleporte para o sqm {x = 32841, y = 32322, z = 9}
-- AID 6612 - Teleporte para o sqm {x = 32855, y = 32296, z = 9}
-- AID 6613 - Teleporte para o sqm {x = 32840, y = 32317, z = 9}
-- AID 6614 - Teleporte para o sqm {x = 32854, y = 32323, z = 9}
-- AID 6615 - Teleporte para o sqm {x = 32858, y = 32297, z = 9}
-- AID 6616 - Teleporte para o sqm {x = 32856, y = 32289, z = 9}

local MazePositions = {
    [1010] = Position(32827, 32314, 9),
    [1011] = Position(32841, 32322, 9),
    [1012] = Position(32855, 32296, 9),
    [1013] = Position(32840, 32317, 9),
    [1014] = Position(32854, 32323, 9),
    [1015] = Position(32858, 32297, 9),
    [1016] = Position(32856, 32289, 9)
}

local Step7 = MoveEvent()

function Step7.onStepIn(creature, item, position, fromPosition)
    local teleportPosition = MazePositions[item:getUniqueId()]
    if not teleportPosition then
        return false
    end

    creature:teleportTo(teleportPosition)
    return true
end

Step7:uid(1010)
Step7:uid(1011)
Step7:uid(1012)
Step7:uid(1013)
Step7:uid(1014)
Step7:uid(1015)
Step7:uid(1016)

Step7:register()

-- Etapa 8
-- AID 6620 - LABIRINTO (TELEPORTS/SQM NÃO PISAR)
-- Ao pisar no sqm com essa action teleportar o player para o sqm 32854, 32318, 9

local Step8 = MoveEvent()

function Step8.onStepIn(creature, item, position, fromPosition)
    creature:teleportTo(Position(32854, 32318, 9))
    return true
end

Step8:aid(6620)
Step8:register()


-- Etapa 9
-- UID 1021 - puxar alavanca para abrir passagem da pedra 32849, 32282, 10

local Step9 = Action()

function Step9.onUse(player, item, fromPosition, target, toPosition)
    local groundPosition = Position(32849, 32282, 10)
    Game.removeItemInPosition(groundPosition, 1304)
    switch_lever(item, LEVER_ON)
    return true
end

Step9:uid(1021)
Step9:register()

--AID 6641: Jogador cai uma posição z

local Step9_fall = MoveEvent()

function Step9_fall.onStepIn(creature, item, position, fromPosition)
    position.z = position.z + 1
    creature:teleportTo(position)
    return true
end

Step9_fall:aid(6641)
Step9_fall:register()

-- Etapa 10
-- UID 1022 - ao pisar no sqm  32826 32273 11 teleportar para o sqm 32826 32273 12

local Step10 = MoveEvent()

function Step10.onStepIn(creature, item, position, fromPosition)
    creature:teleportTo(Position(32826, 32273, 12))
    return true
end

Step10:uid(1022)
Step10:register()

-- Etapa 11
-- seal/salas principais e alavancas
-- UID 1030 - puxar alavanca e remover pedra do sqm 32822 32234 12
-- UID 1031 - puxar alavanca e remover pedra do sqm 32826 32234 12
-- UID 1032 - puxar alavanca e remover pedra do sqm 32824 32230 12
-- UID 1033 - puxar alavanca e remover pedra do sqm 32824 32229 12
-- UID 1034 - puxar alavanca e remover pedra do sqm 32824 32228 12
-- UID 1035 - puxar alavanca e remover pedra do sqm 32824 32227 12 - e criar um portal no sqm 32813 32343 15 com destino para a sala principal 32824 32242 12
-- UID 1036 - puxar alavanca e remover pedra do sqm 32824 32226 12

local levers_to_stone = {
    [1030] = Position(32824, 32225, 12),
    [1031] = Position(32824, 32231, 12),
    [1032] = Position(32824, 32230, 12),
    [1033] = Position(32824, 32229, 12),
    [1034] = Position(32824, 32228, 12),
    [1035] = Position(32824, 32227, 12),
    [1036] = Position(32824, 32226, 12)
}

local Step11 = Action()

function Step11.onUse(player, item, fromPosition, target, toPosition)
    local stonePosition = levers_to_stone[item:getUniqueId()]
    Game.removeItemInPosition(stonePosition, 1304)
    switch_lever(item, LEVER_ON)

    if item:getUniqueId() == 1035 then
        local portalPosition = Position(32813, 32343, 15)
        if not Game.isItemInPosition(portalPosition, 1387) then
            doCreateTeleport(1387, Position(32824, 32242, 12), portalPosition)
        end
    end

    return true
end

Step11:uid(1030, 1031, 1032, 1033, 1034, 1035, 1036)
Step11:register()
