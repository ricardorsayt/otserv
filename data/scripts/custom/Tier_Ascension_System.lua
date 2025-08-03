
--[[
    ========================================
    TIER UPGRADE SYSTEM + ABILITIES + NECKLACE DROP BOOST
    ========================================
    
    Developed by: Mateus Roberto (mateuskl)
    Date: 30/07/2025
    Version: v1.1
    
    ========================================
    HOW IT WORKS:
    ========================================
    
    FORGE STYLE SYSTEM:
    - Uses specific items for upgrade (8302, 8303, 8304)
    - Tier system (1-10) with success chances
    - Classification system (Base ? Improved ? Exalted)
    - Automatic abilities by slot:
      * HAND: Onslaught (critical damage +60%)
      * ARMOR: Ruse (dodge system)
      * LEGS: Transcendence (automatic Avatar)
      * HEAD: Momentum (cooldown reduction)
      * FEET: Amplification (amplifies other abilities)
      * NECKLACE: Lucky Drop (increases drop rate)
    
    UPGRADE ITEMS:
    - 8302: Reset (removes tier and classification)
    - 8303: Tier Upgrade (increases tier 1-10)
    - 8304: Classification Upgrade (Base ? Improved ? Exalted)
    - 8305: Dodge Boost (+50 dodge)
    - 8306: Speed Boost (+10 speed)
    
    TRANSCENDENCE SYSTEM (LEGS):
    - Requires Tier 3+ (no classification requirement)
    - Automatic chance per attack (any type: melee, rune, spell)
    - Tier 3: 5% chance per attack
    - Avatar duration: 7 seconds fixed
    - Activates automatically when chance triggers
    
    REQUIREMENTS:
    - Item must have 'classification' in items.xml
    - Item must be in tierableItems list
    - Player must have specific upgrade item
    
    ========================================
]]


local abilityConfig = {
    ["hand"] = {
        name = "Onslaught",
        description = "Critical damage system like Imbuements, adds 60% extra damage",
        activationChances = {
            [1] = 0.50, [2] = 1.05, [3] = 1.70, [4] = 2.45, [5] = 3.30,
            [6] = 4.25, [7] = 5.30, [8] = 6.45, [9] = 7.70, [10] = 9.05
        }
    },
    ["armor"] = {
        name = "Ruse", 
        description = "Dodge system like Charms, without restrictions",
        activationChances = {
            [1] = 0.50, [2] = 1.03, [3] = 1.62, [4] = 2.28, [5] = 3.00,
            [6] = 3.78, [7] = 4.62, [8] = 5.52, [9] = 6.48, [10] = 7.51
        }
    },
    ["head"] = {
        name = "Momentum",
        description = "Reduces cooldown of secondary group spells by 2 seconds when logout block is active",
        activationChances = {
            [1] = 2.00, [2] = 4.05, [3] = 6.20, [4] = 8.45, [5] = 10.80,
            [6] = 13.25, [7] = 15.80, [8] = 18.45, [9] = 21.20, [10] = 24.05
        }
    },
    ["legs"] = {
        name = "Transcendence",
        description = "Activates vocation's level 3 avatar for a shorter period",
        activationChances = {
            [1] = 0.13, [2] = 0.27, [3] = 0.44, [4] = 0.64, [5] = 0.86,
            [6] = 1.11, [7] = 1.38, [8] = 1.68, [9] = 2.00, [10] = 2.35
        }
    },
    ["feet"] = {
        name = "Amplification",
        description = "Amplifies the effect of tiered items, increasing their activation chance",
        activationChances = {
            [1] = 2.50, [2] = 5.40, [3] = 9.10, [4] = 13.60, [5] = 18.90,
            [6] = 25.00, [7] = 31.90, [8] = 39.60, [9] = 48.10, [10] = 57.40
        }
    },
    ["necklace"] = {
        name = "Lucky Drop",
        description = "Increases drop rate from monsters",
        dropBoost = {
            [1] = 5, [2] = 10, [3] = 15, [4] = 20, [5] = 25,
            [6] = 30, [7] = 35, [8] = 40, [9] = 45, [10] = 50
        }
    }
}

local slotToAbility = {
    ["hand"] = "onslaught",
    ["armor"] = "ruse", 
    ["head"] = "momentum",
    ["legs"] = "transcendence",
    ["feet"] = "amplification",
    ["necklace"] = "lucky_drop"
}

local function getActivationChance(abilityType, tier)
    local slot = nil
    for slotName, ability in pairs(slotToAbility) do
        if ability == abilityType then
            slot = slotName
            break
        end
    end
    
    if not slot or not abilityConfig[slot] then
        return 0
    end
    
    return abilityConfig[slot].activationChances[tier] or 0
end

local function getDropBoost(tier)
    return abilityConfig["necklace"].dropBoost[tier] or 0
end

local function isWeapon(item)
    if not item then
        return false
    end
    local attack = item:getAttack()
    return attack > 0
end

local function calculateTotalChance(player, baseChance, abilityType)
    if abilityType == "amplification" then
        return baseChance
    end
    
    local boots = player:getSlotItem(CONST_SLOT_FEET)
    if boots then
        local bootsTier = boots:getAttribute(ITEM_ATTRIBUTE_TIER) or 0
        if bootsTier > 0 then
            local amplificationChance = getActivationChance("amplification", bootsTier)
            -- Amplification aumenta a chance em 50% do seu valor
            local amplificationBonus = (amplificationChance * 0.5) / 100
            baseChance = baseChance * (1 + amplificationBonus)
        end
    end
    
    return baseChance
end

local dodgeStorage = 45001
local dodgeCooldownStorage = 45002
local conditionSubId = 45083

local tierConfig = {
        maxTier = 10,
    
    classifications = {
        [0] = "Base",
        [1] = "Improved", 
        [2] = "Exalted"
    },
    
    dodgePerTier = 50,
    
    statsPerTier = {}
}

