G_MONSTERSTAR = {}
G_MONSTERSTAR.STR_BESTIARY_POINTS = 15000
G_MONSTERSTAR.DATA = {}
G_MONSTERSTAR.EXTRA_LOOT = {
    [STAR_ONE] = {},
    [STAR_TWO] = {},
    [STAR_THREE] = {}
}

local function addEliteMonsterExtraLoot(name, star, item, mincount, maxcount, chance)
    if not G_MONSTERSTAR.EXTRA_LOOT[star][name] then
        G_MONSTERSTAR.EXTRA_LOOT[star][name] = {}
    end

    table.insert(G_MONSTERSTAR.EXTRA_LOOT[star][name], {
        itemid = item,
        getCount = function() return math.random(mincount, maxcount) end,
        chance = chance
    })

    return true
end

--[[

-- Ao adicionar loot por criatura, você pode adicionar por dois meios, sendo eles por tabela ou por função.

No caso da função, você simplesmente executa:

> addEliteMonsterExtraLoot("monster", star, iditem, count, count, chance)
-- Ex.: addEliteMonsterExtraLoot("Rat", STAR_THREE, 2160, 5, 5, 100000)

E será uma linha para cada loot.

No caso da tabela, você declara a tabela inteira manualmente. 

G_MONSTERSTAR.EXTRA_LOOT[STAR_THREE]["Rat"] = {
   [2160] = {
       count = 5,
       chance = 40000
    },
   [2492] = {
       count = 1,
       chance = 100
   }
}

-- Observação a referência a chance é : 0 a 100000
]]


-- addEliteMonsterExtraLoot("Rat", STAR_THREE, 2160, 5, 5, 100000)
-- addEliteMonsterExtraLoot("Rat", STAR_THREE, 2492, 1, 1, 100)

-- addEliteMonsterExtraLoot("Rat", STAR_TWO, 2160, 4, 4, 100000)
-- addEliteMonsterExtraLoot("Rat", STAR_TWO, 2492, 1, 1, 100)

-- addEliteMonsterExtraLoot("Rat", STAR_ONE, 2160, 4, 4, 100000)
-- addEliteMonsterExtraLoot("Rat", STAR_ONE, 2492, 1, 1, 100)

-- addEliteMonsterExtraLoot("monster", star, iditem, count, count, chance)

--[[ -- -- -- -- -- HELMETS  -- -- -- -- ]]--
--addEliteMonsterExtraLoot("Black Knight", STAR_THREE, 2496, 1, 1, 13500) -- hormed helmet
--addEliteMonsterExtraLoot("Warlock", STAR_THREE, 2474, 1, 1, 13500) -- winged helmet
--addEliteMonsterExtraLoot("Amazon", STAR_THREE, 2499, 1, 1, 1000) -- amazon helmet


--[[ -- -- -- -- -- ARMORS  -- -- -- -- ]]--
addEliteMonsterExtraLoot("Valkyre", STAR_THREE, 2500, 1, 1, 1000) -- amazon armor
addEliteMonsterExtraLoot("Elf Arcanist", STAR_THREE, 2505, 1, 1, 13500) -- elven armor
addEliteMonsterExtraLoot("Monk", STAR_THREE, 2508, 1, 1, 3500) -- native armor


--[[ -- -- -- -- -- LEGS  -- -- -- -- ]]--

addEliteMonsterExtraLoot("Demon", STAR_THREE, 2495, 1, 1, 6666) -- demon legs
addEliteMonsterExtraLoot("Dwarf Geomancer", STAR_ONE, 2504, 1, 1, 3000) -- dwarfen legs
addEliteMonsterExtraLoot("Dwarf Geomancer", STAR_TWO, 2504, 1, 1, 4000) -- dwarfen legs
addEliteMonsterExtraLoot("Dwarf Geomancer", STAR_THREE, 2504, 1, 1, 6000) -- dwarfen legs
--addEliteMonsterExtraLoot("Elf Arcanist", STAR_TWO, 2507, 1, 1, 13500) -- elven legs


--[[ -- -- -- -- -- BOOTS  -- -- -- -- ]]--


