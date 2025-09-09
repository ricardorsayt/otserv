local json = require("cjson") -- carrega suporte a JSON
-- JSON library is loaded globally from data/lib/core/json.lua
local RewardType = {
  Points = 1,
  Experience = 2,
  Gold = 3,
  Item = 4,
  Storage = 5,
  Teleport = 6
}
local Config = {
  TasksOpCode = 110,
  StoragePoints = 87613,
  StorageSlot = 87614, -- 87615 - 87625 reserved (10)
  StorageKillsSelected = 97626, -- 87627 - 87637 reserved (10)
  StorageKillsCurrent = 97638,
  StorageTaskCompletions = 98800, -- 87639 - 87649 reserved (10)
  ActiveTasksLimit = 5, -- max 10 or you will have to adjust storage keys
  RecommendedLevelRange = 10, -- when player is within this range (at level 20, 10-20 and 20-30 levels), "Recommended" text will be displayed in tasks list
  -- Intervalo ajustado para 300-3000 kills
  RequiredKills = {Min = 300, Max = 5000},
  -- B nus a cada 300 kills (10% do m ximo)
  KillsForBonus = 1000,
  -- B nus aumentados significativamente
  PointsIncrease = 30,    -- 150% increased rank points per 300 kills above minimum
  ExperienceIncrease = 50, -- 20% increased experience per 300 kills above minimum
  GoldIncrease = 15,       -- 25% increased gold per 300 kills above minimum
  -- B nus especial para quem completa 3000 kills
  MaxKillsBonus = {
    Points = 0,       -- +5 pontos adicionais
    Experience = 0.0, -- +20% da experi ncia total
    Gold = 0.0        -- +20% do ouro total
  },
  Party = {
    Enabled = true,
    Range = 8
  },
  Ranks = {
    [25] = "Huntsman",
    [50] = "Ranger",
    [100] = "Big Game Hunter",
    [150] = "Trophy Hunter",
    [200] = "Pro Hunter",
    [250] = "Elite Hunter"
  },
Tasks = {
    {
      RaceName = "Rats",
      Level = 1,
      Monsters = {"rat", "cave rat"},
      Rewards = {
        {Type = RewardType.Experience, BaseValue = 500},
        {Type = RewardType.Gold, BaseValue = 1000},
        {Type = RewardType.Item, Id = 24774, Amount = 1},
	{Type = RewardType.Points, BaseValue = 5}, -- Adicionado 5 pontos como recompensa
      }
    },
    {
      RaceName = "Spiders",
      Level = 5,
      Monsters = {"spider", "poison spider"},
      Rewards = {
        {Type = RewardType.Experience, BaseValue = 1000},
        {Type = RewardType.Gold, BaseValue = 1500},
        {Type = RewardType.Item, Id = 24774, Amount = 1},
	{Type = RewardType.Points, BaseValue = 5}, -- Adicionado 5 pontos como recompensa
      }
    },
    {
      RaceName = "Snakes",
      Level = 5,
      Monsters = {"snake"},
      Rewards = {
        {Type = RewardType.Experience, BaseValue = 500},
        {Type = RewardType.Gold, BaseValue = 500},
        {Type = RewardType.Item, Id = 24774, Amount = 1},
	{Type = RewardType.Points, BaseValue = 5}, -- Adicionado 5 pontos como recompensa
      }
    },
    {
      RaceName = "Trolls",
      Level = 5,
      Monsters = {"troll", "troll champion", "troll guard"},
      Rewards = {
        {Type = RewardType.Experience, BaseValue = 1000},
        {Type = RewardType.Gold, BaseValue = 1000},
        {Type = RewardType.Item, Id = 24774, Amount = 1},
	{Type = RewardType.Points, BaseValue = 5}, -- Adicionado 5 pontos como recompensa
      }
    },
    {
      RaceName = "Skeletons",
      Level = 5,
      Monsters = {"skeleton"},
      Rewards = {
        {Type = RewardType.Experience, BaseValue = 1000},
        {Type = RewardType.Gold, BaseValue = 800},
        {Type = RewardType.Item, Id = 24774, Amount = 1},
	{Type = RewardType.Points, BaseValue = 5}, -- Adicionado 5 pontos como recompensa
      }
    },
    {
      RaceName = "Rotworm",
      Level = 8,
      Monsters = {"rotworm", "carrion worm"},
      Rewards = {
        {Type = RewardType.Experience, BaseValue = 10000},
        {Type = RewardType.Gold, BaseValue = 2000},
        {Type = RewardType.Item, Id = 24774, Amount = 2},
	{Type = RewardType.Points, BaseValue = 5}, -- Adicionado 5 pontos como recompensa
      }
    },
    {
      RaceName = "Orcs",
      Level = 8,
      Monsters = {"orc", "orc leader", "orc shaman", "orc warlord", "orc rider", "orc warrior"},
      Rewards = {
        {Type = RewardType.Experience, BaseValue = 20000},
        {Type = RewardType.Gold, BaseValue = 10000},
	{Type = RewardType.Points, BaseValue = 5}, -- Adicionado 5 pontos como recompensa
        {Type = RewardType.Item, Id = 24774, Amount = 2},
        {Type = RewardType.Item, Id = 2475, Amount = 1}
      }
    },
    {
      RaceName = "Wasps",
      Level = 15,
      Monsters = {"wasp"},
      Rewards = {
        {Type = RewardType.Experience, BaseValue = 1000},
        {Type = RewardType.Gold, BaseValue = 5000},
	{Type = RewardType.Points, BaseValue = 5}, -- Adicionado 5 pontos como recompensa
        {Type = RewardType.Item, Id = 24774, Amount = 2},
        {Type = RewardType.Item, Id = 5902, Amount = 10}
      }
    },
    {
      RaceName = "Amazons",
      Level = 15,
      Monsters = {"amazon", "valkyrie"},
      Rewards = {
        {Type = RewardType.Experience, BaseValue = 8000},
        {Type = RewardType.Gold, BaseValue = 2000},
	{Type = RewardType.Points, BaseValue = 5}, -- Adicionado 5 pontos como recompensa
        {Type = RewardType.Item, Id = 24774, Amount = 2},
        {Type = RewardType.Item, Id = 12400, Amount = 10}
      }
    },
    {
      RaceName = "Ghouls",
      Level = 15,
      Monsters = {"ghoul"},
      Rewards = {
        {Type = RewardType.Experience, BaseValue = 10000},
        {Type = RewardType.Gold, BaseValue = 3000},
	{Type = RewardType.Points, BaseValue = 5}, -- Adicionado 5 pontos como recompensa
        {Type = RewardType.Item, Id = 24774, Amount = 2}, 
       {Type = RewardType.Item, Id = 5913, Amount = 10}
      }
    },
    {
      RaceName = "Dwarfs",
      Level = 15,
      Monsters = {"dwarf", "dwarf guard", "dwarf soldier", "dwarf geomancer"},
      Rewards = {
        {Type = RewardType.Experience, BaseValue = 10000},
        {Type = RewardType.Gold, BaseValue = 3000},
	{Type = RewardType.Points, BaseValue = 5}, -- Adicionado 5 pontos como recompensa
        {Type = RewardType.Item, Id = 24774, Amount = 2},
       {Type = RewardType.Item, Id = 5880, Amount = 10}
      }
    },
    {
      RaceName = "Minotaurs",
      Level = 15,
      Monsters = {"minotaur", "minotaur mage", "minotaur archer", "minotaur guard"},
      Rewards = {
        {Type = RewardType.Experience, BaseValue = 10000},
        {Type = RewardType.Gold, BaseValue = 5000},
        {Type = RewardType.Item, Id = 5804, Amount = 1},
	{Type = RewardType.Points, BaseValue = 5}, -- Adicionado 5 pontos como recompensa
        {Type = RewardType.Item, Id = 24774, Amount = 2},
        {Type = RewardType.Item, Id = 5878, Amount = 10}
      }
    },
    {
      RaceName = "Apes",
      Level = 20,
      Monsters = {"sibang", "kongra", "merlkin"},
      Rewards = {
        {Type = RewardType.Experience, BaseValue = 20000},
        {Type = RewardType.Gold, BaseValue = 5000},
	{Type = RewardType.Points, BaseValue = 5}, -- Adicionado 5 pontos como recompensa
        {Type = RewardType.Item, Id = 24774, Amount = 3},
        {Type = RewardType.Item, Id = 5883, Amount = 10}
      }
    },
    {
      RaceName = "Tarantulas",
      Level = 20,
      Monsters = {"tarantula"},
      Rewards = {
        {Type = RewardType.Experience, BaseValue = 30000},
        {Type = RewardType.Gold, BaseValue = 7000},
	{Type = RewardType.Points, BaseValue = 5}, -- Adicionado 5 pontos como recompensa
        {Type = RewardType.Item, Id = 24774, Amount = 3},
        {Type = RewardType.Item, Id = 5879, Amount = 4}
      }
    },
    {
      RaceName = "Cyclops",
      Level = 20,
      Monsters = {"cyclops"},
      Rewards = {
        {Type = RewardType.Experience, BaseValue = 40000},
        {Type = RewardType.Gold, BaseValue = 5000},
	{Type = RewardType.Points, BaseValue = 5}, -- Adicionado 5 pontos como recompensa
        {Type = RewardType.Item, Id = 24774, Amount = 3},
        {Type = RewardType.Item, Id = 10574, Amount = 35}
      }
    },
    {
      RaceName = "Lizards",
      Level = 20,
      Monsters = {"lizard templar", "lizard sentinel", "lizard snakecharmer"},
      Rewards = {
        {Type = RewardType.Experience, BaseValue = 40000},
        {Type = RewardType.Gold, BaseValue = 5000},
	{Type = RewardType.Points, BaseValue = 5}, -- Adicionado 5 pontos como recompensa
        {Type = RewardType.Item, Id = 24774, Amount = 3},
        {Type = RewardType.Item, Id = 5881, Amount = 10},
        {Type = RewardType.Item, Id = 5876, Amount = 10}
      }
    },
    {
      RaceName = "Scarabs",
      Level = 25,
      Monsters = {"scarab"},
      Rewards = {
        {Type = RewardType.Experience, BaseValue = 55000},
        {Type = RewardType.Gold, BaseValue = 4000},
	{Type = RewardType.Points, BaseValue = 5}, -- Adicionado 5 pontos como recompensa
        {Type = RewardType.Item, Id = 24774, Amount = 3},
        {Type = RewardType.Item, Id = 2159, Amount = 10},
        {Type = RewardType.Item, Id = 2150, Amount = 5},
        {Type = RewardType.Item, Id = 2149, Amount = 5}
      }
    },
    {
      RaceName = "Vampires",
      Level = 30,
      Monsters = {"vampire"},
      Rewards = {
        {Type = RewardType.Experience, BaseValue = 65000},
        {Type = RewardType.Gold, BaseValue = 8000},
	{Type = RewardType.Points, BaseValue = 5}, -- Adicionado 5 pontos como recompensa
        {Type = RewardType.Item, Id = 24774, Amount = 3},
        {Type = RewardType.Item, Id = 5905, Amount = 3}
      }
    },
    {
      RaceName = "Dragons",
      Level = 30,
      Monsters = {"dragon"},
      Rewards = {
        {Type = RewardType.Experience, BaseValue = 80000},
        {Type = RewardType.Gold, BaseValue = 10000},
        {Type = RewardType.Item, Id = 2516, Amount = 1},
	{Type = RewardType.Points, BaseValue = 5}, -- Adicionado 5 pontos como recompensa
        {Type = RewardType.Item, Id = 24774, Amount = 3},
        {Type = RewardType.Item, Id = 12413, Amount = 15}
      }
    },
    {
      RaceName = "Ancient scarab",
      Level = 30,
      Monsters = {"ancient scarab"},
      Rewards = {
        {Type = RewardType.Experience, BaseValue = 70000},
        {Type = RewardType.Gold, BaseValue = 10000},
        {Type = RewardType.Item, Id = 8912, Amount = 1},
        {Type = RewardType.Item, Id = 7903, Amount = 1},
	{Type = RewardType.Points, BaseValue = 5}, -- Adicionado 5 pontos como recompensa
        {Type = RewardType.Item, Id = 24774, Amount = 3},
        {Type = RewardType.Item, Id = 10548, Amount = 10}
      }
    },
    {
      RaceName = "Giant Spiders",
      Level = 35,
      Monsters = {"giant spider"},
      Rewards = {
        {Type = RewardType.Experience, BaseValue = 100000},
        {Type = RewardType.Gold, BaseValue = 20000},
        {Type = RewardType.Item, Id = 2497, Amount = 1},
	{Type = RewardType.Points, BaseValue = 5}, -- Adicionado 5 pontos como recompensa
        {Type = RewardType.Item, Id = 24774, Amount = 3},
        {Type = RewardType.Item, Id = 5879, Amount = 5}
      }
    },
    {
      RaceName = "Crystal Spiders",
      Level = 35,
      Monsters = {"crystal spider"},
      Rewards = {
        {Type = RewardType.Experience, BaseValue = 100000},
        {Type = RewardType.Gold, BaseValue = 20000},
        {Type = RewardType.Item, Id = 5801, Amount = 1},
	{Type = RewardType.Points, BaseValue = 5}, -- Adicionado 5 pontos como recompensa
        {Type = RewardType.Item, Id = 24774, Amount = 3},
        {Type = RewardType.Item, Id = 5879, Amount = 5}
      }
    },
    {
      RaceName = "Djinns",
      Level = 35,
      Monsters = {"blue djinn", "green djinn", "efreet", "marid"},
      Rewards = {
        {Type = RewardType.Experience, BaseValue = 80000},
        {Type = RewardType.Gold, BaseValue = 7000},
	{Type = RewardType.Points, BaseValue = 5}, -- Adicionado 5 pontos como recompensa
        {Type = RewardType.Item, Id = 24774, Amount = 3},
        {Type = RewardType.Item, Id = 5910, Amount = 10},
        {Type = RewardType.Item, Id = 5912, Amount = 10}
      }
    },
    {
      RaceName = "Heros",
      Level = 40,
      Monsters = {"hero"},
      Rewards = {
        {Type = RewardType.Experience, BaseValue = 120000},
        {Type = RewardType.Gold, BaseValue = 25000},
	{Type = RewardType.Points, BaseValue = 5}, -- Adicionado 5 pontos como recompensa
        {Type = RewardType.Item, Id = 24774, Amount = 4},
        {Type = RewardType.Item, Id = 2488, Amount = 1}
      }
    },
    {
      RaceName = "Black knight",
      Level = 40,
      Monsters = {"black knight"},
      Rewards = {
        {Type = RewardType.Experience, BaseValue = 120000},
        {Type = RewardType.Gold, BaseValue = 20000},
        {Type = RewardType.Item, Id = 2414, Amount = 1},
	{Type = RewardType.Points, BaseValue = 5}, -- Adicionado 5 pontos como recompensa
        {Type = RewardType.Item, Id = 24774, Amount = 4},
        {Type = RewardType.Item, Id = 5893, Amount = 5}
      }
    },
    {
      RaceName = "Bog Raider",
      Level = 40,
      Monsters = {"bog raider"},
      Rewards = {
        {Type = RewardType.Experience, BaseValue = 120000},
        {Type = RewardType.Gold, BaseValue = 20000},
        {Type = RewardType.Item, Id = 8912, Amount = 1},
	{Type = RewardType.Points, BaseValue = 5}, -- Adicionado 5 pontos como recompensa
        {Type = RewardType.Item, Id = 24774, Amount = 4},
        {Type = RewardType.Item, Id = 10584, Amount = 25}
      }
    },
    {
      RaceName = "Dragon Lord",
      Level = 50,
      Monsters = {"dragon lord"},
      Rewards = {
        {Type = RewardType.Experience, BaseValue = 250000},
        {Type = RewardType.Gold, BaseValue = 30000},
        {Type = RewardType.Item, Id = 2528, Amount = 1},
	{Type = RewardType.Points, BaseValue = 10}, -- Adicionado 10 pontos como recompensa
        {Type = RewardType.Item, Id = 24774, Amount = 4},
        {Type = RewardType.Item, Id = 5882, Amount = 15},
        {Type = RewardType.Item, Id = 5948, Amount = 15}
      }
    },
    {
      RaceName = "Frost dragons",
      Level = 50,
      Monsters = {"frost dragon"},
      Rewards = {
        {Type = RewardType.Experience, BaseValue = 250000},
        {Type = RewardType.Gold, BaseValue = 30000},
	{Type = RewardType.Points, BaseValue = 10}, -- Adicionado 10 pontos como recompensa
        {Type = RewardType.Item, Id = 24774, Amount = 4},
        {Type = RewardType.Item, Id = 2492, Amount = 1}
      }
    },
    {
      RaceName = "Hydra",
      Level = 50,
      Monsters = {"hydra"},
      Rewards = {
        {Type = RewardType.Experience, BaseValue = 250000},
        {Type = RewardType.Gold, BaseValue = 30000},
        {Type = RewardType.Item, Id = 2536, Amount = 1},
	{Type = RewardType.Points, BaseValue = 10}, -- Adicionado 10 pontos como recompensa
        {Type = RewardType.Item, Id = 24774, Amount = 4},
        {Type = RewardType.Item, Id = 11199, Amount = 15}
      }
    },
   {
      RaceName = "Nightmare",
      Level = 50,
      Monsters = {"nightmare", "nightmare scion"},
      Rewards = {
        {Type = RewardType.Experience, BaseValue = 250000},
        {Type = RewardType.Gold, BaseValue = 40000},
        {Type = RewardType.Item, Id = 2195, Amount = 1},
	{Type = RewardType.Points, BaseValue = 10}, -- Adicionado 10 pontos como recompensa
        {Type = RewardType.Item, Id = 24774, Amount = 4},
        {Type = RewardType.Item, Id = 6500, Amount = 20}
      }
    },

    {
      RaceName = "Deeplings",
      Level = 70,
      Monsters = {"deepling elite", "deepling warrior", "deepling guard", "deepling master librarian", "deepling spellsinger", "deepling tyrant"},
      Rewards = {
        {Type = RewardType.Experience, BaseValue = 350000},
        {Type = RewardType.Gold, BaseValue = 30000},
	{Type = RewardType.Points, BaseValue = 10}, -- Adicionado 10 pontos como recompensa
        {Type = RewardType.Item, Id = 24774, Amount = 5},
        {Type = RewardType.Item, Id = 15454, Amount = 1},
        {Type = RewardType.Item, Id = 15645, Amount = 1}
      }
    },
    {
      RaceName = "Warlock",
      Level = 80,
      Monsters = {"warlock"},
      Rewards = {
        {Type = RewardType.Experience, BaseValue = 400000},
        {Type = RewardType.Gold, BaseValue = 30000},
        {Type = RewardType.Item, Id = 2656, Amount = 1},
	{Type = RewardType.Points, BaseValue = 10}, -- Adicionado 10 pontos como recompensa
        {Type = RewardType.Item, Id = 24774, Amount = 5},
        {Type = RewardType.Item, Id = 5904, Amount = 2}
      }
    },
    {
      RaceName = "Serpent Spawns",
      Level = 80,
      Monsters = {"serpent spawn"},
      Rewards = {
        {Type = RewardType.Experience, BaseValue = 400000},
        {Type = RewardType.Gold, BaseValue = 30000},
	{Type = RewardType.Points, BaseValue = 10}, -- Adicionado 10 pontos como recompensa
        {Type = RewardType.Item, Id = 24774, Amount = 5},
        {Type = RewardType.Item, Id = 8902, Amount = 1}
      }
    },
    {
      RaceName = "Behemoths",
      Level = 80,
      Monsters = {"behemoth"},
      Rewards = {
        {Type = RewardType.Experience, BaseValue = 400000},
        {Type = RewardType.Gold, BaseValue = 35000},
        {Type = RewardType.Item, Id = 2466, Amount = 1},
	{Type = RewardType.Points, BaseValue = 10}, -- Adicionado 10 pontos como recompensa
        {Type = RewardType.Item, Id = 24774, Amount = 5},
        {Type = RewardType.Item, Id = 5930, Amount = 5},
        {Type = RewardType.Item, Id = 5893, Amount = 5}
      }
    },
    {
      RaceName = "Furys",
      Level = 100,
      Monsters = {"fury"},
      Rewards = {
        {Type = RewardType.Experience, BaseValue = 500000},
        {Type = RewardType.Gold, BaseValue = 70000},
        {Type = RewardType.Item, Id = 7404, Amount = 1},
	{Type = RewardType.Points, BaseValue = 10}, -- Adicionado 10 pontos como recompensa
        {Type = RewardType.Item, Id = 24774, Amount = 5},
        {Type = RewardType.Item, Id = 5911, Amount = 20}
      }
    },
    {
      RaceName = "Demons",
      Level = 120,
      Monsters = {"demon"},
      Rewards = {
        {Type = RewardType.Experience, BaseValue = 500000},
        {Type = RewardType.Gold, BaseValue = 200000},
	{Type = RewardType.Points, BaseValue = 10}, -- Adicionado 10 pontos como recompensa
        {Type = RewardType.Item, Id = 24774, Amount = 5},
        {Type = RewardType.Item, Id = 6068, Amount = 20}
      }
    },
    {
      RaceName = "Medusa",
      Level = 120,
      Monsters = {"medusa"},
      Rewards = {
        {Type = RewardType.Experience, BaseValue = 800000},
        {Type = RewardType.Gold, BaseValue = 150000},
	{Type = RewardType.Points, BaseValue = 10}, -- Adicionado 10 pontos como recompensa
        {Type = RewardType.Item, Id = 24774, Amount = 5},
        {Type = RewardType.Item, Id = 11226, Amount = 20}
      }
    },
    {
      RaceName = "Grim Reaper",
      Level = 150,
      Monsters = {"grim reaper"},
      Rewards = {
        {Type = RewardType.Experience, BaseValue = 800000},
        {Type = RewardType.Gold, BaseValue = 200000},
	{Type = RewardType.Points, BaseValue = 10}, -- Adicionado 10 pontos como recompensa
        {Type = RewardType.Item, Id = 24774, Amount = 5},
        {Type = RewardType.Item, Id = 8889, Amount = 1}
      }
    },
    {
      RaceName = "Juggernaut",
      Level = 180,
      Monsters = {"juggernaut"},
      Rewards = {
        {Type = RewardType.Experience, BaseValue = 1500000},
        {Type = RewardType.Gold, BaseValue = 300000},
	{Type = RewardType.Points, BaseValue = 10}, -- Adicionado 10 pontos como recompensa
        {Type = RewardType.Item, Id = 24774, Amount = 5},
        {Type = RewardType.Item, Id = 24774, Amount = 1},
        {Type = RewardType.Item, Id = 2514, Amount = 1}
      }
    },
    {
      RaceName = "Hellhound",
      Level = 200,
      Monsters = {"hellhound"},
      Rewards = {
        {Type = RewardType.Experience, BaseValue = 1500000},
        {Type = RewardType.Gold, BaseValue = 300000},
	{Type = RewardType.Points, BaseValue = 10}, -- Adicionado 10 pontos como recompensa
        {Type = RewardType.Item, Id = 24774, Amount = 5},
        {Type = RewardType.Item, Id = 24774, Amount = 1},
        {Type = RewardType.Item, Id = 6553, Amount = 1}
      }
    }
}
}
local Cache = {}
local StartupEvent = GlobalEvent("TasksStartUp")
function StartupEvent.onStartup()
  Cache.Ranks = {}
  local ordered = {}
  for key, _ in pairs(Config.Ranks) do
    table.insert(ordered, key)
  end
  table.sort(ordered)
  local to = ordered[1] - 1
  for k = 0, to do
    Cache.Ranks[k] = "Novice Hunter"
  end
  for i = 1, #ordered do
    local from = ordered[i]
    local to = i == #ordered and ordered[i] or ordered[i + 1] - 1
    for k = from, to do
      Cache.Ranks[k] = Config.Ranks[from]
    end
    Cache.LastRank = from
  end
  Cache.Tasks = {}
  for id, task in ipairs(Config.Tasks) do
    for _, name in ipairs(task.Monsters) do
      Cache.Tasks[string.lower(name)] = id
    end
  end
  for _, task in ipairs(Config.Tasks) do
    if not task.Outfits then
      task.Outfits = {}
      for _, monster in ipairs(task.Monsters) do
        local monsterType = MonsterType(monster)
        if not monsterType then
          print("[Error] Tasks: Monster " .. monster .. " not found!")
        else
          table.insert(task.Outfits, monsterType:getOutfitOTC())
        end
      end
    end
  end
