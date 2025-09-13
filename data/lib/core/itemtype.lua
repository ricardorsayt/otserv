local slotBits = {
	[CONST_SLOT_HEAD] = SLOTP_HEAD,
	[CONST_SLOT_NECKLACE] = SLOTP_NECKLACE,
	[CONST_SLOT_BACKPACK] = SLOTP_BACKPACK,
	[CONST_SLOT_ARMOR] = SLOTP_ARMOR,
	[CONST_SLOT_RIGHT] = SLOTP_RIGHT,
	[CONST_SLOT_LEFT] = SLOTP_LEFT,
	[CONST_SLOT_LEGS] = SLOTP_LEGS,
	[CONST_SLOT_FEET] = SLOTP_FEET,
	[CONST_SLOT_RING] = SLOTP_RING,
	[CONST_SLOT_AMMO] = SLOTP_AMMO
}

function ItemType.usesSlot(self, slot)
	return bit.band(self:getSlotPosition(), slotBits[slot] or 0) ~= 0
end

function ItemType:isHelmet()
	return self:usesSlot(CONST_SLOT_HEAD)
end

function ItemType:isArmor()
	return self:usesSlot(CONST_SLOT_ARMOR)
end

function ItemType:isLegs()
	return self:usesSlot(CONST_SLOT_LEGS)
end

function ItemType:isBoots()
	return self:usesSlot(CONST_SLOT_FEET)
end

local notWeapons = {WEAPON_NONE, WEAPON_SHIELD, WEAPON_AMMO}
function ItemType:isWeapon()
	return not table.contains(notWeapons, self:getWeaponType())
end

function ItemType:isShield()
	return self:getWeaponType() == WEAPON_SHIELD
end