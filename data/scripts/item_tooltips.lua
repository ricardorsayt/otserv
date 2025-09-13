local specialSkills = {
    [SPECIALSKILL_CRITICALHITCHANCE] = "cc",
    [SPECIALSKILL_CRITICALHITAMOUNT] = "ca",
    [SPECIALSKILL_LIFELEECHCHANCE] = "lc",
    [SPECIALSKILL_LIFELEECHAMOUNT] = "la",
    [SPECIALSKILL_MANALEECHCHANCE] = "mc",
    [SPECIALSKILL_MANALEECHAMOUNT] = "ma"
}

local skills = {
    [SKILL_FIST] = "fist",
    [SKILL_AXE] = "axe",
    [SKILL_SWORD] = "sword",
    [SKILL_CLUB] = "club",
    [SKILL_DISTANCE] = "dist",
    [SKILL_SHIELD] = "shield",
    [SKILL_FISHING] = "fish"
}

local stats = {
    [STAT_MAGICPOINTS] = "mag",
    [STAT_MAXHITPOINTS] = "maxhp",
    [STAT_MAXMANAPOINTS] = "maxmp"
}

local statsPercent = {
    [STAT_MAXHITPOINTS] = "maxhp_p",
    [STAT_MAXMANAPOINTS] = "maxmp_p"
}

local combatTypeNames = {
    [COMBAT_PHYSICALDAMAGE] = "Physical",
    [COMBAT_ENERGYDAMAGE] = "Energy",
    [COMBAT_EARTHDAMAGE] = "Earth",
    [COMBAT_FIREDAMAGE] = "Fire",
    [COMBAT_LIFEDRAIN] = "Lifedrain",
    [COMBAT_MANADRAIN] = "Manadrain",
    [COMBAT_HEALING] = "Healing",
    [COMBAT_ICEDAMAGE] = "Ice",
    --[[[COMBAT_DROWNDAMAGE] = "Drown",
    [COMBAT_HOLYDAMAGE] = "Holy",
    [COMBAT_DEATHDAMAGE] = "Death"]]
}

local combatShortNames = {
    [COMBAT_PHYSICALDAMAGE] = "a_phys",
    [COMBAT_ENERGYDAMAGE] = "a_ene",
    [COMBAT_EARTHDAMAGE] = "a_earth",
    [COMBAT_FIREDAMAGE] = "a_fire",
    [COMBAT_LIFEDRAIN] = "a_ldrain",
    [COMBAT_MANADRAIN] = "a_mdrain",
    [COMBAT_HEALING] = "a_heal",
    [COMBAT_ICEDAMAGE] = "a_ice",
    --[[[COMBAT_DROWNDAMAGE] = "a_drown",
    [COMBAT_HOLYDAMAGE] = "a_holy",
    [COMBAT_DEATHDAMAGE] = "a_death"]]
}

local customAttributes = {
    [ITEM_RND_ATTACK] = "attrAttack",
	[ITEM_RND_ARMOR] = "attrArmor",
	[ITEM_RND_DEF] = "attrDef",
	[ITEM_RND_SKILL] = "attrSkill",
--	[ITEM_RND_MAGIC] = "attrMagic",
	[ITEM_RND_WEIGHT_REDUCTION] = "attrWeightReduction",
	[ITEM_RND_MANA_REGEN] = "attrManaRegen",
	[ITEM_RND_HEALTH_REGEN] = "attrHpRegen",
	[ITEM_RND_MAX_HEALTH] = "attrMaxHp",
	[ITEM_RND_MAX_MANA] = "attrMaxMana",
	[ITEM_RND_RESIST_PHYSICAL] = "attrPhysical",
	[ITEM_RND_RESIST_FIRE] = "attrResistFire",
	[ITEM_RND_RESIST_POISON] = "attrResisPoison",
	[ITEM_RND_RESIST_ENERGY] = "attrResistEnergy",
    [ITEM_RND_RESIST_ICE] = "attrResistIce",
	[ITEM_RND_ATTACK_SPEED] = "attrAtkSpeed",
	[ITEM_RND_CRITICAL] = "attrCritical",
	[ITEM_RND_PARRY] = "attrParry",
	[ITEM_RND_PERSEVERANCE] = "attrPerseverance",
	[ITEM_RND_BERSERK] = "attrBerserk",
	[ITEM_RND_CRUSHING_BLOW] = "attrCrushingBlow",
	[ITEM_RND_FAST_HAND] = "attrFastHand",
	[ITEM_RND_SHARPSHOOTER] = "attrSharpShooter",
	[ITEM_RND_BLEEDING] = "attrBleeding",
	[ITEM_RND_ELETRICFYING] = "attrEletricfying",
	[ITEM_RND_BURNING] = "attrBurning",
	[ITEM_RND_POISONING] = "attrPoisoning",
    [ITEM_RND_SPEED] = "attrSpeed",
}

