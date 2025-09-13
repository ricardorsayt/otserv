local spell = Spell(SPELL_INSTANT)

function spell.onCastSpell(creature, variant)
    local position = creature:getPosition()
    position:getNextPosition(creature:getDirection())

    local tile = Tile(position)
    if not tile then
        position:sendMagicEffect(CONST_ME_POFF)
        return false
    end

    local thing = tile:getTopVisibleThing(creature)
    if not thing then
        position:sendMagicEffect(CONST_ME_POFF)
        return false
    end

    local items = tile:getItems()
    if items then
        for i, item in ipairs(items) do
            if item:getType():isMovable() and item:getUniqueId() > 65535 and item:getActionId() == 0 and not table.contains(corpseIds, item:getId()) then
                item:remove()
            end

            if i == 500 then
                break
            end
        end
    end

    position:sendMagicEffect(CONST_ME_MAGIC_RED)

    return true
end

spell:needLearn(true)
spell:mana(60)
spell:magicLevel(7)
spell:isAggressive(false)
spell:name("Desintegrate Spell")
spell:vocation("Druid", "Elder Druid")
spell:words("ex,ito, tera")
spell:category(SPELL_CATEGORY_INSTANT)
spell:register()