local tierableItems = {

    -- ARMOR ITEMS
    [2139] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- ancient tiara
    [2171] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- platinum amulet
    [2323] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- hat of the mad
    [2339] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- damaged helmet
    [2342] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- helmet of the ancients
    [2343] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- helmet of the ancients
    [2358] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- pair of ultra boots
    [2457] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- steel helmet
    [2458] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- chain helmet
    [2459] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- iron helmet
    [2460] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- brass helmet
    [2461] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- leather helmet
    [2462] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- devil helmet
    [2463] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- plate armor
    [2464] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- chain armor
    [2465] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- brass armor
    [2466] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- golden armor
    [2467] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- leather armor
    [2468] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- studded legs
    [2469] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- dragon scale legs
    [2470] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- golden legs
    [2471] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- golden helmet
    [2472] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- magic plate armor
    [2473] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- viking helmet
    [2474] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- winged helmet
    [2475] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- warrior helmet
    [2476] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- knight armor
    [2477] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- knight legs
    [2478] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- brass legs
    [2479] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- strange helmet
    [2480] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- legion helmet
    [2481] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- soldier helmet
    [2482] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- studded helmet
    [2483] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- scale armor
    [2484] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- studded armor
    [2485] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- doublet
    [2486] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- noble armor
    [2487] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- crown armor
    [2488] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- crown legs
    [2489] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- dark armor
    [2490] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- dark helmet
    [2491] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- crown helmet
    [2492] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- dragon scale mail
    [2493] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- demon helmet
    [2494] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- demon armor
    [2495] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- demon legs
    [2496] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- horned helmet
    [2497] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- crusader helmet
    [2498] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- royal helmet
    [2499] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- amazon helmet
    [2500] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- amazon armor
    [2501] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- ceremonial mask
    [2502] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- dwarven helmet
    [2503] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- dwarven armor
    [2504] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- dwarven legs
    [2505] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- elven mail
    [2506] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- dragon scale helmet
    [2507] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- elven legs
    [2508] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- native armor
    [2641] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- patched boots
    [2643] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- leather boots
    [2645] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- steel boots
    [2646] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- golden boots
    [2647] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- plate legs
    [2648] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- chain legs
    [2649] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- leather legs
    [2650] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- jacket
    [2651] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- coat
    [2652] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- green tunic
    [2653] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- red tunic
    [2654] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- cape
    [2655] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- red robe
    [2656] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- blue robe
    [2660] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- ranger's cloak
    [2661] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- scarf
    [2662] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- magician hat
    [2663] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- mystic turban
    [2664] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- wood cape
    [2665] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- post officer's hat
    [3967] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- tribal mask
    [3968] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- leopard armor
    [3969] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- horseman helmet
    [3970] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- feather headdress
    [3971] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- charmer's tiara
    [3972] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- bonelord helmet
    [3982] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- crocodile boots
    [5461] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- helmet of the deep
    [5462] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- pirate boots
    [5741] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- skull helmet
    [5903] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- Ferumbras' hat
    [5917] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- bandana
    [5918] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- pirate knee breeches
    [6095] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- pirate shirt
    [6096] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- pirate hat
    [6301] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- death ring
    [6531] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- santa hat
    [6578] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- party hat
    [7457] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- fur boots
    [7458] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- fur cap
    [7459] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- pair of earmuffs
    [7461] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- krimhorn helmet
    [7462] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- ragnir helmet
    [7463] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- mammoth fur cape
    [7464] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- mammoth fur shorts
    [7730] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- blue legs
    [7884] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- terra mantle
    [7885] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- terra legs
    [7886] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- terra boots
    [7891] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- magma boots
    [7892] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- glacier shoes
    [7893] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- lightning boots
    [7894] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- magma legs
    [7895] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- lightning legs
    [7896] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- glacier kilt
    [7897] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- glacier robe
    [7898] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- lightning robe
    [7899] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- magma coat
    [7900] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- magma monocle
    [7901] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- lightning headband
    [7902] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- glacier mask
    [7903] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- terra hood
    [7939] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- mining helmet
    [7957] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- jester hat
    [8819] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- magician's robe
    [8820] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- mage hat
    [8821] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- witchhunter's coat
    [8865] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- dark lord's cape
    [8866] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- robe of the ice queen
    [8867] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- dragon robe
    [8868] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- velvet mantle
    [8869] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- greenwood coat
    [8870] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- spirit cloak
    [8871] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- focus cape
    [8872] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- belted cape
    [8873] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- hibiscus dress
    [8874] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- summer dress
    [8875] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- tunic
    [8876] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- girl's dress
    [8877] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- lavos armor
    [8878] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- crystalline armor
    [8879] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- voltage armor
    [8880] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- swamplair armor
    [8881] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- fireborn giant armor
    [8882] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- earthborn titan armor
    [8883] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- windborn colossus armor
    [8884] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- oceanborn leviathan armor
    [8885] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- divine plate
    [8886] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- molten plate
    [8887] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- frozen plate
    [8888] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- master archer's armor
    [8889] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- skullcracker armor
    [8890] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- robe of the underworld
    [8891] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- paladin armor
    [8892] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- ethno coat
    [8923] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- ranger legs
    [9776] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- yalahari armor
    [9777] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- yalahari leg piece
    [9778] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- yalahari mask
    [9932] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- firewalker boots
    [9933] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- firewalker boots
    [10016] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- batwing hat
    [10291] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- odd hat
    [10296] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- heavy metal t-shirt
    [10298] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- helmet of ultimate terror
    [10299] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- helmet of nature
    [10300] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- trousers of the ancients
    [10316] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- mighty helm of green sparks
    [10317] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- the rain coat
    [10363] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- the rain coat
    [10570] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- witch hat
    [11117] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- crystal boots
    [11118] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- dragon scale boots
    [11240] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- guardian boots
    [11301] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- Zaoan armor
    [11302] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- Zaoan helmet
    [11303] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- Zaoan shoes
    [11304] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- Zaoan legs
    [11355] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- spellweaver's robe
    [11356] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- Zaoan robe
    [11368] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- jade hat
    [12424] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- ornamented brooch
    [12541] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- helmet of the deep
    [12607] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- elite draken mail
    [12630] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- cobra crown
    [12642] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- royal draken mail
    [12643] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- royal scale robe
    [12645] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- elite draken helmet
    [12646] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- draken boots
    [12656] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- sedge hat
    [12657] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- old cape
    [13756] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- mage's cap
    [15406] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- ornate chestplate
    [15407] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- depth lorica
    [15408] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- depth galea
    [15409] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- depth ocrea
    [15410] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- depth calcei
    [15412] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- ornate legs
    [15489] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- calopteryx cape
    [15490] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- grasshopper legs
    [15651] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- depth galea
    [18398] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- gill gugel
    [18399] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- gill coat
    [18400] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- gill legs
    [18403] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- prismatic helmet
    [18404] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- prismatic armor
    [18405] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- prismatic legs
    [18406] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- prismatic boots
    [20109] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- buckle
    [20126] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- leather harness
    [20132] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- helmet of the lost
    [21691] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- shrunken head necklace
    [21692] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- albino plate
    [21693] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- horn
    [21700] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- icy culottes
    [21706] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- goo shell
    [21725] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- furious frock
    [22518] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- broken visor
    [23535] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- glooth cape
    [23536] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- rubber cap
    [23537] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- mooh'tah plate
    [23538] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- heat core
    [23539] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- alloy legs
    [23540] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- metal spats
    [23541] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- gearwheel chain
    [24261] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- crest of the deep seas
    [24637] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- oriental shoes
    [24717] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- enchanted werewolf amulet
    [24718] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- werewolf helmet
    [24741] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- fur armor
    [24742] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- badger boots
    [24743] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- wereboar loincloth
    [24744] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- Enchanted werewolf helmet
    [24788] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- enchanted werewolf helmet
    [24790] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- enchanted werewolf amulet
    [24848] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- shamanic mask
    [24851] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- onyx pendant
    [25174] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- fireheart cuirass
    [25175] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- fireheart hauberk
    [25176] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- fireheart platemail
    [25177] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- Earthheart cuirass
    [25178] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- Earthheart hauberk
    [25179] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- Earthheart platemail
    [25180] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- thunderheart cuirass
    [25181] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- thunderheart hauberk
    [25182] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- thunderheart platemail
    [25183] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- frostheart cuirass
    [25184] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- frostheart hauberk
    [25185] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- frostheart platemail
    [25186] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- firesoul tabard
    [25187] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- Earthsoul tabard
    [25188] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- thundersoul tabard
    [25189] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- frostsoul tabard
    [25190] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- firemind raiment
    [25191] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- Earthmind raiment
    [25192] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- thundermind raiment
    [25193] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- frostmind raiment
    [25410] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- visage of the end days
    [25412] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- treader of torment
    [25413] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- shroud of despair
    [25423] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- Ferumbras' amulet
    [25424] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- Ferumbras' amulet
    [25429] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- boots of homecoming
    [25430] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- boots of homecoming
    [26131] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- tiara of power
    [26132] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- void boots
    [27065] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- Ferumbras' Candy Hat
    [27070] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- chocolatey dragon scale legs
    [27072] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- tatty Dragon scale legs
    [27073] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- rusty winged helmet
    [27077] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- filthy bunnyslippers
    [27756] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- porcelain mask
    [29003] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- butterfly ring
    [29079] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- swan feather cloak
    [29423] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- leaf crown
    [29424] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- iron crown
    [29425] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- incandescent crown
    [29426] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- reflecting crown
    [30800] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- foxtail amulet
    [30882] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- gnome helmet
    [30883] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- gnome armor
    [30884] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- gnome legs
    [33032] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- ornate chestplate(test)
    [33216] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- falcon circlet
    [33217] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- falcon coif
    [33221] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- falcon plate
    [33222] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- falcon greaves
    [33308] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- rotten demonbone
    [33309] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- energized demonbone
    [33310] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- unliving demonbone
    [33311] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- sulphurous demonbone
    [33911] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- living armor
    [33916] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- dream shroud
    [33917] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- pair of dreamwalkers
    [33920] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- dark whispers
    [34912] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- yetislippers
    [35037] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- rainbow necklace
    [35056] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- enchanted sleep shawl
    [35058] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- enchanted pendulet
    [35108] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- cobra boots
    [35111] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- cobra hood
    [35115] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- amulet of theurgy
    [35116] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- enchanted amulet of theurgy
    [36152] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- sphinx tiara
    [36270] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- enchanted pendulet
    [36291] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- terra helmet
    [36292] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- bear skin
    [36293] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- embrace of nature
    [36296] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- galea mortis
    [36297] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- toga mortis
    [36331] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- winged boots
    [36345] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- the cobra amulet
    [36823] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- lederhosen
    [36824] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- traditional leather shoes
    [36825] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- traditional shirt
    [36826] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- traditional gamsbart hat
    [37343] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- fabulous legs
    [37344] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- soulful legs
    [37345] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- pair of nightmare boots
    [37354] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- ghost chestplate
    [37431] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- pair of old bracers
    [39560] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- lion spangenhelm
    [39561] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- lion plate
    [39562] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- lion amulet
    [42057] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- Eldritch Cuirass
    [42061] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- Eldritch Breeches
    [42064] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- Eldritch Cowl
    [42065] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- Eldritch Hood
    [43000] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- green demon legs
    [43001] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- green demon armor
    [43002] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- green demon helmet
    [43004] = {maxTier = 10, maxClassification = 2, slot = "armor"}, -- Morshabaal's mask

 	-- Item Leggings
    [27072] = {maxTier = 10, maxClassification = 1, slot = "legs"}, -- tatty Dragon scale legs (armor: 2)
    [2502] = {maxTier = 10, maxClassification = 1, slot = "legs"}, -- studded legs (armor: 2 - assumido)
    [2508] = {maxTier = 10, maxClassification = 2, slot = "legs"}, -- chain legs (armor: 4 - assumido)
    [2478] = {maxTier = 10, maxClassification = 2, slot = "legs"}, -- brass legs (armor: 6 - assumido)
    [2486] = {maxTier = 10, maxClassification = 3, slot = "legs"}, -- plate legs (armor: 8 - assumido)
[43000] = {maxTier = 10, maxClassification = 3, slot = "legs"}, -- green demon legs (armor: 9)
[2504] = {maxTier = 10, maxClassification = 3, slot = "legs"}, -- dragon scale legs (armor: 10 - assumido)
[2477] = {maxTier = 10, maxClassification = 3, slot = "legs"}, -- knight legs (armor: 10 - assumido)
[2487] = {maxTier = 10, maxClassification = 3, slot = "legs"}, -- golden legs (armor: 11 - assumido)
[2488] = {maxTier = 10, maxClassification = 4, slot = "legs"}, -- demon legs (armor: 12 - assumido)
[2514] = {maxTier = 10, maxClassification = 4, slot = "legs"}, -- magic plate legs (armor: 12 - assumido)
[43034] = {maxTier = 10, maxClassification = 4, slot = "legs"}, -- runic legs (armor: 13 - assumido)
[43049] = {maxTier = 10, maxClassification = 4, slot = "legs"}, -- spectral legs (armor: 14 - assumido)
[43048] = {maxTier = 10, maxClassification = 5, slot = "legs"}, -- soulshredder (armor: 15 - assumido)
[2519] = {maxTier = 10, maxClassification = 5, slot = "legs"}, -- ornate legs (armor: 15 - assumido)
[43015] = {maxTier = 10, maxClassification = 5, slot = "legs"}, -- cobra trousers (armor: 16 - assumido)
[43031] = {maxTier = 10, maxClassification = 5, slot = "legs"}, -- fabulous legs (armor: 16 - assumido)
[43026] = {maxTier = 10, maxClassification = 5, slot = "legs"}, -- primal legs (armor: 16 - assumido)

			-- Classificação 1 (Armor: 1 ou menos)
			[5917] = {maxTier = 10, maxClassification = 1, slot = "head"},  -- bandana (armor: 1 - assumido)
			[6096] = {maxTier = 10, maxClassification = 1, slot = "head"},  -- pirate hat (armor: 1 - assumido)
			[6531] = {maxTier = 10, maxClassification = 1, slot = "head"},  -- santa hat (armor: 1 - assumido)
			[6578] = {maxTier = 10, maxClassification = 1, slot = "head"},  -- party hat (armor: 1 - assumido)
			[7459] = {maxTier = 10, maxClassification = 1, slot = "head"},  -- pair of earmuffs (armor: 1 - assumido)
			[7957] = {maxTier = 10, maxClassification = 1, slot = "head"},  -- jester hat (armor: 1 - assumido)
			[8820] = {maxTier = 10, maxClassification = 1, slot = "head"},  -- mage hat (armor: 1 - assumido)
			[9927] = {maxTier = 10, maxClassification = 1, slot = "head"},  -- flower wreath (armor: 1 - assumido)
			[10016] = {maxTier = 10, maxClassification = 1, slot = "head"}, -- batwing hat (armor: 1 - assumido)
			[10291] = {maxTier = 10, maxClassification = 1, slot = "head"}, -- odd hat (armor: 1 - assumido)
			[10570] = {maxTier = 10, maxClassification = 1, slot = "head"}, -- witch hat (armor: 1 - assumido)
			[12656] = {maxTier = 10, maxClassification = 1, slot = "head"}, -- sedge hat (armor: 1 - assumido)
			[13756] = {maxTier = 10, maxClassification = 1, slot = "head"}, -- mage's cap (armor: 1 - assumido)
			[23536] = {maxTier = 10, maxClassification = 1, slot = "head"}, -- rubber cap (armor: 1 - assumido)
			[2501] = {maxTier = 10, maxClassification = 1, slot = "head"},  -- ceremonial mask (armor: 1 - assumido)
			[2662] = {maxTier = 10, maxClassification = 1, slot = "head"},  -- magician hat (armor: 1 - assumido)
			[2665] = {maxTier = 10, maxClassification = 1, slot = "head"},  -- post officer's hat (armor: 1 - assumido)
			[27065] = {maxTier = 10, maxClassification = 1, slot = "head"}, -- Ferumbras' Candy Hat (armor: 1 - assumido)
			[29423] = {maxTier = 10, maxClassification = 1, slot = "head"}, -- leaf crown (armor: 1 - assumido)
			[36826] = {maxTier = 10, maxClassification = 1, slot = "head"}, -- traditional gamsbart hat (armor: 1 - assumido)
			[37356] = {maxTier = 10, maxClassification = 1, slot = "head"}, -- spooky hood (armor: 1 - assumido)

			-- Classificação 2 (Armor: 2-3)
			[2128] = {maxTier = 10, maxClassification = 2, slot = "head"},  -- crown (armor: 2 - assumido)
			[2139] = {maxTier = 10, maxClassification = 2, slot = "head"},  -- ancient tiara (armor: 2 - assumido)
			[2323] = {maxTier = 10, maxClassification = 2, slot = "head"},  -- hat of the mad (armor: 3 - assumido)
			[2461] = {maxTier = 10, maxClassification = 2, slot = "head"},  -- leather helmet (armor: 1 - assumido)
			[2482] = {maxTier = 10, maxClassification = 2, slot = "head"},  -- studded helmet (armor: 2 - assumido)
			[2499] = {maxTier = 10, maxClassification = 2, slot = "head"},  -- amazon helmet (armor: 3 - assumido)
			[2663] = {maxTier = 10, maxClassification = 2, slot = "head"},  -- mystic turban (armor: 2 - assumido)
			[3967] = {maxTier = 10, maxClassification = 2, slot = "head"},  -- tribal mask (armor: 2 - assumido)
			[3971] = {maxTier = 10, maxClassification = 2, slot = "head"},  -- charmer's tiara (armor: 2 - assumido)
			[7458] = {maxTier = 10, maxClassification = 2, slot = "head"},  -- fur cap (armor: 2 - assumido)
			[7497] = {maxTier = 10, maxClassification = 2, slot = "head"},  -- mining helmet (armor: 2 - assumido)
			[7939] = {maxTier = 10, maxClassification = 2, slot = "head"},  -- mining helmet (armor: 2 - assumido)
			[11368] = {maxTier = 10, maxClassification = 2, slot = "head"}, -- jade hat (armor: 2 - assumido)
			[22518] = {maxTier = 10, maxClassification = 2, slot = "head"}, -- broken visor (armor: 2 - assumido)
			[24848] = {maxTier = 10, maxClassification = 2, slot = "head"}, -- shamanic mask (armor: 2 - assumido)
			[27073] = {maxTier = 10, maxClassification = 2, slot = "head"}, -- rusty winged helmet (armor: 2)
			[29424] = {maxTier = 10, maxClassification = 2, slot = "head"}, -- iron crown (armor: 3 - assumido)

			-- Classificação 3 (Armor: 4-5)
			[2458] = {maxTier = 10, maxClassification = 3, slot = "head"},  -- chain helmet (armor: 4 - assumido)
			[2460] = {maxTier = 10, maxClassification = 3, slot = "head"},  -- brass helmet (armor: 5 - assumido)
			[2473] = {maxTier = 10, maxClassification = 3, slot = "head"},  -- viking helmet (armor: 4 - assumido)
			[2474] = {maxTier = 10, maxClassification = 3, slot = "head"},  -- winged helmet (armor: 5 - assumido)
			[3972] = {maxTier = 10, maxClassification = 3, slot = "head"},  -- bonelord helmet (armor: 4 - assumido)
			[29425] = {maxTier = 10, maxClassification = 3, slot = "head"}, -- incandescent crown (armor: 4 - assumido)
			[29426] = {maxTier = 10, maxClassification = 3, slot = "head"}, -- reflecting crown (armor: 5 - assumido)

			-- Classificação 4 (Armor: 6-7)
			[2457] = {maxTier = 10, maxClassification = 4, slot = "head"},  -- steel helmet (armor: 6 - assumido)
			[2475] = {maxTier = 10, maxClassification = 4, slot = "head"},  -- warrior helmet (armor: 7 - assumido)
			[2481] = {maxTier = 10, maxClassification = 4, slot = "head"},  -- soldier helmet (armor: 6 - assumido)
			[2502] = {maxTier = 10, maxClassification = 4, slot = "head"},  -- dwarven helmet (armor: 6 - assumido)
			[5741] = {maxTier = 10, maxClassification = 4, slot = "head"},  -- skull helmet (armor: 6 - assumido)
			[7900] = {maxTier = 10, maxClassification = 4, slot = "head"},  -- magma monocle (armor: 6 - assumido)
			[7901] = {maxTier = 10, maxClassification = 4, slot = "head"},  -- lightning headband (armor: 6 - assumido)
			[7902] = {maxTier = 10, maxClassification = 4, slot = "head"},  -- glacier mask (armor: 7 - assumido)
			[7903] = {maxTier = 10, maxClassification = 4, slot = "head"},  -- terra hood (armor: 7 - assumido)
			[2466] = {maxTier = 10, maxClassification = 4, slot = "head"},  -- steel helmet (armor: 6 - assumido)
			[2469] = {maxTier = 10, maxClassification = 4, slot = "head"},  -- brass helmet (armor: 7 - assumido)

			-- Classificação 5 (Armor: 8-9)
			[2459] = {maxTier = 10, maxClassification = 5, slot = "head"},  -- iron helmet (armor: 8 - assumido)
			[2479] = {maxTier = 10, maxClassification = 5, slot = "head"},  -- strange helmet (armor: 8 - assumido)
			[2480] = {maxTier = 10, maxClassification = 5, slot = "head"},  -- legion helmet (armor: 8 - assumido)
			[2490] = {maxTier = 10, maxClassification = 5, slot = "head"},  -- dark helmet (armor: 8 - assumido)
			[2497] = {maxTier = 10, maxClassification = 5, slot = "head"},  -- crusader helmet (armor: 8 - assumido)
			[2496] = {maxTier = 10, maxClassification = 5, slot = "head"},  -- horned helmet (armor: 9 - assumido)
			[3969] = {maxTier = 10, maxClassification = 5, slot = "head"},  -- horseman helmet (armor: 9 - assumido)
			[2342] = {maxTier = 10, maxClassification = 5, slot = "head"},  -- helmet of the ancients (armor: 9 - assumido)
			[2343] = {maxTier = 10, maxClassification = 5, slot = "head"},  -- helmet of the ancients (armor: 9 - assumido)

			-- Classificação 6 (Armor: 10-11)
			[2462] = {maxTier = 10, maxClassification = 6, slot = "head"},  -- devil helmet (armor: 10 - assumido)
			[2471] = {maxTier = 10, maxClassification = 6, slot = "head"},  -- golden helmet (armor: 11 - assumido)
			[2491] = {maxTier = 10, maxClassification = 6, slot = "head"},  -- crown helmet (armor: 10 - assumido)
			[2506] = {maxTier = 10, maxClassification = 6, slot = "head"},  -- dragon scale helmet (armor: 10 - assumido)
			[11302] = {maxTier = 10, maxClassification = 6, slot = "head"}, -- Zaoan helmet (armor: 10 - assumido)
			[24718] = {maxTier = 10, maxClassification = 6, slot = "head"}, -- werewolf helmet (armor: 10 - assumido)
			[24744] = {maxTier = 10, maxClassification = 6, slot = "head"}, -- Enchanted werewolf helmet (armor: 11 - assumido)
			[24788] = {maxTier = 10, maxClassification = 6, slot = "head"}, -- enchanted werewolf helmet (armor: 11 - assumido)
			[30882] = {maxTier = 10, maxClassification = 6, slot = "head"}, -- gnome helmet (armor: 10 - assumido)
			[43002] = {maxTier = 10, maxClassification = 6, slot = "head"}, -- green demon helmet (armor: 10)
			[12541] = {maxTier = 10, maxClassification = 6, slot = "head"}, -- helmet of the deep (armor: 11 - assumido)
			[5461] = {maxTier = 10, maxClassification = 6, slot = "head"},  -- helmet of the deep (armor: 11 - assumido)

			-- Classificação 7 (Armor: 12-14)
			[2493] = {maxTier = 10, maxClassification = 7, slot = "head"},  -- demon helmet (armor: 12 - assumido)
			[2498] = {maxTier = 10, maxClassification = 7, slot = "head"},  -- royal helmet (armor: 14 - assumido)
			[7461] = {maxTier = 10, maxClassification = 7, slot = "head"},  -- krimhorn helmet (armor: 13 - assumido)
			[7462] = {maxTier = 10, maxClassification = 7, slot = "head"},  -- ragnir helmet (armor: 12 - assumido)
			[9778] = {maxTier = 10, maxClassification = 7, slot = "head"},  -- yalahari mask (armor: 13 - assumido)
			[10299] = {maxTier = 10, maxClassification = 7, slot = "head"}, -- helmet of nature (armor: 14 - assumido)
			[12630] = {maxTier = 10, maxClassification = 7, slot = "head"}, -- cobra crown (armor: 14 - assumido)
			[12645] = {maxTier = 10, maxClassification = 7, slot = "head"}, -- elite draken helmet (armor: 13 - assumido)
			[15408] = {maxTier = 10, maxClassification = 7, slot = "head"}, -- depth galea (armor: 14 - assumido)
			[15651] = {maxTier = 10, maxClassification = 7, slot = "head"}, -- depth galea (armor: 14 - assumido)
			[18398] = {maxTier = 10, maxClassification = 7, slot = "head"}, -- gill gugel (armor: 12 - assumido)
			[35111] = {maxTier = 10, maxClassification = 7, slot = "head"}, -- cobra hood (armor: 14 - assumido)
			[36152] = {maxTier = 10, maxClassification = 7, slot = "head"}, -- sphinx tiara (armor: 13 - assumido)
			[36291] = {maxTier = 10, maxClassification = 7, slot = "head"}, -- terra helmet (armor: 12 - assumido)

			-- Classificação 8 (Armor: 15-17)
			[5903] = {maxTier = 10, maxClassification = 8, slot = "head"},  -- Ferumbras' hat (armor: 15 - assumido)
			[10298] = {maxTier = 10, maxClassification = 8, slot = "head"}, -- helmet of ultimate terror (armor: 16 - assumido)
			[10316] = {maxTier = 10, maxClassification = 8, slot = "head"}, -- mighty helm of green sparks (armor: 15 - assumido)
			[18403] = {maxTier = 10, maxClassification = 8, slot = "head"}, -- prismatic helmet (armor: 16 - assumido)
			[20132] = {maxTier = 10, maxClassification = 8, slot = "head"}, -- helmet of the lost (armor: 15 - assumido)
			[24261] = {maxTier = 10, maxClassification = 8, slot = "head"}, -- crest of the deep seas (armor: 17 - assumido)
			[25413] = {maxTier = 10, maxClassification = 8, slot = "head"}, -- shroud of despair (armor: 17 - assumido)
			[33920] = {maxTier = 10, maxClassification = 8, slot = "head"}, -- dark whispers (armor: 15 - assumido)
			[36296] = {maxTier = 10, maxClassification = 8, slot = "head"}, -- galea mortis (armor: 15 - assumido)
			[39560] = {maxTier = 10, maxClassification = 8, slot = "head"}, -- lion spangenhelm (armor: 16 - assumido)
			[42064] = {maxTier = 10, maxClassification = 8, slot = "head"}, -- Eldritch Cowl (armor: 16 - assumido)
			[42065] = {maxTier = 10, maxClassification = 8, slot = "head"}, -- Eldritch Hood (armor: 17 - assumido)

			-- Classificação 9 (Armor: 18+)
			[25410] = {maxTier = 10, maxClassification = 9, slot = "head"}, -- visage of the end days (armor: 18 - assumido)
			[33216] = {maxTier = 10, maxClassification = 9, slot = "head"}, -- falcon circlet (armor: 18 - assumido)
			[33217] = {maxTier = 10, maxClassification = 9, slot = "head"}, -- falcon coif (armor: 19 - assumido)
			[43004] = {maxTier = 10, maxClassification = 9, slot = "head"}, -- Morshabaal's mask (armor: 19 - assumido)


    [2161] = {maxTier = 10, maxClassification = 2, slot = "hand"},
    [2162] = {maxTier = 10, maxClassification = 2, slot = "hand"},
    [2163] = {maxTier = 10, maxClassification = 2, slot = "hand"},
    [2164] = {maxTier = 10, maxClassification = 2, slot = "hand"},
    [2400] = {maxTier = 10, maxClassification = 2, slot = "hand"},
    [2401] = {maxTier = 10, maxClassification = 2, slot = "hand"},
    [2402] = {maxTier = 10, maxClassification = 2, slot = "hand"},
    [2403] = {maxTier = 10, maxClassification = 2, slot = "hand"},
    [2404] = {maxTier = 10, maxClassification = 2, slot = "hand"},
    
    [2165] = {maxTier = 10, maxClassification = 2, slot = "head"},
    [2494] = {maxTier = 10, maxClassification = 2, slot = "armor"},
    [2495] = {maxTier = 10, maxClassification = 2, slot = "legs"},
    [2168] = {maxTier = 10, maxClassification = 2, slot = "feet"},
    
    [2169] = {maxTier = 10, maxClassification = 1, slot = "necklace"},
    [2170] = {maxTier = 10, maxClassification = 1, slot = "necklace"},
    [2171] = {maxTier = 10, maxClassification = 1, slot = "necklace"},
    [2172] = {maxTier = 10, maxClassification = 1, slot = "necklace"},
    [2173] = {maxTier = 10, maxClassification = 1, slot = "necklace"},
    [2174] = {maxTier = 10, maxClassification = 1, slot = "necklace"},
    [2175] = {maxTier = 10, maxClassification = 1, slot = "necklace"},
    [2176] = {maxTier = 10, maxClassification = 1, slot = "necklace"},
    [2177] = {maxTier = 10, maxClassification = 1, slot = "necklace"},
    [2178] = {maxTier = 10, maxClassification = 1, slot = "necklace"},
    [2179] = {maxTier = 10, maxClassification = 1, slot = "necklace"},
    [2180] = {maxTier = 10, maxClassification = 1, slot = "necklace"},
    
    [2181] = {maxTier = 10, maxClassification = 1, slot = "ring"},
    [2182] = {maxTier = 10, maxClassification = 1, slot = "backpack"},
    [2183] = {maxTier = 10, maxClassification = 1, slot = "ammo"}
}