local ITEM_RARITY_ATTRIBUTE = "ry"

local LoginEvent = CreatureEvent("TooltipsLogin")

function LoginEvent.onLogin(player)
  player:registerEvent("TooltipsExtended")
  return true
end

local ExtendedEvent = CreatureEvent("TooltipsExtended")


function fluidTypeIdToName(id)
	if id == 1 then 
		return "water"
	elseif id == 2 then 
		return "wine"
	elseif id == 3 then 
		return "beer"
	elseif id == 4 then 
		return "mud"
	elseif id == 5 then 
		return "blood"
	elseif id == 6 then 
		return "slime"
	elseif id == 7 then 
		return "oil"
	elseif id == 8 then 
		return "urine"
	elseif id == 9 then 
		return "milk"
	elseif id == 10 then 
		return "manafluid"
	elseif id == 11 then 
		return "lifefluid"
	elseif id == 12 then 
		return "lemonade"
	end
end


function ExtendedEvent.onExtendedOpcode(player, opcode, buffer)
    if opcode == GameServerOpcodes.GameServerTooltip then
        local status, data =
            pcall(
            function()
                return json.decode(buffer)
            end
        )
        if not status or not data then
            return
        end

        if #data == 4 then
          local pos = Position(data[1], data[2], data[3], data[4])
          local item = player:getItem(pos)
          player:sendItemTooltip(item)
        elseif #data == 1 then
          local item = Game.getRealUniqueItem(data[1])
          if item then
            player:sendItemTooltip(item)
          end
        end
    end
end

function Player:sendItemTooltip(item)
    if item then
        local item_data = item:buildTooltip()
        if item_data then
            self:sendExtendedOpcode(GameServerOpcodes.GameServerTooltip, json.encode({action = "new", data = item_data}))
        end
    end
end

