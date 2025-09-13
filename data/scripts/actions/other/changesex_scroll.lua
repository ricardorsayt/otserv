local outfits = {
    [1] = {male = 128, female = 136},
    [2] = {male = 129, female = 137},
    [3] = {male = 130, female = 138},
    [4] = {male = 131, female = 139},
    [5] = {male = 132, female = 140},
    [6] = {male = 133, female = 141},
    [7] = {male = 134, female = 142},
    [8] = {male = 145, female = 148},
    [9] = {male = 146, female = 149},
    [10] = {male = 147, female = 150},
    [11] = {male = 152, female = 153},
    [12] = {male = 255, female = 270},
    [13] = {male = 256, female = 271},
    [14] = {male = 257, female = 272},
    [15] = {male = 258, female = 273},
    [16] = {male = 259, female = 274},
    [17] = {male = 260, female = 275},
    [18] = {male = 261, female = 276},
    [19] = {male = 262, female = 277},
    [20] = {male = 263, female = 278},
    [21] = {male = 264, female = 279},
    [22] = {male = 265, female = 280},
    [23] = {male = 266, female = 281},
    [24] = {male = 267, female = 282},
    [25] = {male = 268, female = 283},
    [26] = {male = 269, female = 284},
    [27] = {male = 285, female = 286},
    [28] = {male = 329, female = 330},
    [29] = {male = 332, female = 333},
    [30] = {male = 335, female = 336},
    [31] = {male = 337, female = 338},
    [32] = {male = 341, female = 342},
    [33] = {male = 343, female = 344},
    [34] = {male = 160, female = 345},
    [35] = {male = 334, female = 344},
    [36] = {male = 335, female = 336},
    [37] = {male = 350, female = 351},
	[38] = {male = 352, female = 353},
}


local function findCurrentOutfit(outfit)
	local lookType = outfit.lookType
	
	for i = 1, #outfits do
		if outfits[i].female == lookType or outfits[i].male == lookType then
            return outfits[i]
        end
    end
end

local function onUse(player, item, fromPosition, target, toPosition, isHotkey)
    local outfit = player:getOutfit()
    local sex = player:getSex()
    local currentOutfit = findCurrentOutfit(outfit)

    if sex == PLAYERSEX_FEMALE then
        outfit.lookType = currentOutfit.male
        for i = 1, #outfits do
            if player:hasOutfit(outfits[i].female, 3) then
                player:addOutfit(outfits[i].male)
                player:addOutfitAddon(outfits[i].male, 3)

            elseif player:hasOutfit(outfits[i].female, 2) then
                player:addOutfit(outfits[i].male)
                player:addOutfitAddon(outfits[i].male, 2)

            elseif player:hasOutfit(outfits[i].female, 1) then
                player:addOutfit(outfits[i].male)
                player:addOutfitAddon(outfits[i].male, 1)

            elseif player:hasOutfit(outfits[i].female) then
                player:addOutfit(outfits[i].male)
            end
        end
		
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You are now male!")
        player:setSex(PLAYERSEX_MALE)
		player:setOutfit(outfit)
        item:remove(1)
		
    else
        outfit.lookType = currentOutfit.female
        for i = 1, #outfits do
            if player:hasOutfit(outfits[i].male, 3) then
                player:addOutfit(outfits[i].female)
                player:addOutfitAddon(outfits[i].female, 3)

            elseif player:hasOutfit(outfits[i].male, 2) then
                player:addOutfit(outfits[i].female)
                player:addOutfitAddon(outfits[i].female, 2)

            elseif player:hasOutfit(outfits[i].male, 1) then
                player:addOutfit(outfits[i].female)
                player:addOutfitAddon(outfits[i].female, 1)

            elseif player:hasOutfit(outfits[i].male) then
                player:addOutfit(outfits[i].female)
            end
        end
		
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You are now female!")
        player:setSex(PLAYERSEX_FEMALE)
		player:setOutfit(outfit)
        item:remove(1)
    end
    return true
end

local action = Action()
function action.onUse(player, item, fromPosition, target, toPosition, isHotkey)
    return onUse(player, item, fromPosition, target, toPosition, isHotkey)
end

action:id(5110)
action:register()