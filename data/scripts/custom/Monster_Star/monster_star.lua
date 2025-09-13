local CONFIG = {
    SPAWN_RANGE_TOLERANCE = 5,
    ON_COMPLETE = {
        [1] = 30,
        [2] = 60,
        [3] = 180,
        [4] = 520,
        [5] = 1560
     },
     ON_KILL = {
        [STAR_ONE] = 5,
        [STAR_TWO] = 10,
        [STAR_THREE] = 15
     }
}

local function random(chance, maxValue)
    local random_num = math.random(maxValue)
    if random_num <= chance then
        return true
    else
        return false
    end
end

function Monster:adjustMonsterStar(pos, stage)

    if not stage or stage == STAR_NONE then
        return
    end

    pos:sendMagicEffect(CONST_ME_TELEPORT)

    local config = geBestiaryConfigByStarAndExperience(self:getType():experience(), stage)
    local health = self:getMaxHealth()
    local speed = self:getBaseSpeed()
    health = health + (health * (config.health / 100))
    speed = speed + (speed * (config.speed / 100))

    --BUFF MONSTER HEALTH:
    self:setMaxHealth(health)
    self:setHealth(health)

    -- BUFF MONSTER SPEED:
    self:setBaseSpeed(speed)

    self:setStar(stage)
    self:registerEvent("BestiaryHealthChange")

    local master = self:getMaster()
    if master then
        if not master:isRemoved() then
            return true
        end
    end
end

local function addExtraLoot(corpse, items, randomCount)
    if items then
        for _, data in pairs(items) do
            local chance = getLootRandom()
            if data.chance > chance then
                local item = corpse:addItem(data.itemid, data.getCount(), INDEX_WHEREEVER, FLAG_IGNOREAUTOSTACK)
                if item then
                    item:rollRarity()
                end
            end
        end
    end
end

G_MONSTERSTAR.processExtraLoot = function(monster, corpse)
    local star = monster:getStar()
    if G_MONSTERSTAR.EXTRA_LOOT[star] then
        addExtraLoot(corpse, G_MONSTERSTAR.EXTRA_LOOT[star][monster:getName()])
        addExtraLoot(corpse, G_MONSTERSTAR.EXTRA_LOOT[star]["Every Elite"])
    end
end

G_MONSTERSTAR.processDeath = function(monster, player, test)
    local mType = MonsterType(monster:getName())
    if not mType then
        return
    end

    if not mType:haveBestiary() or monster:getStar() > 0 or monster:getMaster() then
        return
    end

    local position = monster:getPosition()
    local stage = player:getBestiaryStage(mType)

    if stage == BESTIARY_STAGE_NONE then
        return
    end

    local BORN_ELITE_CHANCE = 0.02 -- 2% de chance de vir uma elite

    -- Dado que será elite, a chance de vir cada uma das estrelas possíveis
    if random(10000 * BORN_ELITE_CHANCE, 10000) then
        local chance = math.random(0, 1000)

        if stage == STAR_ONE then
            stage = STAR_ONE
            -- Redundante, mas é para deixar claro que é uma estrela 1
        elseif stage == STAR_TWO then
            local TWO_STAR_CHANCE = 1/3 -- 33.3% de ser estrela 2
            -- local ONE_STAR_CHANCE = 2/3 -- 66.7% de ser estrela 1 -- É redundante!

            if chance <= 1000 * TWO_STAR_CHANCE then
                stage = STAR_TWO
            else
                stage = STAR_ONE
            end

        elseif stage == STAR_THREE then
            
            local THREE_STAR_CHANCE = 0.10 -- 10% de ser estrela 3
            local TWO_STAR_CHANCE = 0.30 -- 30% de ser estrela 2
            local ONE_STAR_CHANCE = 0.60 -- 60% de ser estrela 1


            if chance <= 1000 * THREE_STAR_CHANCE then
                stage = STAR_THREE
            elseif chance <= 1000 * (THREE_STAR_CHANCE + TWO_STAR_CHANCE) then
                stage = STAR_TWO
            else
                stage = STAR_ONE
            end
        end



        local name = mType:name()
        
        local function announce_spawn(tick, pos, dummyId, canceled)
            local effectPos = Position(pos.x + 1, pos.y + 1, pos.z)
            
            if (tick == 9) then
                addEvent(function()
                    if (canceled) then
                        return true
                    end
    
                    local poshash = pos.x .. pos.y .. pos.z
                    if not G_MONSTERSTAR.DATA[poshash] then
                        G_MONSTERSTAR.DATA[poshash] = {
                            name = "",
                            stage = 0
                        }
    
                        G_MONSTERSTAR.DATA[poshash].name = mType:name()
                        G_MONSTERSTAR.DATA[poshash].stage = stage
                    end
                    local monsterDummy = Creature(dummyId)
                    if (monsterDummy) then
                        monsterDummy:remove()
                    end
                    Game.createMonster(name, pos, true)
                    G_MONSTERSTAR.DATA[poshash] = nil
                end, 500)
                return true
            end
			
            if (tick % 4 == 0) then
                if (tick ~= 8) then
                    effectPos:sendMagicEffect(32)
                end
            end

            if (tick == 8) then
                local monsterDummy = Creature(dummyId)
                if (not monsterDummy) then
                    addEvent(function()
                        effectPos:sendMagicEffect(34)
                    end, 800)
                    canceled = true
                else
                    addEvent(function()
                        effectPos:sendMagicEffect(33)
                    end, 800)
                end
            end
                    
            addEvent(announce_spawn, 1000, tick+1, pos, dummyId, canceled)
        end

        local dummy = Game.createMonster("elite", position, true)
        if (dummy) then
            dummy:setStar(stage)
            local effectPos = Position(position.x + 1, position.y + 1, position.z)
            effectPos:sendMagicEffect(31)
            addEvent(function() announce_spawn(0, position, dummy:getId(), false) end, 900)
        end
    end