--[[ -- -- -- -- -- SHIELDS  -- -- -- -- ]]--
--addEliteMonsterExtraLoot("Valkyre", STAR_THREE, 2537, 1, 1, 1000) -- amazon shield


--[[ -- -- -- -- -- AXES  -- -- -- -- ]]--
--addEliteMonsterExtraLoot("Dragon Lord", STAR_ONE, 2414, 1, 1, 500) -- dragon lance
--addEliteMonsterExtraLoot("Dragon Lord", STAR_TWO, 2414, 1, 1, 1000) -- dragon lance
addEliteMonsterExtraLoot("Dragon Lord", STAR_THREE, 2414, 1, 1, 5000) -- dragon lance


--[[ -- -- -- -- -- CLUBS  -- -- -- -- ]]--



--[[ -- -- -- -- -- SWORDS  -- -- -- -- ]]--
--addEliteMonsterExtraLoot("Dragon", STAR_ONE, 2392, 1, 1, 200) -- fire sword
--addEliteMonsterExtraLoot("Dragon", STAR_TWO, 2392, 1, 1, 400) -- fire sword
--addEliteMonsterExtraLoot("Dragon", STAR_THREE, 2392, 1, 1, 600) -- fire sword


--[[ -- -- -- -- -- BOWS, ARROWS, QUIVERS  -- -- -- -- ]]--

--addEliteMonsterExtraLoot("Lizard Sentinel", STAR_ONE, 5484, 1, 1, 1000) -- bow t2
--addEliteMonsterExtraLoot("Lizard Sentinel", STAR_TWO, 5484, 1, 1, 4000) -- bow t2
--addEliteMonsterExtraLoot("Lizard Sentinel", STAR_THREE, 5484, 1, 1, 8000) -- bow t2

--addEliteMonsterExtraLoot("Banshee", STAR_TWO, 5485, 1, 1, 4000) -- bow t3
--addEliteMonsterExtraLoot("Banshee", STAR_THREE, 5485, 1, 1, 8000) -- bow t3

--addEliteMonsterExtraLoot("Dragon Lord", STAR_TWO, 5486, 1, 1, 4000) -- bow t4
--addEliteMonsterExtraLoot("Dragon Lord", STAR_THREE, 5486, 1, 1, 8000) -- bow t4

--addEliteMonsterExtraLoot("Orc Leader", STAR_TWO, 5488, 1, 1, 4000) -- arrow quiver t3
--addEliteMonsterExtraLoot("Orc Leader", STAR_THREE, 5488, 1, 1, 8000) -- arrow quiver t3

--addEliteMonsterExtraLoot("Hydra", STAR_TWO, 5489, 1, 1, 4000) -- arrow quiver t4
--addEliteMonsterExtraLoot("Hydra", STAR_THREE, 5489, 1, 1, 8000) -- arrow quiver t4

addEliteMonsterExtraLoot("Hunter", STAR_ONE, 5494, 1, 38, 50000) -- hunting arrow
addEliteMonsterExtraLoot("Hunter", STAR_TWO, 5494, 1, 88, 50000) -- hunting arrow
addEliteMonsterExtraLoot("Hunter", STAR_TWO, 5494, 1, 70, 50000) -- hunting arrow
addEliteMonsterExtraLoot("Hunter", STAR_THREE, 5494, 1, 75, 50000) -- hunting arrow
addEliteMonsterExtraLoot("Hunter", STAR_THREE, 5494, 1, 65, 50000) -- hunting arrow
addEliteMonsterExtraLoot("Hunter", STAR_THREE, 5494, 1, 50, 50000) -- hunting arrow

addEliteMonsterExtraLoot("Elf Scout", STAR_ONE, 5494, 1, 38, 50000) -- hunting arrow
addEliteMonsterExtraLoot("Elf Scout", STAR_TWO, 5494, 1, 88, 50000) -- hunting arrow
addEliteMonsterExtraLoot("Elf Scout", STAR_TWO, 5494, 1, 70, 50000) -- hunting arrow
addEliteMonsterExtraLoot("Elf Scout", STAR_THREE, 5494, 1, 75, 50000) -- hunting arrow
addEliteMonsterExtraLoot("Elf Scout", STAR_THREE, 5494, 1, 65, 50000) -- hunting arrow
addEliteMonsterExtraLoot("Elf Scout", STAR_THREE, 5494, 1, 50, 50000) -- hunting arrow