local upgradeItems = {
    [8302] = {type = "reset"},
    [8303] = {type = "tier_upgrade"},
    [8304] = {type = "classification_upgrade"},
    [8305] = {type = "stat_boost", stat = "dodge_bonus", value = 50},
    [8306] = {type = "stat_boost", stat = "speed", value = 10}
}


local function getMaxTierForItem(itemId)
    local item = tierableItems[itemId]
    return item and item.maxTier or 0
end

local function getMaxClassificationForItem(itemId)
    local item = tierableItems[itemId]
    return item and item.maxClassification or 0
end

local function getItemTier(tier)
    local itemInfo = {
        TIER0 = {chance = 80},
        TIER1 = {chance = 70},
        TIER2 = {chance = 65},
        TIER3 = {chance = 60},
        TIER4 = {chance = 50},
        TIER5 = {chance = 40},
        TIER6 = {chance = 35},
        TIER7 = {chance = 25},
        TIER8 = {chance = 15},
        TIER9 = {chance = 7},
        TIER10 = {chance = 5}
    }
    local key = "TIER" .. tier
    return itemInfo[key] or {chance = 0}
end

local function getItemClassification(itemId)
    local item = tierableItems[itemId]
    return item and item.maxClassification or 0
end

local function getItemSlot(itemId)
    local item = tierableItems[itemId]
    return item and item.slot or nil