end

G_MONSTERSTAR.processSpawn = function(monster, pos)
    
    local master = monster:getMaster()
    if master and master:isMonster() then
        if not master:isRemoved() then
            if not master:isElite() or master:getType():isBoss() then
                return
            end
            
            monster:adjustMonsterStar(pos, master:getStar())
        end
    elseif monster:getType():isBoss() then
        local chance = math.random(0, 100)
        if chance < 17 then -- 1/3 de 50% de chance de vir estrela 3
            monster:adjustMonsterStar(pos, STAR_THREE)
        elseif chance < 33 then -- 1/3 de 50% de chance de vir estrela 2
            monster:adjustMonsterStar(pos, STAR_TWO)
        elseif chance < 50 then -- 1/3 de 50% de chance de vir estrela 1
            monster:adjustMonsterStar(pos, STAR_ONE)
        else
            -- 50% de chance de vir normal
            return 
        end
    else
        local poshash = pos.x .. pos.y .. pos.z
        
        if not G_MONSTERSTAR.DATA[poshash] then
            return true
        end
        
        if monster:getName():lower() ~= G_MONSTERSTAR.DATA[poshash].name:lower() then
            return
        end

        monster:adjustMonsterStar(pos, G_MONSTERSTAR.DATA[poshash].stage)
        
        G_MONSTERSTAR.DATA[poshash] = nil
    end
end

G_MONSTERSTAR.processPoints = function(player, monster)
    local monsterType = monster:getType()
    local raceId = monsterType:bestiaryId()
    local star = monster:getStar()
    local mastery =  monsterType:bestiaryMastery()

    --Process complete bestiary:
    if player:getBestiaryKill(raceId) == mastery then
        local points = CONFIG.ON_COMPLETE[monsterType:bestiaryDifficulty()]
        G_MONSTERSTAR.addPoints(player, points)
    end

    if CONFIG.ON_KILL[star] then
        G_MONSTERSTAR.addPoints(player, CONFIG.ON_KILL[star])
    end
end

G_MONSTERSTAR.addPoints = function(player, point)
    local points = player:getStorageValue(G_MONSTERSTAR.STR_BESTIARY_POINTS)
    player:setStorageValue(G_MONSTERSTAR.STR_BESTIARY_POINTS, points + point)
    return true
end

G_MONSTERSTAR.getPoints = function(player)
    return player:getStorageValue(G_MONSTERSTAR.STR_BESTIARY_POINTS)
end

function Monster:isElite()
    return self:getStar() > STAR_NONE
end