function Item:buildTooltip()
    local uid = self:getRealUID()
    local itemType = self:getType()
    local item_data = {
        uid = uid,
        itemName = itemType:getName(),
        clientId = itemType:getClientId()
    }

    if itemType:isRune() then
        item_data.spell_rune = itemType:getSpellRune()
    end
	
	if itemType:isFluidContainer() and self:getFluidType() ~= 0 then
		item_data.itemName = item_data.itemName .. " of " .. fluidTypeIdToName(self:getFluidType())
	end
	
    item_data.count = self:getCount()
    item_data.charges = self:getCharges()
    if itemType:getDescription():len() > 0 then
        item_data.desc = itemType:getDescription()
    end

    if (self:getCustomAttribute("ITEM_CUSTOM_ATTRIBUTE_DESCRIPTION")) then
        if not item_data.desc then
            item_data.desc = ""
        end
        item_data.desc = item_data.desc .. "\n" .. self:getCustomAttribute("ITEM_CUSTOM_ATTRIBUTE_DESCRIPTION")
    end

    if self:getId() == 1990 and self:getSpecialDescription():len() > 0 then
        if not item_data.desc then
            item_data.desc = ""
        end
        item_data.desc = item_data.desc .. "\n" .. self:getSpecialDescription()
    end

    if itemType:getRequiredLevel() >= 1 then
        item_data.reqLvl = itemType:getRequiredLevel()
    end

    local implicit = {}

    if itemType:getElementType() ~= COMBAT_NONE and combatTypeNames[itemType:getElementType()] then
        implicit.eleDmg = "+" .. itemType:getElementDamage() .. " " .. combatTypeNames[itemType:getElementType()] .. " Damage"
    end

    local allprot = itemType:getAbsorbPercent(0)

    if allprot ~= 0 then
        for i = 0, COMBAT_COUNT - 1 do
            if itemType:getAbsorbPercent(i) ~= allprot then
                allprot = 0
                break
            end
        end
    end

    if allprot == 0 then
        for i = 0, COMBAT_COUNT - 1 do
            if itemType:getAbsorbPercent(i) ~= 0 then
                local combatType = bit.lshift(1, i)
                if combatType ~= COMBAT_UNDEFINEDDAMAGE then
                    implicit[combatShortNames[combatType]] = itemType:getAbsorbPercent(i)
                end
            end
        end
    else
        implicit.a_all = allprot
    end

    for key, value in pairs(specialSkills) do
        local s = itemType:getSpecialSkill(key)
        if s and s >= 1 then
            implicit[value] = s
        end
    end

    for key, value in pairs(skills) do
        local s = itemType:getSkill(key)
        if s and s >= 1 then
            implicit[value] = s
        end
    end

    for key, value in pairs(stats) do
        local s = itemType:getStat(key)
        if s and s >= 1 then
            implicit[value] = s
        end
    end

    for key, value in pairs(statsPercent) do
        local s = itemType:getStatPercent(key)
        if s and s >= 1 then
            implicit[value] = s - 100
        end
    end

    -- get custom attributes
    for key, value in pairs(customAttributes) do
        local customAttr = self:getCustomAttribute(key)
        if customAttr ~= nil then
            implicit[value] = customAttr
        end
    end

    if self:getAttribute(ITEM_ATTRIBUTE_ATTACK_SPEED) > 0 then
        item_data.attackSpeed = self:getAttribute(ITEM_ATTRIBUTE_ATTACK_SPEED)
    else
        item_data.attackSpeed = itemType:getAttackSpeed()
    end

    if itemType:hasShowDuration() then
        if self:hasAttribute(ITEM_ATTRIBUTE_DURATION) then
            item_data.duration = self:getAttribute(ITEM_ATTRIBUTE_DURATION) / 1000
        else
            item_data.duration = 0
        end
    else
        item_data.duration = -1
    end

    local healthGain = itemType:getHealthGain()
    if healthGain and healthGain > 0 then
        implicit.hpgain = healthGain
    end

    local healthTicks = itemType:getHealthTicks()
    if healthTicks and healthTicks > 0 then
        implicit.hpticks = healthTicks
    end

    local manaGain = itemType:getManaGain()
    if manaGain and manaGain > 0 then
        implicit.mpgain = manaGain
    end

    local manaTicks = itemType:getManaTicks()
    if manaTicks and manaTicks > 0 then
        implicit.mpticks = manaTicks
    end

    local speed = itemType:getSpeed() or 0
    if self:getCustomAttribute(ITEM_RND_SPEED) then
        speed = speed + self:getCustomAttribute(ITEM_RND_SPEED) * 5
    end

    if speed and speed > 0 then
        implicit.speed = speed
    end

    if self:isContainer() then
        implicit.cap = self:getCapacity()
    end

    if next(implicit) ~= nil then
        item_data.imp = implicit
    end

    --  get rarity
    local rarityAttr = self:getCustomAttribute(ITEM_RARITY_ATTRIBUTE) 
    local requiredLevelAttr = self:getItemTierRarity()
    if rarityAttr ~= nil then
        item_data.rarityId = rarityAttr
    end

    if requiredLevelAttr ~= nil then
        item_data.requiredLevelAttr = requiredLevelAttr
    end

    item_data.stackable = itemType:isStackable()
    item_data.itemType = formatItemType(itemType)
    local bonusStatArmor = self:getCustomAttribute(ITEM_RND_ARMOR) or 0
    if (itemType:getArmor() + bonusStatArmor) > 0 then
        if bonusStatArmor and bonusStatArmor > 0 then
            item_data.armor = itemType:getArmor() + bonusStatArmor
        elseif self:getAttribute(ITEM_ATTRIBUTE_ARMOR) > 0 then
            item_data.armor = self:getAttribute(ITEM_ATTRIBUTE_ARMOR)
        else
            item_data.armor = itemType:getArmor()
        end
    elseif itemType:getShootRange() > 1 then
        local bonusStat = self:getCustomAttribute(ITEM_RND_ATTACK)
        if bonusStat and bonusStat > 0 then
            item_data.attack = itemType:getAttack() + bonusStat
        elseif self:getAttribute(ITEM_ATTRIBUTE_ATTACK) > 0 then
            item_data.attack = self:getAttribute(ITEM_ATTRIBUTE_ATTACK)
        else
            item_data.attack = itemType:getAttack()
        end
        if self:getAttribute(ITEM_ATTRIBUTE_HITCHANCE) > 0 then
            item_data.hitChance = self:getAttribute(ITEM_ATTRIBUTE_HITCHANCE)
        else
            item_data.hitChance = itemType:getHitChance()
        end
        item_data.shootRange = itemType:getShootRange()
    elseif itemType:getAttack() > 0 then
        local bonusStat = self:getCustomAttribute(ITEM_RND_ATTACK)
        if bonusStat and bonusStat > 0 then
            item_data.attack = itemType:getAttack() + bonusStat
        elseif self:getAttribute(ITEM_ATTRIBUTE_ATTACK) > 0 then
            item_data.attack = self:getAttribute(ITEM_ATTRIBUTE_ATTACK)
        else
            item_data.attack = itemType:getAttack()
        end
        local bonusStat = self:getCustomAttribute(ITEM_RND_DEF)
        if bonusStat and bonusStat > 0 then
            item_data.defense = itemType:getDefense() + bonusStat
        elseif self:getAttribute(ITEM_ATTRIBUTE_DEFENSE) > 0 then
            item_data.defense = self:getAttribute(ITEM_ATTRIBUTE_DEFENSE)
        else
            item_data.defense = itemType:getDefense()
        end
        if self:getAttribute(ITEM_ATTRIBUTE_EXTRADEFENSE) > 0 then
            item_data.extraDefense = self:getAttribute(ITEM_ATTRIBUTE_EXTRADEFENSE)
        else
            item_data.extraDefense = itemType:getExtraDefense()
        end
    elseif itemType:getDefense() > 0 then
        local bonusStat = self:getCustomAttribute(ITEM_RND_DEF)
        if bonusStat and bonusStat > 0 then
            item_data.defense = itemType:getDefense() + bonusStat
        elseif self:getAttribute(ITEM_ATTRIBUTE_DEFENSE) > 0 then
            item_data.defense = self:getAttribute(ITEM_ATTRIBUTE_DEFENSE)
        else
            item_data.defense = itemType:getDefense()
        end
        if self:getAttribute(ITEM_ATTRIBUTE_EXTRADEFENSE) > 0 then
            item_data.extraDefense = self:getAttribute(ITEM_ATTRIBUTE_EXTRADEFENSE)
        else
            item_data.extraDefense = itemType:getExtraDefense()
        end
    end

    item_data.weight = self:getWeight()
    return item_data