end

local function getClassificationName(classification)
    return tierConfig.classifications[classification] or "Base"
end

local function isItemTierable(item)
    if not item:isItem() then
        return false
    end
    local itemId = item:getId()
    
    if not tierableItems[itemId] then
        return false
    end
    
    local itemType = item:getType()
    local xmlClassification = itemType.classification or 0
    
    return true
end

local function calculateUpgradeChance(currentTier)
    local tierInfo = getItemTier(currentTier)
    return tierInfo.chance or 0
end

local function getItemCustomAttribute(item, attributeName)
    if not item or not item:isItem() then
        return 0
    end
    return item:getCustomAttribute(attributeName) or 0
end

local function setItemCustomAttribute(item, attributeName, value)
    if not item or not item:isItem() then
        return false
    end
    item:setCustomAttribute(attributeName, value)
    return true
end

local function removeItemCustomAttribute(item, attributeName)
    if not item or not item:isItem() then
        return false
    end
    item:removeCustomAttribute(attributeName)
    return true
end


local function updateDodgeStorage(playerId)
    local player = Player(playerId)
    if not player then
        return
    end
    
    local storageValue = 0
    local slotItem = player:getSlotItem(CONST_SLOT_ARMOR)
    
    if slotItem then
        local tier = slotItem:getAttribute(ITEM_ATTRIBUTE_TIER) or 0
        if tier > 0 then
            local activationChance = abilityConfig["armor"].activationChances[tier] or 0
            storageValue = math.floor(activationChance * 100)
        end
    end
    
    player:setStorageValue(dodgeStorage, storageValue)