end
local LoginEvent = CreatureEvent("TasksLogin")
function LoginEvent.onLogin(player)
  player:registerEvent("TasksExtended")
  player:registerEvent("TasksKill")
  player:sendTasksData()
  return true
end
local ExtendedEvent = CreatureEvent("TasksExtended")
function ExtendedEvent.onExtendedOpcode(player, opcode, buffer)
  if opcode == Config.TasksOpCode then
    local status, json_data =
      pcall(
      function()
        return json.decode(buffer)
      end
    )
    if not status then
      return false
    end
    local action = json_data.action
    local data = json_data.data
    if action == "start" then
      player:startNewTask(data.taskId, data.kills)
    elseif action == "cancel" then
      player:cancelTask(data)
    end
  end
  return true
end
function Player:openTasksList()
  self:sendExtendedOpcode(Config.TasksOpCode, json.encode({action = "open"}))
end
function Player:closeTasksList()
  self:sendExtendedOpcode(Config.TasksOpCode, json.encode({action = "close"}))
end
function Player:sendTasksData()
  -- Send config
  local config = {
    kills = Config.RequiredKills,
    bonus = Config.KillsForBonus,
    range = Config.RecommendedLevelRange,
    points = Config.PointsIncrease,
    exp = Config.ExperienceIncrease,
    gold = Config.GoldIncrease
  }
  self:sendExtendedOpcode(Config.TasksOpCode, json.encode({action = "config", data = config}))
  -- Send tasks list
  local tasks = {}
  for _, task in ipairs(Config.Tasks) do
    local taskData = {
      name = task.RaceName,
      lvl = task.Level,
      mobs = task.Monsters,
      outfits = task.Outfits,
      rewards = {}
    }
    for _, reward in ipairs(task.Rewards) do
      if reward.Type == RewardType.Points or reward.Type == RewardType.Experience or reward.Type == RewardType.Gold then
        table.insert(taskData.rewards, {type = reward.Type, value = reward.BaseValue})
      elseif reward.Type == RewardType.Item then
        table.insert(taskData.rewards, {type = reward.Type, name = ItemType(reward.Id):getName(), amount = reward.Amount})
      elseif reward.Type == RewardType.Storage or reward.Type == RewardType.Teleport then
        table.insert(taskData.rewards, {type = reward.Type, desc = reward.Description})
      end
    end
    table.insert(tasks, taskData)
  end
  local buffer = json.encode({action = "tasks", data = tasks})
  local s = {}
  for i = 1, #buffer, 8191 do
    s[#s + 1] = buffer:sub(i, i + 8191 - 1)
  end
  if #s == 1 then
    self:sendExtendedOpcode(Config.TasksOpCode, buffer)
  else
    self:sendExtendedOpcode(Config.TasksOpCode, "S" .. s[1])
    for i = 2, #s - 1 do
      self:sendExtendedOpcode(Config.TasksOpCode, "P" .. s[i])
    end
    self:sendExtendedOpcode(Config.TasksOpCode, "E" .. s[#s])
  end
  -- Send active tasks
  local active = {}
  for slot = 1, Config.ActiveTasksLimit do
    local taskId = self:getTaskIdBySlot(slot)
    if taskId ~= 0 then
      local requiredKills = self:getTaskRequiredKills(slot)
      local kills = self:getTaskKills(slot)
      table.insert(
        active,
        {
          kills = kills,
          required = requiredKills,
          slot = slot,
          taskId = taskId
        }
      )
    end
  end
  self:sendExtendedOpcode(Config.TasksOpCode, json.encode({action = "active", data = active}))
  self:sendTasksPointsUpdate()
end
function Player:sendTaskUpdate(taskId)
  local update = {}
  local slot = self:getSlotByTaskId(taskId)
  if not slot then
    update.status = 2 -- abandoned
    update.taskId = taskId
  else
    local requiredKills = self:getTaskRequiredKills(slot)
    local kills = self:getTaskKills(slot)
    if kills < requiredKills then
      update.status = 1 -- in progress
      update.kills = kills
      update.required = requiredKills
      update.taskId = taskId
    else
      update.status = 2 -- finished
      update.taskId = taskId
    end
  end
  self:sendExtendedOpcode(Config.TasksOpCode, json.encode({action = "update", data = update}))
end
function Player:sendTasksPointsUpdate()
  self:sendExtendedOpcode(Config.TasksOpCode, json.encode({action = "points", data = self:getTasksPoints()}))
end
function Player:startNewTask(taskId, kills)
  local task = Config.Tasks[taskId]
  if task then
    local slot = self:getFreeTaskSlot()
    if not slot then
      self:popupFYI("You can't accept more tasks.")
      return
    end
    if self:getSlotByTaskId(taskId) then
      self:popupFYI("You already have this task active.")
      return
    end
    -- Verificando quantas vezes a tarefa foi completada
    local taskCompletionCount = tonumber(self:getStorageValue(Config.StorageTaskCompletions + taskId)) or 0 -- << corrigido: numeric
    if taskCompletionCount >= 2 then
      self:popupFYI("You have already completed this task twice.")
      return
    end
    -- Atualizar as kills m nimas e m ximas
    kills = tonumber(kills) or Config.RequiredKills.Min
    kills = math.max(kills, Config.RequiredKills.Min)
    kills = math.min(kills, Config.RequiredKills.Max)
    -- Iniciar a tarefa (NÃO incrementar completadas aqui)
    self:setStorageValue(Config.StorageSlot + slot, taskId)
    self:setStorageValue(Config.StorageKillsCurrent + slot, 0)
    self:setStorageValue(Config.StorageKillsSelected + slot, kills)
    self:sendTaskUpdate(taskId)
  end
end
function Player:cancelTask(taskId)
  local task = Config.Tasks[taskId]
  if task then
    local slot = self:getSlotByTaskId(taskId)
    if slot then
      self:setStorageValue(Config.StorageSlot + slot, -1)
      self:setStorageValue(Config.StorageKillsCurrent + slot, -1)
      self:setStorageValue(Config.StorageKillsSelected + slot, -1)
      self:sendTaskUpdate(taskId)
    end
  end
end
local KillEvent = CreatureEvent("TasksKill")
function KillEvent.onKill(player, target)
  if not target or target:isPlayer() or target:getMaster() then
    return true
  end
  local taskId = Cache.Tasks[string.lower(target:getName())]
  if taskId then
    local task = Config.Tasks[taskId]
    if task then
      local party = player:getParty()
      if party and Config.Party.Enabled then
        local members = party:getMembers()
        table.insert(members, party:getLeader())
        local killerPos = player:getPosition()
        for _, member in ipairs(members) do
          if Config.Party.Range > 0 then
            if member:getPosition():getDistance(killerPos) <= Config.Party.Range then
              member:taskProcessKill(taskId)
            end
          else
            member:taskProcessKill(taskId)
          end
        end
      else
        player:taskProcessKill(taskId)
      end
    end
  end
  return true
end
function Player:taskProcessKill(taskId)
  local slot = self:getSlotByTaskId(taskId)
  if slot then
    self:addTaskKill(slot)
    local requiredKills = self:getTaskRequiredKills(slot)
    local kills = self:getTaskKills(slot)
    if kills >= requiredKills then
      -- Ao concluir: incrementar completadas por taskId e limpar slot
      local key = Config.StorageTaskCompletions + taskId -- << corrigido
      local completed = tonumber(self:getStorageValue(key)) or 0 -- << corrigido
      self:setStorageValue(key, completed + 1) -- << corrigido

      self:setStorageValue(Config.StorageSlot + slot, -1)
      self:setStorageValue(Config.StorageKillsCurrent + slot, -1)
      self:setStorageValue(Config.StorageKillsSelected + slot, -1)

      local task = Config.Tasks[taskId]
      for _, reward in ipairs(task.Rewards) do
        self:addTaskReward(reward, requiredKills)
      end
      self:sendTextMessage(MESSAGE_STATUS_CONSOLE_ORANGE, "[Task Status] You have finished " .. task.RaceName .. " task!")
    end
    self:sendTaskUpdate(taskId)
  end
end
function Player:addTaskReward(reward, requiredKills)
  local bonus = math.floor((math.max(0, requiredKills - Config.KillsForBonus) / Config.KillsForBonus + 0.5))  -- Corrigido
  local isMaxKills = (requiredKills == Config.RequiredKills.Max)
  if reward.Type == RewardType.Points then
    bonus = bonus * Config.PointsIncrease
    local value = reward.BaseValue + math.floor((reward.BaseValue * bonus / 100) + 0.5)
    
    -- B nus adicional por escolher 3000 kills
    if isMaxKills then
      value = value + Config.MaxKillsBonus.Points
    end
    
    self:addTasksPoints(value)
    self:sendTextMessage(
      MESSAGE_STATUS_CONSOLE_ORANGE,
      "[Task Reward] Tasks Points +" .. value .. ", you have now " .. self:getTasksPoints() .. " tasks points." ..
      (isMaxKills and "\n[Bonus] +5 extra points for completing maximum kills!" or "")
    )
  elseif reward.Type == RewardType.Experience then
    bonus = bonus * Config.ExperienceIncrease
    local value = reward.BaseValue + math.floor((reward.BaseValue * bonus / 100) + 0.5)
    
    -- B nus adicional por escolher 3000 kills
    if isMaxKills then
      value = value + math.floor(reward.BaseValue * Config.MaxKillsBonus.Experience)
    end
    
    self:addExperience(value, true)
    self:sendTextMessage(
      MESSAGE_STATUS_CONSOLE_ORANGE, 
      "[Task Reward] Experience +" .. value .. "." ..
      (isMaxKills and "\n[Bonus] +20% extra experience for completing maximum kills!" or "")
    )
  elseif reward.Type == RewardType.Gold then
    bonus = bonus * Config.GoldIncrease
    local value = reward.BaseValue + math.floor((reward.BaseValue * bonus / 100) + 0.5)
    
    -- B nus adicional por escolher 3000 kills
    if isMaxKills then
      value = value + math.floor(reward.BaseValue * Config.MaxKillsBonus.Gold)
    end
    
    self:setBankBalance(self:getBankBalance() + value)
    self:sendTextMessage(
      MESSAGE_STATUS_CONSOLE_ORANGE, 
      "[Task Reward] " .. value .. " gold added to your bank." ..
      (isMaxKills and "\n[Bonus] +20% extra gold for completing maximum kills!" or "")
    )
  elseif reward.Type == RewardType.Item then
    local itemType = ItemType(reward.Id)
    local itemWeight = itemType:getWeight(reward.Amount)
    local playerCap = self:getFreeCapacity()
    if playerCap >= itemWeight then
      self:addItem(reward.Id, reward.Amount)
      self:sendTextMessage(MESSAGE_STATUS_CONSOLE_ORANGE, "[Task Reward] " .. reward.Amount .. "x " .. itemType:getName() .. ".")
    else
      self:getStoreInbox():addItem(reward.Id, reward.Amount)
      self:sendTextMessage(
        MESSAGE_STATUS_CONSOLE_ORANGE,
        "[Task Reward] Low on capacity, sending " .. reward.Amount .. "x " .. itemType:getName() .. " to your Purse."
      )
    end
  elseif reward.Type == RewardType.Storage then
    if self:getStorageValue(reward.Key) ~= reward.Value then
      self:setStorageValue(reward.Key, reward.Value)
      self:sendTextMessage(MESSAGE_STATUS_CONSOLE_ORANGE, '[Task Reward] You have been granted "' .. reward.Description .. '".')
    end
  elseif reward.Type == RewardType.Teleport then
    self:teleportTo(reward.Position)
    self:sendTextMessage(MESSAGE_STATUS_CONSOLE_ORANGE, '[Task Reward] You have been teleported to "' .. reward.Description .. '".')
  end
end
function Player:getTaskIdBySlot(slot)
  return math.max(0, tonumber(self:getStorageValue(Config.StorageSlot + slot)) or 0) -- << robusto
end
function Player:getSlotByTaskId(taskId)
  for i = 1, Config.ActiveTasksLimit do
    local slotTask = self:getTaskIdBySlot(i)
    if taskId == slotTask then
      return i
    end
  end
  return nil
end
function Player:getTaskKills(slot)
  return math.max(0, tonumber(self:getStorageValue(Config.StorageKillsCurrent + slot)) or 0) -- << robusto
end
function Player:getTaskRequiredKills(slot)
  return math.max(0, tonumber(self:getStorageValue(Config.StorageKillsSelected + slot)) or 0) -- << robusto
end
function Player:addTaskKill(slot)
  self:setStorageValue(Config.StorageKillsCurrent + slot, self:getTaskKills(slot) + 1)
end
function Player:addTasksPoints(points)
  self:setStorageValue(Config.StoragePoints, self:getTasksPoints() + points)
  self:sendTasksPointsUpdate()
end
function Player:getTasksPoints()
  return math.max(0, tonumber(self:getStorageValue(Config.StoragePoints)) or 0) -- << robusto
end
function Player:getTasksRank()
  local rank = self:getTasksPoints()
  if rank >= Cache.LastRank then
    return Cache.Ranks[Cache.LastRank]
  end
  return Cache.Ranks[rank]
end
function MonsterType:getOutfitOTC()
  local outfit = self:outfit()
  return {
    type = outfit.lookType,
    auxType = outfit.lookTypeEx,
    head = outfit.lookHead,
    body = outfit.lookBody,
    legs = outfit.lookLegs,
    feet = outfit.lookFeet,
    addons = outfit.lookAddons,
    mount = outfit.lookMount
  }
end
local taskRankLook = Event()
function taskRankLook.onLook(player, thing, position, distance, description)
    if thing and thing:isPlayer() then
        local taskPoints = thing:getTasksPoints() -- << usar função consistente
        local rank = thing:getTasksRank() -- << evitar pairs sem ordem
        description = description .. string.format("\n[Task Rank: %s] [Points: %d]", rank, taskPoints)
    end
    
    return description
end
taskRankLook:register(1)
LoginEvent:type("login")
LoginEvent:register()
ExtendedEvent:type("extendedopcode")
ExtendedEvent:register()
KillEvent:type("kill")
KillEvent:register()
StartupEvent:type("startup")
StartupEvent:register()