--[[ -- -- -- -- -- CROSSBOWS, BOLTS, QUIVERS  -- -- -- -- ]]--

--addEliteMonsterExtraLoot("Sibang", STAR_ONE, 5481, 1, 1, 1000) -- crossbow t2
--addEliteMonsterExtraLoot("Sibang", STAR_TWO, 5481, 1, 1, 4000) -- crossbow t2
--addEliteMonsterExtraLoot("Sibang", STAR_THREE, 5481, 1, 1, 8000) -- crossbow t2

--addEliteMonsterExtraLoot("Necromancer", STAR_TWO, 5482, 1, 1, 4000) -- crossbow t3
--addEliteMonsterExtraLoot("Necromancer", STAR_THREE, 5482, 1, 1, 8000) -- crossbow t3

--addEliteMonsterExtraLoot("Demon", STAR_TWO, 5483, 1, 1, 4000) -- crossbow t4
--addEliteMonsterExtraLoot("Demon", STAR_THREE, 5483, 1, 1, 8000) -- crossbow t4

--addEliteMonsterExtraLoot("Barbarian Brutetamer", STAR_TWO, 5491, 1, 1, 4000) -- bolt quiver t3
--addEliteMonsterExtraLoot("Barbarian Brutetamer", STAR_THREE, 5491, 1, 1, 8000) -- bolt quiver t3

--addEliteMonsterExtraLoot("Behemoth", STAR_TWO, 5492, 1, 1, 4000) -- bolt quiver t4
--addEliteMonsterExtraLoot("Behemoth", STAR_THREE, 5492, 1, 1, 8000) -- bolt quiver t4

addEliteMonsterExtraLoot("Minotaur Archer", STAR_ONE, 5493, 1, 38, 50000) --hunting bolt
addEliteMonsterExtraLoot("Minotaur Archer", STAR_TWO, 5493, 1, 88, 50000) --hunting bolt
addEliteMonsterExtraLoot("Minotaur Archer", STAR_TWO, 5493, 1, 70, 50000) --hunting bolt
addEliteMonsterExtraLoot("Minotaur Archer", STAR_THREE, 5493, 1, 75, 50000) --hunting bolt
addEliteMonsterExtraLoot("Minotaur Archer", STAR_THREE, 5493, 1, 65, 50000) --hunting bolt
addEliteMonsterExtraLoot("Minotaur Archer", STAR_THREE, 5493, 1, 50, 50000) --hunting bolt

addEliteMonsterExtraLoot("Dwarf Soldier", STAR_ONE, 5493, 1, 38, 50000) --hunting bolt
addEliteMonsterExtraLoot("Dwarf Soldier", STAR_TWO, 5493, 1, 88, 50000) --hunting bolt
addEliteMonsterExtraLoot("Dwarf Soldier", STAR_TWO, 5493, 1, 70, 50000) --hunting bolt
addEliteMonsterExtraLoot("Dwarf Soldier", STAR_THREE, 5493, 1, 75, 50000) --hunting bolt
addEliteMonsterExtraLoot("Dwarf Soldier", STAR_THREE, 5493, 1, 65, 50000) --hunting bolt
addEliteMonsterExtraLoot("Dwarf Soldier", STAR_THREE, 5493, 1, 50, 50000) --hunting bolt



--[[ -- -- -- -- -- GOLD  -- -- -- -- ]]--

--INFO: For all creatures, adds "Every Elite" as creature name.

addEliteMonsterExtraLoot("Every Elite", STAR_ONE, 2152, 1, 1, 24000) --platinum coin
addEliteMonsterExtraLoot("Every Elite", STAR_TWO, 2152, 1, 2, 24000) --platinum coin
addEliteMonsterExtraLoot("Every Elite", STAR_TWO, 2152, 1, 1, 24000) --platinum coin
addEliteMonsterExtraLoot("Every Elite", STAR_THREE, 2152, 1, 2, 24000) --platinum coin
addEliteMonsterExtraLoot("Every Elite", STAR_THREE, 2152, 1, 2, 24000) --platinum coin

