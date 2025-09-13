local allOrbs = {5570, 5571, 5572, 5573}

local orbExtractorBreakChance = 50

local forbiddenItems = {
	[5548] = true,  -- Ravenor Shield
	[5549] = true,  -- Ravenor Boots
}

local orbs = {
	props = {
		[5570] = {
			tier = 1, 
			cost = {
				[1] = {price = 1250},
				[2] = {price = 2500},
				[3] = {price = 3750},
				[4] = {price = 5000}
			}
		},

		[5571] = {
			tier = 2, 
			cost = {
				[1] = {price = 2500},
				[2] = {price = 5000},
				[3] = {price = 7500},
				[4] = {price = 10000}
			}
		},

		[5572] = {
			tier = 3, 
			cost = {
				[1] = {price = 5000},
				[2] = {price = 10000},
				[3] = {price = 15000},
				[4] = {price = 20000}
			}
		},

		[5573] = {
			tier = 4, 
			cost = {
				[1] = {price = 10000},
				[2] = {price = 20000},
				[3] = {price = 30000},
				[4] = {price = 40000}
			}
		},
	},

	rarity = {
		[1] = {sucessChance = 25, breakChance = 5},
		[2] = {sucessChance = 20, breakChance = 5},
		[3] = {sucessChance = 15, breakChance = 5},
		[4] = {sucessChance = 10, breakChance = 5}
	},
}

local upgrade = Action()
function upgrade.onUse(player, item, fromPos, target, toPos, isHotkey)

	local orbProp = orbs.props[item:getId()]
	if orbProp then
		if target then
			if target:isItem() then
				if math.floor(target:getItemTierRarity()) == orbProp.tier then
					local itemOrigin = ItemType(target:getId())
					if itemOrigin then
						local checkAttr = false
						if itemOrigin:isWeapon() or itemOrigin:isShield()
						or itemOrigin:isHelmet() or itemOrigin:isArmor()
						or itemOrigin:isLegs() or itemOrigin:isBoots() then
							checkAttr = true
						end

						if checkAttr then
							if forbiddenItems[target:getId()] then
								player:sendTextMessage(MESSAGE_STATUS_CONSOLE_RED, "This item cannot receive upgrade.")
								return false
							end
							local rarity = math.floor(target:getItemRarity() > 0 and target:getItemRarity() or 1)
							if rarity > 4 then
								player:sendTextMessage(MESSAGE_STATUS_CONSOLE_RED, "Your item has already reached maximum rarity!")
								return false
							end

							if player:removeMoney(orbProp.cost[rarity].price) then
								local rarityProp = orbs.rarity[rarity]
								if math.random(1, 100) <= rarityProp.breakChance then
									player:sendTextMessage(MESSAGE_STATUS_CONSOLE_RED, "Your item broke.")
									player:getPosition():sendMagicEffect(CONST_ME_POFF)
									target:remove(1)
									return false
								end

								if math.random(1, 100) <= rarityProp.sucessChance then
									player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, "Rarity successfully applied.")									
									target:rollRarity(rarity+1)
									player:getPosition():sendMagicEffect(CONST_ME_MAGIC_GREEN)
								else
									player:sendTextMessage(MESSAGE_STATUS_CONSOLE_ORANGE, "Rarity application failed.")
									player:getPosition():sendMagicEffect(CONST_ME_POFF)
								end
								
								item:remove(1)
							else
								player:sendTextMessage(MESSAGE_STATUS_CONSOLE_RED, "You don't have enough money.")
							end
						else
							player:sendTextMessage(MESSAGE_STATUS_CONSOLE_RED, "You cannot use Orbs on non-equipment items")
						end
					end
				else
					player:sendTextMessage(MESSAGE_STATUS_CONSOLE_RED, "You can only use this Orb on items Tier "..orbProp.tier..".")
				end
			else
				player:sendTextMessage(MESSAGE_STATUS_CONSOLE_RED, "You can only use Orbs on equipment items.")
			end
		end
	end

	return true
end
for _, orb in pairs(allOrbs) do
	upgrade:id(orb)
end
upgrade:register()

local action = Action()

function action.onUse(player, item, fromPos, target, toPos, isHotkey)

	local soulBound = item:getCustomAttribute("soulbound")
	if not soulBound then
		item:setCustomAttribute("soulbound", player:getGuid())
		item:setCustomAttribute("ITEM_CUSTOM_ATTRIBUTE_DESCRIPTION", "This item is soul bound to " .. player:getName() .. ".")
	else
		if tonumber(soulBound) ~= player:getGuid() then
			player:sendCancelMessage("This item is soul bound to another player.")
			return true
		end
	end

	if target and target:isItem() then
		local itemTier = target:getItemTierRarity()
		local itemRarity = target:getItemRarity() - 1

		if itemRarity > 0 then
			target:remove(1)
			player:addItem(allOrbs[itemTier], itemRarity)
			player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE,
				"You extracted successfully " .. math.floor(itemRarity) .. " Orbs from a Tier " .. math.floor(itemTier) .. " item.")

			if item:getId() == 5574 and math.random(1, 100) <= orbExtractorBreakChance then
				item:remove(1)
			end
		else
			player:sendTextMessage(MESSAGE_STATUS_CONSOLE_RED, "You can only extract Orbs from items with rarity.")
		end
	end

	return true
end
action:id(5574)
action:id(5575)
action:register()