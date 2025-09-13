--[[
	Description: This file is part of Roulette System (refactored)
	Author: Ly�
	Discord: Ly�#8767
]]


local Slot = require('data/scripts/magic-roulette/lib/classes/slot')

return {
	slots = {
		[30020] = Slot { -- west roulette
			needItem = {id = 5550, count = 1},
			tilesPerSlot = 13,
			centerPosition = Position(32215, 32212, 5),

			items = {
				{id = 5551, count = 1, chance = 0.5, rare = true}, -- ravenor amulet
				{id = 5555, count = 1, chance = 1, rare = true}, -- skywarden wand t3
				{id = 5594, count = 1, chance = 0.5, rare = true}, -- golden outfit
				{id = 5595, count = 1, chance = 0.5, rare = true}, -- dwarf guard outfit
				{id = 5568, count = 1, chance = 0.5, rare = true}, -- solara's wand t4
				{id = 5545, count = 1, chance = 0.5, rare = true}, -- ravenor reduction bolt quiver
				{id = 5546, count = 1, chance = 0.5, rare = true}, -- ravenor reduction arrow quiver
				{id = 5498, count = 1, chance = 1}, -- redskull removal
				{id = 5600, count = 1, chance = 1}, -- supreme life ring
				{id = 2195, count = 1, chance = 1}, -- boh
				{id = 5117, count = 1, chance = 10}, -- ravenor backpack
				{id = 2152, count = 5, chance = 15}, -- platinum coin
				{id = 2152, count = 10, chance = 10}, -- platinum coin
				{id = 5586, count = 1, chance = 10}, -- market permission
				{id = 5586, count = 1, chance = 5}, -- market permission
				{id = 2173, count = 1, chance = 4}, -- aol
				{id = 5550, count = 1, chance = 10}, -- roullete coin
				{id = 5108, count = 1, chance = 10}, -- dummy ticket
				{id = 5597, count = 1, chance = 4}, -- training crowbar
				{id = 5598, count = 1, chance = 4}, -- training knife
				{id = 5599, count = 1, chance = 4} -- training sickle
			},
		},
		[30021] = Slot { -- central roulette
			needItem = {id = 5550, count = 1},
			tilesPerSlot = 13,
			centerPosition = Position(32236, 32212, 5),

			items = {
				{id = 5551, count = 1, chance = 0.5, rare = true}, -- ravenor amulet
				{id = 5555, count = 1, chance = 1, rare = true}, -- skywarden wand t3
				{id = 5594, count = 1, chance = 0.5, rare = true}, -- golden outfit
				{id = 5595, count = 1, chance = 0.5, rare = true}, -- dwarf guard outfit
				{id = 5568, count = 1, chance = 0.5, rare = true}, -- solara's wand t4
				{id = 5545, count = 1, chance = 0.5, rare = true}, -- ravenor reduction bolt quiver
				{id = 5546, count = 1, chance = 0.5, rare = true}, -- ravenor reduction arrow quiver
				{id = 5498, count = 1, chance = 1}, -- redskull removal
				{id = 5600, count = 1, chance = 1}, -- supreme life ring
				{id = 2195, count = 1, chance = 1}, -- boh
				{id = 5117, count = 1, chance = 10}, -- ravenor backpack
				{id = 2152, count = 5, chance = 15}, -- platinum coin
				{id = 2152, count = 10, chance = 10}, -- platinum coin
				{id = 5586, count = 1, chance = 10}, -- market permission
				{id = 5586, count = 1, chance = 5}, -- market permission
				{id = 2173, count = 1, chance = 4}, -- aol
				{id = 5550, count = 1, chance = 10}, -- roullete coin
				{id = 5108, count = 1, chance = 10}, -- dummy ticket
				{id = 5597, count = 1, chance = 4}, -- training crowbar
				{id = 5598, count = 1, chance = 4}, -- training knife
				{id = 5599, count = 1, chance = 4} -- training sickle
			},
		},
		[30022] = Slot { -- east roulette
			needItem = {id = 5550, count = 1},
			tilesPerSlot = 13,
			centerPosition = Position(32257, 32212, 5),

			items = {
				{id = 5551, count = 1, chance = 0.5, rare = true}, -- ravenor amulet
				{id = 5555, count = 1, chance = 1, rare = true}, -- skywarden wand t3
				{id = 5594, count = 1, chance = 0.5, rare = true}, -- golden outfit
				{id = 5595, count = 1, chance = 0.5, rare = true}, -- dwarf guard outfit
				{id = 5568, count = 1, chance = 0.5, rare = true}, -- solara's wand t4
				{id = 5545, count = 1, chance = 0.5, rare = true}, -- ravenor reduction bolt quiver
				{id = 5546, count = 1, chance = 0.5, rare = true}, -- ravenor reduction arrow quiver
				{id = 5498, count = 1, chance = 1}, -- redskull removal
				{id = 5600, count = 1, chance = 1}, -- supreme life ring
				{id = 2195, count = 1, chance = 1}, -- boh
				{id = 5117, count = 1, chance = 10}, -- ravenor backpack
				{id = 2152, count = 5, chance = 15}, -- platinum coin
				{id = 2152, count = 10, chance = 10}, -- platinum coin
				{id = 5586, count = 1, chance = 10}, -- market permission
				{id = 5586, count = 1, chance = 5}, -- market permission
				{id = 2173, count = 1, chance = 4}, -- aol
				{id = 5550, count = 1, chance = 10}, -- roullete coin
				{id = 5108, count = 1, chance = 10}, -- dummy ticket
				{id = 5597, count = 1, chance = 4}, -- training crowbar
				{id = 5598, count = 1, chance = 4}, -- training knife
				{id = 5599, count = 1, chance = 4} -- training sickle
			},
		},
	}
}