end

function ItemType:buildTooltip(count)
    if not count then
        count = 1
    end

    local item_data = {
        clientId = self:getClientId(),
        count = count,
        itemName = self:getName()
    }

    if self:getDescription():len() > 0 then
        item_data.desc = self:getDescription()
    end

    if self:getRequiredLevel() >= 1 then
        item_data.reqLvl = self:getRequiredLevel()
    end

    local implicit = {}

    if self:getElementType() ~= COMBAT_NONE and combatTypeNames[self:getElementType()] then
        implicit.eleDmg = "Attack +" .. self:getElementDamage() .. " " .. combatTypeNames[self:getElementType()]
    end

    local allprot = self:getAbsorbPercent(0)

    if allprot ~= 0 then
        for i = 0, COMBAT_COUNT - 1 do
            if self:getAbsorbPercent(i) ~= allprot then
                allprot = 0
                break
            end
        end
    end

    if allprot == 0 then
        for i = 0, COMBAT_COUNT - 1 do
            if self:getAbsorbPercent(i) ~= 0 then
                local combatType = bit.lshift(1, i)
                if combatType ~= COMBAT_UNDEFINEDDAMAGE then
                    implicit[combatShortNames[combatType]] = self:getAbsorbPercent(i)
                end
            end
        end
    else
        implicit.a_all = allprot
    end

    for key, value in pairs(stats) do
        local s = self:getStat(key)
        if s and s >= 1 then
            implicit[value] = s
        end
    end

    for key, value in pairs(statsPercent) do
        local s = self:getStatPercent(key)
        if s and s >= 1 then
            implicit[value] = s - 100
        end
    end

    local healthGain = self:getHealthGain()
    if healthGain and healthGain > 0 then
        implicit.hpgain = healthGain
    end

    local healthTicks = self:getHealthTicks()
    if healthTicks and healthTicks > 0 then
        implicit.hpticks = healthTicks
    end

    local manaGain = self:getManaGain()
    if manaGain and manaGain > 0 then
        implicit.mpgain = manaGain
    end

    local manaTicks = self:getManaTicks()
    if manaTicks and manaTicks > 0 then
        implicit.mpticks = manaTicks
    end

    local speed = self:getSpeed() or 0
    if self:getCustomAttribute(ITEM_RND_SPEED) then
        speed = speed + self:getCustomAttribute(ITEM_RND_SPEED) * 5
    end

    if speed and speed > 0 then
        implicit.speed = speed
    end

    if self:isContainer() then
        implicit.cap = "Capacity " .. self:getCapacity()
    end

    if next(implicit) ~= nil then
        item_data.imp = implicit
    end

    item_data.self = formatItemType(self)
    local armor = self:getArmor()
    if self:getCustomAttribute(ITEM_RND_ARMOR) then
        armor = armor + self:getCustomAttribute(ITEM_RND_ARMOR)
    end

    if armor > 0 then
        item_data.armor = armor
    elseif self:getShootRange() > 1 then
        item_data.attack = self:getAttack()
        item_data.hitChance = self:getHitChance()
        item_data.shootRange = self:getShootRange()
    elseif self:getAttack() > 0 then
        item_data.attack = self:getAttack()
        item_data.defense = self:getDefense()
        item_data.extraDefense = self:getExtraDefense()
    elseif self:getDefense() > 0 then
        item_data.defense = self:getDefense()
        item_data.extraDefense = self:getExtraDefense()
    end

    item_data.weight = self:getWeight() * item_data.count
    return item_data