addEliteMonsterExtraLoot("Every Elite", STAR_ONE, 2148, 21, 88, 50000) --gold coin
addEliteMonsterExtraLoot("Every Elite", STAR_ONE, 2148, 10, 38, 50000) --gold coin
addEliteMonsterExtraLoot("Every Elite", STAR_TWO, 2148, 35, 95, 50000) --gold coin
addEliteMonsterExtraLoot("Every Elite", STAR_TWO, 2148, 25, 88, 50000) --gold coin
addEliteMonsterExtraLoot("Every Elite", STAR_TWO, 2148, 8, 70, 50000) --gold coin
addEliteMonsterExtraLoot("Every Elite", STAR_THREE, 2148, 25, 100, 50000) --gold coin
addEliteMonsterExtraLoot("Every Elite", STAR_THREE, 2148, 18, 75, 50000) --gold coin
addEliteMonsterExtraLoot("Every Elite", STAR_THREE, 2148, 42, 65, 50000) --gold coin
addEliteMonsterExtraLoot("Every Elite", STAR_THREE, 2148, 9, 50, 50000) --gold coin

--[[ -- -- -- -- -- BOSSES  -- -- -- -- ]]--

addEliteMonsterExtraLoot("Grorlam", STAR_ONE, 2454, 1, 1, 1000) -- war axe
addEliteMonsterExtraLoot("Grorlam", STAR_TWO, 2454, 1, 1, 2000) -- war axe
addEliteMonsterExtraLoot("Grorlam", STAR_THREE, 2454, 1, 1, 3000) -- war axe

addEliteMonsterExtraLoot("General Murius", STAR_ONE, 2502, 1, 1, 1000) -- dwarfen helmet
addEliteMonsterExtraLoot("General Murius", STAR_TWO, 2502, 1, 1, 2000) -- dwarfen helmet
addEliteMonsterExtraLoot("General Murius", STAR_THREE, 2502, 1, 1, 3000) -- dwarfen helmet
addEliteMonsterExtraLoot("General Murius", STAR_ONE, 2503, 1, 1, 1000) -- dwarven armor
addEliteMonsterExtraLoot("General Murius", STAR_TWO, 2503, 1, 1, 2000) -- dwarven armor
addEliteMonsterExtraLoot("General Murius", STAR_THREE, 2503, 1, 1, 3000) -- dwarven armor
addEliteMonsterExtraLoot("General Murius", STAR_ONE, 2504, 1, 1, 1000) -- dwarfen legs
addEliteMonsterExtraLoot("General Murius", STAR_TWO, 2504, 1, 1, 2000) -- dwarfen legs
addEliteMonsterExtraLoot("General Murius", STAR_THREE, 2504, 1, 1, 3000) -- dwarfen legs

addEliteMonsterExtraLoot("The Horned Fox", STAR_ONE, 2503, 1, 1, 1000) -- dwarven armor
addEliteMonsterExtraLoot("The Horned Fox", STAR_TWO, 2503, 1, 1, 2000) -- dwarven armor
addEliteMonsterExtraLoot("The Horned Fox", STAR_THREE, 2503, 1, 1, 3000) -- dwarven armor
addEliteMonsterExtraLoot("The Horned Fox", STAR_THREE, 2504, 1, 1, 3000) -- dwarfen legs

addEliteMonsterExtraLoot("Demodras", STAR_ONE, 2469, 1, 1, 1000) -- dragon scale legs
addEliteMonsterExtraLoot("Demodras", STAR_TWO, 2469, 1, 1, 5000) -- dragon scale legs
addEliteMonsterExtraLoot("Demodras", STAR_THREE, 2469, 1, 1, 8000) -- dragon scale legs
addEliteMonsterExtraLoot("Demodras", STAR_ONE, 2506, 1, 1, 1000) -- dragon scale helmet
addEliteMonsterExtraLoot("Demodras", STAR_TWO, 2506, 1, 1, 5000) -- dragon scale helmet
addEliteMonsterExtraLoot("Demodras", STAR_THREE, 2506, 1, 1, 8000) -- dragon scale helmet