end


local conditions = {
    ["life increase"] = {CONDITION_PARAM_STAT_MAXHITPOINTS},
    ["mana increase"] = {CONDITION_PARAM_STAT_MAXMANAPOINTS},
    ["speed"] = {CONDITION_PARAM_SPEED},
    ["magic"] = {CONDITION_PARAM_STAT_MAGICPOINTS},
    ["melee"] = {CONDITION_PARAM_SKILL_MELEE},
    ["distance"] = {CONDITION_PARAM_SKILL_DISTANCE},
    ["shield"] = {CONDITION_PARAM_SKILL_SHIELD},
    ["critical hit chance"] = {CONDITION_PARAM_SPECIALSKILL_CRITICALHITCHANCE},
    ["critical hit damage"] = {CONDITION_PARAM_SPECIALSKILL_CRITICALHITAMOUNT},
    ["life leech chance"] = {CONDITION_PARAM_SPECIALSKILL_LIFELEECHCHANCE},
    ["life leech amount"] = {CONDITION_PARAM_SPECIALSKILL_LIFELEECHAMOUNT},
    ["mana leech chance"] = {CONDITION_PARAM_SPECIALSKILL_MANALEECHCHANCE},
    ["mana leech amount"] = {CONDITION_PARAM_SPECIALSKILL_MANALEECHAMOUNT}
}

local function updateStatBonus(playerId)
    local player = Player(playerId)
    if not player then
        return
    end
    
    if player:getCondition(CONDITION_ATTRIBUTES, conditionSubId) then
        player:removeCondition(CONDITION_ATTRIBUTES, conditionSubId)
    end
    if player:getCondition(CONDITION_HASTE, conditionSubId) then
        player:removeCondition(CONDITION_HASTE, conditionSubId)
    end
end


local equipEvent = MoveEvent()
function equipEvent.onEquip(player, item, slot, isCheck)
    if not isCheck then
        local tier = item:getAttribute(ITEM_ATTRIBUTE_TIER) or 0
        if tier > 0 then
            local slotName = getItemSlot(item:getId())
            if slotName == "armor" then
                local activationChance = abilityConfig["armor"].activationChances[tier] or 0
                local currentValue = player:getStorageValue(dodgeStorage) or 0
                local newValue = currentValue + math.floor(activationChance * 100)
                player:setStorageValue(dodgeStorage, newValue)
            end
        end
        addEvent(updateStatBonus, 100, player:getId())
    end
    return true
