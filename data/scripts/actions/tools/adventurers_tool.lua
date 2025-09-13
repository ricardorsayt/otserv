local action = Action()

function action.onUse(player, item, fromPosition, target, toPosition)


    -- machete
    if target.itemid == 1499 then
        toPosition:sendMagicEffect(CONST_ME_POFF)
        target:remove()
        return true
    end

    local grass = jungleGrass[target.itemid]
    if grass then
        target:transform(grass)
        target:decay()
        return true
    end

    local tile = Tile(toPosition)
    if not tile then
        return false
    end
    
    
    local itemType = ItemType(target.itemid)
    if itemType and itemType:getGroup() == ITEM_GROUP_SPLASH then
        target = tile:getGround()
    end
    
    if table.contains(holes, target.itemid) then -- shovel
        target:transform(target.itemid + 1)
        target:decay()

        toPosition.z = toPosition.z + 1
        tile:relocateTo(toPosition)
        return true
    elseif table.contains(sandIds, target.itemid) then -- shovel
        local randomValue = randomNumber(1, 100)
        if target.actionid == actionIds.sandHole and randomValue <= 20 then
            target:transform(489)
            target:decay()
        else
            checkScarabTile(toPosition)
        end
        toPosition:sendMagicEffect(CONST_ME_POFF)
        return true
    elseif table.contains(ropeSpots, target.itemid) then -- rope
        tile = Tile(toPosition:moveUpstairs())
        if not tile then
            return false
        end

        if tile:hasFlag(TILESTATE_PROTECTIONZONE) and player:isPzLocked() then
            player:sendCancelMessage(RETURNVALUE_PLAYERISPZLOCKED)
            return true
        end

        player:teleportTo(toPosition, false)
        return true
    elseif table.contains(holeId, target.itemid) then -- rope
        toPosition.z = toPosition.z + 1
        tile = Tile(toPosition)
        if not tile then
            return false
        end

        local thing = tile:getBottomCreature() or tile:getTopDownItem()
        if not thing then
            return true
        end

        if thing:isCreature() then
            return thing:teleportTo(toPosition:moveUpstairs(), false)
        elseif thing:isItem() and thing:getType():isMovable() then
            return thing:moveTo(toPosition:moveUpstairs())
        end

        return true
    end

    return false
end

action:id(5160)
action:register()