end

function formatItemType(itemType)
    local weaponType = itemType:getWeaponType()

    if weaponType ~= WEAPON_SHIELD then
        local slotPosition = itemType:getSlotPosition() - SLOTP_LEFT - SLOTP_RIGHT -  SLOTP_AMMO

        if slotPosition == SLOTP_TWO_HAND and weaponType == WEAPON_SWORD then
            return "Two-Handed Sword"
        elseif slotPosition == SLOTP_TWO_HAND and weaponType == WEAPON_CLUB then
            return "Two-Handed Club"
        elseif slotPosition == SLOTP_TWO_HAND and weaponType == WEAPON_AXE then
            return "Two-Handed Axe"
        elseif weaponType == WEAPON_SWORD then
            return "Sword"
        elseif weaponType == WEAPON_CLUB then
            return "Club"
        elseif weaponType == WEAPON_AXE then
            return "Axe"
        elseif weaponType == WEAPON_DISTANCE then
            return "Distance"
        elseif weaponType == WEAPON_WAND then
            return "Wand"
        elseif slotPosition == SLOTP_HEAD then
            return "Helmet"
        elseif slotPosition == SLOTP_NECKLACE then
            return "Necklace"
        elseif slotPosition == SLOTP_ARMOR then
            return "Armor"
        elseif slotPosition == SLOTP_LEGS then
            return "Legs"
        elseif slotPosition == SLOTP_FEET then
            return "Boots"
        elseif slotPosition == SLOTP_RING then
            return "Ring"
        elseif itemType:getAmmoType() > 0 then
            return "Ammunition"
        elseif itemType:isRune() then
            return "Rune"
        elseif itemType:isContainer() then
            return "Container"
        elseif itemType:isFluidContainer() then
            return "Potion"
        elseif itemType:isUseable() then
            return "Usable"
        end
    else
        return "Shield"
    end

    return "Common"
end

LoginEvent:type("login")
LoginEvent:register()
ExtendedEvent:type("extendedopcode")
ExtendedEvent:register()