end
equipEvent:register()

local deEquipEvent = MoveEvent()
function deEquipEvent.onDeEquip(player, item, slot, isCheck)
    if not isCheck then
        local slotName = getItemSlot(item:getId())
        if slotName == "armor" then
            local tier = item:getAttribute(ITEM_ATTRIBUTE_TIER) or 0
            local activationChance = abilityConfig["armor"].activationChances[tier] or 0
            local currentValue = player:getStorageValue(dodgeStorage) or 0
            local newValue = currentValue - math.floor(activationChance * 100)
            player:setStorageValue(dodgeStorage, newValue)
        end
        addEvent(updateStatBonus, 100, player:getId())
    end
    return true
end
deEquipEvent:register()


local dodgeHealthChange = CreatureEvent("onHealthChange_dodgeChance")
function dodgeHealthChange.onHealthChange(creature, attacker, primaryDamage, primaryType, secondaryDamage, secondaryType, origin)
    if not creature:isPlayer() then
        return primaryDamage, primaryType, secondaryDamage, secondaryType
    end
    
    local storageValue = creature:getStorageValue(dodgeStorage) or 0
    local rand = math.random(10000)
    if storageValue > 0 and rand <= storageValue then
        primaryDamage = 0
        secondaryDamage = 0
        creature:getPosition():sendMagicEffect(CONST_ME_DODGE)
        creature:say("Dodged!", TALKTYPE_MONSTER_SAY)
    end
    return primaryDamage, primaryType, secondaryDamage, secondaryType
end
dodgeHealthChange:register()

local dodgeManaChange = CreatureEvent("onManaChange_dodgeChance")
function dodgeManaChange.onManaChange(creature, attacker, primaryDamage, primaryType, secondaryDamage, secondaryType, origin)
    if not creature:isPlayer() then
        return primaryDamage, primaryType, secondaryDamage, secondaryType
    end
    
    local storageValue = creature:getStorageValue(dodgeStorage) or 0
    local rand = math.random(10000)
    if storageValue > 0 and rand <= storageValue then
        primaryDamage = 0
        secondaryDamage = 0
        creature:getPosition():sendMagicEffect(CONST_ME_DODGE)
        creature:say("Dodged!", TALKTYPE_MONSTER_SAY)
    end
    return primaryDamage, primaryType, secondaryDamage, secondaryType
end
dodgeManaChange:register()


local Onslaught1 = CreatureEvent("Onslaught1")
function Onslaught1.onHealthChange(creature, attacker, primaryDamage, primaryType, secondaryDamage, secondaryType, origin)
    if not creature or not attacker or not attacker:isPlayer() then
        return primaryDamage, primaryType, secondaryDamage, secondaryType
    end

    local player = attacker:getPlayer()
    local leftWeapon = player:getSlotItem(CONST_SLOT_LEFT)
    local rightWeapon = player:getSlotItem(CONST_SLOT_RIGHT)
    
    local weapon = leftWeapon or rightWeapon
    if not weapon then
        return primaryDamage, primaryType, secondaryDamage, secondaryType
    end

    if not isWeapon(weapon) then
        return primaryDamage, primaryType, secondaryDamage, secondaryType
    end

    local tier = weapon:getAttribute(ITEM_ATTRIBUTE_TIER) or 0
    if tier == 0 then
        return primaryDamage, primaryType, secondaryDamage, secondaryType
    end

    local activationChance = abilityConfig["hand"].activationChances[tier] or 0
    if activationChance > 0 and math.random(100) <= (activationChance * 100) then
        local damageBoost = math.floor(primaryDamage * 0.60)
        primaryDamage = primaryDamage + damageBoost
        creature:getPosition():sendMagicEffect(CONST_ME_FATAL)
        player:say("Onslaught!", TALKTYPE_MONSTER_SAY)
    end

    return primaryDamage, primaryType, secondaryDamage, secondaryType
end
Onslaught1:register()

local Onslaught2 = CreatureEvent("Onslaught2")
function Onslaught2.onManaChange(creature, attacker, primaryDamage, primaryType, secondaryDamage, secondaryType, origin)
    if not creature or not attacker or not attacker:isPlayer() then
        return primaryDamage, primaryType, secondaryDamage, secondaryType
    end

    local player = attacker:getPlayer()
    local leftWeapon = player:getSlotItem(CONST_SLOT_LEFT)
    local rightWeapon = player:getSlotItem(CONST_SLOT_RIGHT)
    
    local weapon = leftWeapon or rightWeapon
    if not weapon then
        return primaryDamage, primaryType, secondaryDamage, secondaryType
    end

    if not isWeapon(weapon) then
        return primaryDamage, primaryType, secondaryDamage, secondaryType
    end

    local tier = weapon:getAttribute(ITEM_ATTRIBUTE_TIER) or 0
    if tier == 0 then
        return primaryDamage, primaryType, secondaryDamage, secondaryType
    end

    local activationChance = abilityConfig["hand"].activationChances[tier] or 0
    if activationChance > 0 and math.random(100) <= (activationChance * 100) then
        local damageBoost = math.floor(primaryDamage * 0.60)
        primaryDamage = primaryDamage + damageBoost
        creature:getPosition():sendMagicEffect(CONST_ME_FATAL)
        player:say("Onslaught!", TALKTYPE_MONSTER_SAY)
    end

    return primaryDamage, primaryType, secondaryDamage, secondaryType
end
Onslaught2:register()

local momentumHealthChange = CreatureEvent("onHealthChange_momentum")
function momentumHealthChange.onHealthChange(creature, attacker, primaryDamage, primaryType, secondaryDamage, secondaryType, origin)
    if not creature:isPlayer() then
        return primaryDamage, primaryType, secondaryDamage, secondaryType
    end
    
    if primaryDamage > 0 then
        return primaryDamage, primaryType, secondaryDamage, secondaryType
    end
    
    local helmet = creature:getSlotItem(CONST_SLOT_HEAD)
    if helmet then
        local tier = helmet:getAttribute(ITEM_ATTRIBUTE_TIER) or 0
        if tier > 0 then
            handleMomentum(creature)
        end
    end
    
    return primaryDamage, primaryType, secondaryDamage, secondaryType
end
momentumHealthChange:register()

local momentumManaChange = CreatureEvent("onManaChange_momentum")
function momentumManaChange.onManaChange(creature, attacker, primaryDamage, primaryType, secondaryDamage, secondaryType, origin)
    if not creature:isPlayer() then
        return primaryDamage, primaryType, secondaryDamage, secondaryType
    end
    
    if primaryDamage > 0 then
        return primaryDamage, primaryType, secondaryDamage, secondaryType
    end
    
    local helmet = creature:getSlotItem(CONST_SLOT_HEAD)
    if helmet then
        local tier = helmet:getAttribute(ITEM_ATTRIBUTE_TIER) or 0
        if tier > 0 then
            handleMomentum(creature)
        end
    end
    
    return primaryDamage, primaryType, secondaryDamage, secondaryType
end
momentumManaChange:register()

local avatarOutfits = {
    ["knight"] = { lookType = 1823 },
    ["paladin"] = { lookType = 1824 },
    ["sorcerer"] = { lookType = 1825 },
    ["druid"] = { lookType = 1826 }
}

local avatarDurations = {
    [1] = 5000, [2] = 6000, [3] = 7000, [4] = 8000, [5] = 9000,
    [6] = 10000, [7] = 11000, [8] = 12000, [9] = 13000, [10] = 14000
}

local function handleMomentum(player)
    local helmet = player:getSlotItem(CONST_SLOT_HEAD)
    if not helmet then
        return false
    end

    local tier = helmet:getAttribute(ITEM_ATTRIBUTE_TIER) or 0
    if tier == 0 then
        return false
    end

    local activationChance = abilityConfig["head"].activationChances[tier] or 0
    if math.random(100) <= (activationChance * 100) then
        local hasteCondition = Condition(CONDITION_HASTE)
        hasteCondition:setParameter(CONDITION_PARAM_TICKS, 5000)
        hasteCondition:setParameter(CONDITION_PARAM_SPEED, 50)
        player:addCondition(hasteCondition)
        player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
        player:say("Momentum!", TALKTYPE_MONSTER_SAY)
        return true
    end

    return false
end

local function handleTranscendence(player)
    local legs = player:getSlotItem(CONST_SLOT_LEGS)
    if not legs then
        return false
    end
    
    local tier = legs:getAttribute(ITEM_ATTRIBUTE_TIER) or 0
    
    -- Só funciona se tier for 3 ou mais
    if tier < 3 then
        return false
    end
    
    if player:getCondition(CONDITION_OUTFIT) then
        return false
    end
    
    -- Chance baseada no tier (Tier 3 = 5%)
    local chance = 0
    if tier == 3 then
        chance = 5.0
    elseif tier == 4 then
        chance = 8.0
    elseif tier == 5 then
        chance = 12.0
    elseif tier == 6 then
        chance = 16.0
    elseif tier == 7 then
        chance = 20.0
    elseif tier == 8 then
        chance = 25.0
    elseif tier == 9 then
        chance = 30.0
    elseif tier == 10 then
        chance = 35.0
    end
    
    if math.random(100) <= chance then
        local vocation = player:getVocation():getName():lower()
        local outfit = avatarOutfits[vocation] or avatarOutfits["knight"]
        local duration = 7000 -- 7 segundos fixo
        
        local conditionOutfit = Condition(CONDITION_OUTFIT)
        conditionOutfit:setOutfit(outfit)
        conditionOutfit:setParameter(CONDITION_PARAM_TICKS, duration)
        player:addCondition(conditionOutfit)
        
        local conditionBuffs = Condition(CONDITION_ATTRIBUTES, CONDITIONID_COMBAT)
        conditionBuffs:setParameter(CONDITION_PARAM_TICKS, duration)
        conditionBuffs:setParameter(CONDITION_PARAM_STAT_PERCENTDAMAGE, 85)
        conditionBuffs:setParameter(CONDITION_PARAM_SPECIALSKILL_CRITICALHITPERCENT, 100)
        conditionBuffs:setParameter(CONDITION_PARAM_SPECIALSKILL_CRITICALHITAMOUNT, 1500)
        player:addCondition(conditionBuffs)
        
        player:getPosition():sendMagicEffect(CONST_ME_MAGIC_GREEN)
        player:say("Transcendence!", TALKTYPE_MONSTER_SAY)
        
        return true
    end
    
    return false
end

local function tryActivateTranscendence(player)
    local legs = player:getSlotItem(CONST_SLOT_LEGS)
    if not legs then
        return false
    end
    
    local tier = legs:getAttribute(ITEM_ATTRIBUTE_TIER) or 0
    
    if tier < 3 then
        return false
    end
    
    return handleTranscendence(player)
end

local function handleAmplification(player)
    local boots = player:getSlotItem(CONST_SLOT_FEET)
    if not boots then
        return false
    end

    local tier = boots:getAttribute(ITEM_ATTRIBUTE_TIER) or 0
    if tier == 0 then
        return false
    end

    local activationChance = abilityConfig["feet"].activationChances[tier] or 0
    if math.random(100) <= (activationChance * 100) then
        local condition = Condition(CONDITION_ATTRIBUTES, CONDITIONID_COMBAT)
        condition:setParameter(CONDITION_PARAM_TICKS, 10000)
        condition:setParameter(CONDITION_PARAM_SPECIALSKILL_CRITICALHITCHANCE, 25)
        condition:setParameter(CONDITION_PARAM_SPECIALSKILL_CRITICALHITAMOUNT, 500)
        player:addCondition(condition)
        player:getPosition():sendMagicEffect(CONST_ME_MAGIC_RED)
        player:say("Amplification!", TALKTYPE_MONSTER_SAY)
        return true
    end

    return false
end

local transcendenceHealthChange = CreatureEvent("onHealthChange_transcendence")
function transcendenceHealthChange.onHealthChange(creature, attacker, primaryDamage, primaryType, secondaryDamage, secondaryType, origin)
    if not creature:isPlayer() then
        return primaryDamage, primaryType, secondaryDamage, secondaryType
    end
    
    if primaryDamage > 0 then
        return primaryDamage, primaryType, secondaryDamage, secondaryType
    end
    
    local legs = creature:getSlotItem(CONST_SLOT_LEGS)
    if legs then
        local tier = legs:getAttribute(ITEM_ATTRIBUTE_TIER) or 0
        if tier > 0 then
            handleTranscendence(creature)
        end
    end
    
    return primaryDamage, primaryType, secondaryDamage, secondaryType
end
transcendenceHealthChange:register()

local transcendenceManaChange = CreatureEvent("onManaChange_transcendence")
function transcendenceManaChange.onManaChange(creature, attacker, primaryDamage, primaryType, secondaryDamage, secondaryType, origin)
    if not creature:isPlayer() then
        return primaryDamage, primaryType, secondaryDamage, secondaryType
    end
    
    if primaryDamage > 0 then
        return primaryDamage, primaryType, secondaryDamage, secondaryType
    end
    
    local legs = creature:getSlotItem(CONST_SLOT_LEGS)
    if legs then
        local tier = legs:getAttribute(ITEM_ATTRIBUTE_TIER) or 0
        if tier > 0 then
            handleTranscendence(creature)
        end
    end
    
    return primaryDamage, primaryType, secondaryDamage, secondaryType
end
transcendenceManaChange:register()

local transcendenceAttackEvent = CreatureEvent("onHealthChange_transcendence_attack")
function transcendenceAttackEvent.onHealthChange(creature, attacker, primaryDamage, primaryType, secondaryDamage, secondaryType, origin)
    if not attacker or not attacker:isPlayer() then
        return primaryDamage, primaryType, secondaryDamage, secondaryType
    end
    
    tryActivateTranscendence(attacker)
    
    return primaryDamage, primaryType, secondaryDamage, secondaryType
end
transcendenceAttackEvent:register()

local transcendenceManaAttackEvent = CreatureEvent("onManaChange_transcendence_attack")
function transcendenceManaAttackEvent.onManaChange(creature, attacker, primaryDamage, primaryType, secondaryDamage, secondaryType, origin)
    if not attacker or not attacker:isPlayer() then
        return primaryDamage, primaryType, secondaryDamage, secondaryType
    end
    
    tryActivateTranscendence(attacker)
    
    return primaryDamage, primaryType, secondaryDamage, secondaryType
end
transcendenceManaAttackEvent:register()



local amplificationHealthChange = CreatureEvent("onHealthChange_amplification")
function amplificationHealthChange.onHealthChange(creature, attacker, primaryDamage, primaryType, secondaryDamage, secondaryType, origin)
    if not creature:isPlayer() then
        return primaryDamage, primaryType, secondaryDamage, secondaryType
    end
    
    if primaryDamage > 0 then
        return primaryDamage, primaryType, secondaryDamage, secondaryType
    end
    
    local boots = creature:getSlotItem(CONST_SLOT_FEET)
    if boots then
        local tier = boots:getAttribute(ITEM_ATTRIBUTE_TIER) or 0
        if tier > 0 then
            handleAmplification(creature)
        end
    end
    
    return primaryDamage, primaryType, secondaryDamage, secondaryType
end
amplificationHealthChange:register()

local amplificationManaChange = CreatureEvent("onManaChange_amplification")
function amplificationManaChange.onManaChange(creature, attacker, primaryDamage, primaryType, secondaryDamage, secondaryType, origin)
    if not creature:isPlayer() then
        return primaryDamage, primaryType, secondaryDamage, secondaryType
    end
    
    if primaryDamage > 0 then
        return primaryDamage, primaryType, secondaryDamage, secondaryType
    end
    
    local boots = creature:getSlotItem(CONST_SLOT_FEET)
    if boots then
        local tier = boots:getAttribute(ITEM_ATTRIBUTE_TIER) or 0
        if tier > 0 then
            handleAmplification(creature)
        end
    end
    
    return primaryDamage, primaryType, secondaryDamage, secondaryType
end
amplificationManaChange:register()

local NecklaceDropBoost = Event()
NecklaceDropBoost.onDropLoot = function(self, corpse)
    local mType = self:getType()
    if configManager.getNumber(configKeys.RATE_LOOT) == 0 then
        return
    end
    
    local player = Player(corpse:getCorpseOwner())
    if not player then
        return false
    end
    
    if player:getStamina() > 840 then
        local necklace = player:getSlotItem(CONST_SLOT_NECKLACE)
        if necklace then
            local tier = necklace:getAttribute(ITEM_ATTRIBUTE_TIER) or 0
            if tier > 0 then
                local dropBoost = getDropBoost(tier)
                if dropBoost > 0 then
                    player:sendTextMessage(MESSAGE_STATUS_DEFAULT, 
                        string.format("[Lucky Necklace] You have a tier %d necklace with +%d%% Drop Boost!", 
                        tier, dropBoost))
                    
                    corpse:getPosition():sendMagicEffect(CONST_ME_TUTORIALARROW)
                    corpse:getPosition():sendMagicEffect(CONST_ME_TUTORIALSQUARE)
                    
                    local rate = dropBoost / 10 * configManager.getNumber(configKeys.RATE_LOOT)
                    local monsterLoot = mType:getLoot()
                    
                    for i = 1, #monsterLoot do
                        local item = monsterLoot[i]
                        if math.random(100) <= rate then
                            local count = item.maxCount > 1 and math.random(item.maxCount) or 1
                            corpse:addItem(item.itemId, count)
                        end
                    end
                end
            end
        end
    end
    
    return true
end
NecklaceDropBoost:register(-1)

local action = Action()
function action.onUse(player, item, fromPosition, target, toPosition, isHotkey)
    if not isItemTierable(target) then
        player:sendTextMessage(MESSAGE_STATUS_SMALL, "Este item não pode receber upgrades de tier.")
        player:getPosition():sendMagicEffect(CONST_ME_POFF, player)
        return true
    end
    
    local upgradeItem = upgradeItems[item:getId()]
    if not upgradeItem then
        player:sendTextMessage(MESSAGE_STATUS_SMALL, "Item de upgrade inválido.")
        player:getPosition():sendMagicEffect(CONST_ME_POFF, player)
        return true
    end
  
    local itemId = target:getId()
    local maxTier = getMaxTierForItem(itemId)
    local maxClassification = getMaxClassificationForItem(itemId)
    local currentTier = target:getAttribute(ITEM_ATTRIBUTE_TIER) or 0
    local currentClassification = target:getAttribute(ITEM_ATTRIBUTE_CLASSIFICATION) or 0
    
    if upgradeItem.type == "reset" then
        if currentTier == 0 and currentClassification == 0 then
            player:sendTextMessage(MESSAGE_STATUS_SMALL, "Este item não possui tier ou classificação para resetar.")
            target:getPosition():sendMagicEffect(CONST_ME_POFF, player)
            return true
        end
        
        for statName, _ in pairs(conditions) do
            target:removeCustomAttribute(statName)
        end
        target:removeAttribute(ITEM_ATTRIBUTE_TIER)
        target:removeAttribute(ITEM_ATTRIBUTE_CLASSIFICATION)
        target:removeCustomAttribute("dodge_bonus")
        
        target:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE, player)
        player:sendTextMessage(MESSAGE_STATUS_SMALL, "Tier e classificação resetados com sucesso!")
        item:remove(1)
        
        if toPosition.x == CONTAINER_POSITION and toPosition.y <= 10 then
            addEvent(updateDodgeStorage, 100, player:getId())
            addEvent(updateStatBonus, 100, player:getId())
        end
        return true
    end
  
    if upgradeItem.type == "tier_upgrade" then
        local itemType = target:getType()
        local xmlClassification = itemType.classification or 0
        
        if currentTier >= maxTier then
            player:sendTextMessage(MESSAGE_STATUS_SMALL, "Este item já atingiu o tier máximo (" .. maxTier .. ").")
            target:getPosition():sendMagicEffect(CONST_ME_POFF, player)
            return true
        end
        
        local successChance = calculateUpgradeChance(currentTier)
        
        local rand = math.random(100)
        
        if rand <= successChance then
            target:setAttribute(ITEM_ATTRIBUTE_TIER, currentTier + 1)
            target:getPosition():sendMagicEffect(CONST_ME_MAGIC_GREEN, player)
            player:sendTextMessage(MESSAGE_STATUS_SMALL, "Upgrade bem-sucedido! Tier aumentado para " .. (currentTier + 1) .. "!")
        else
            target:getPosition():sendMagicEffect(CONST_ME_POFF, player)
            player:sendTextMessage(MESSAGE_STATUS_SMALL, "Upgrade falhou! Chance era de " .. successChance .. "%")
        end
        
        item:remove(1)
        
        if toPosition.x == CONTAINER_POSITION and toPosition.y <= 10 then
            addEvent(updateDodgeStorage, 100, player:getId())
            addEvent(updateStatBonus, 100, player:getId())
        end
        return true
    end
  
    if upgradeItem.type == "classification_upgrade" then
        local itemType = target:getType()
        local xmlClassification = itemType.classification or 0
        
        if currentClassification >= maxClassification then
            player:sendTextMessage(MESSAGE_STATUS_SMALL, "Este item já está na classificação máxima (" .. getClassificationName(maxClassification) .. ").")
            target:getPosition():sendMagicEffect(CONST_ME_POFF, player)
            return true
        end
        
        target:setAttribute(ITEM_ATTRIBUTE_CLASSIFICATION, currentClassification + 1)
        target:getPosition():sendMagicEffect(CONST_ME_MAGIC_GREEN, player)
        player:sendTextMessage(MESSAGE_STATUS_SMALL, "Upgrade de classificação realizado! Nova classificação: " .. getClassificationName(currentClassification + 1))
        
        item:remove(1)
        return true
    end
    
    if upgradeItem.type == "stat_boost" then
        local currentStat = target:getCustomAttribute(upgradeItem.stat) or 0
        target:setCustomAttribute(upgradeItem.stat, currentStat + upgradeItem.value)
  
    target:getPosition():sendMagicEffect(CONST_ME_MAGIC_GREEN, player)
        player:sendTextMessage(MESSAGE_STATUS_SMALL, "Stat " .. upgradeItem.stat .. " aumentado!")
    item:remove(1)
  
    if toPosition.x == CONTAINER_POSITION and toPosition.y <= 10 then
            addEvent(updateStatBonus, 100, player:getId())
        end
        return true
    end
    
    return true
end

for itemId, _ in pairs(upgradeItems) do
    action:id(itemId)
end
action:register()

local loginEvent = CreatureEvent("onLogin_updateTierSystem")
function loginEvent.onLogin(player)
    player:registerEvent("onHealthChange_dodgeChance")
    player:registerEvent("onManaChange_dodgeChance")
    player:registerEvent("Onslaught1")
    player:registerEvent("Onslaught2")
    player:registerEvent("onHealthChange_momentum")
    player:registerEvent("onManaChange_momentum")
    player:registerEvent("onHealthChange_amplification")
    player:registerEvent("onManaChange_amplification")
    player:registerEvent("onHealthChange_transcendence_attack")
    player:registerEvent("onManaChange_transcendence_attack")
    
    for slot = 1, 10 do
        local slotItem = player:getSlotItem(slot)
        if slotItem then
            local tier = slotItem:getAttribute(ITEM_ATTRIBUTE_TIER) or 0
            if tier > 0 then
                local slotName = getItemSlot(slotItem:getId())
                if slotName == "armor" then
                    -- Armor is handled by updateDodgeStorage
                end
            end
        end
    end
    
    addEvent(updateDodgeStorage, 100, player:getId())
    addEvent(updateStatBonus, 100, player:getId())
    return true
end
loginEvent:register()

local ec = Event()
ec.onMoveItem = function(self, item, count, fromPosition, toPosition, fromCylinder, toCylinder)
    if not (toPosition.x == CONTAINER_POSITION and toPosition.y <= 10 or fromPosition.x == CONTAINER_POSITION and fromPosition.y <= 10) then
        return RETURNVALUE_NOERROR
    end
    addEvent(updateDodgeStorage, 100, self:getId())
    addEvent(updateStatBonus, 100, self:getId())
    return RETURNVALUE_NOERROR
end
ec:register()

local onSpawn = Event()
function onSpawn.onSpawn(creature, position, startup, artificial)
    if creature:isMonster() then
        creature:registerEvent("Onslaught1")
        creature:registerEvent("onHealthChange_transcendence_attack")
    end
    return true
end
onSpawn:register(-666)
