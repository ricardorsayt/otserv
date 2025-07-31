if not boostCreature then 
    boostCreature = {} 
end

BoostedCreature = {
    db = true,
    monsters = {
        -- Monstros comuns e fracos (geralmente encontrados em áreas de iniciantes ou cavernas simples)
        normal = {
            "bug", "cave rat", "spider", "poison spider", "wasp", "snake", "troll", "goblin",
            "bear", "wolf", "wild warrior", "orc", "orc spearman", "orc warrior", "rotworm",
            "skeleton", "ghoul", "corym", "minotaur", "cyclops", "dwarf", "dwarf soldier",
            "amazon", "valkyrie", "larva", "scarab", "hyaena", "gargoyle", "bonelord",
            "fire devil", "demon skeleton", "monk", "priestess", "witch", "stalker",
            "black sheep", "sheep", "pig", "deer", "dog", "lion", "polar bear", "scorpion",
            "frost giant", "ice golem", "earth elemental", "fire elemental", "energy elemental",
            "ghost", "slime"
        },
        -- Monstros de nível médio (geralmente exigem mais de um jogador ou níveis mais altos)
        medium = {
            "orc shaman", "orc berserker", "orc leader", "dwarf guard", "minotaur guard",
            "minotaur mage", "mummy", "ancient scarab", "bonebeast", "vampire", "dragon",
            "dragon hatchling", "dragon lord hatchling", "hero", "lich", "black knight",
            "pirate ghost", "demon", "warlock", "behemoth", "hydra", "serpent spawn",
            "undead dragon", "wyvern"
        },
        -- Monstros mais fortes ou de áreas avançadas (quase bosses, mas ainda spawns regulares)
        hard = {
            "dragon lord", "frost dragon", "elder wyrm", "giant spider", "grim reaper",
            "hellfire fighter", "juggernaut", "medusa", "nightstalker", "serpent spawn",
            "undead dragon", "warlock", "demon"
        },
        -- Bosses clássicos da versão 8.0
        boss = {
            "ferumbras", "ghazbaran", "morgaroth", "orshabaal", "demodras", "dharalion",
            "the imperor", "the old widow", "the plasmother", "the maw", "bragrumol",
            "deathstrike", "the welter", "the many", "zushuka", "zavarash", "zamulosh",
            "zugurosh", "mawhawk", "tanjis", "jaul", "shardhead", "esmeralda", "leviathan",
            "kerberos", "ethershreck", "ocyakao", "necropharus", "the horned fox",
            "the evil eye", "the pale count", "massacre", "dracola", "zoralurk",
            "hairman the huge", "hellgorak", "bibby bloodbath", "grimgor guteater",
            "rocky", "tirecz", "bazir", "zomba", "countess sorrow", "mr. punish",
            "the abomination", "the pit lord", "" -- Adicione outros bosses 8.0 se desejar
        }
    },
    bonuses = {
        normal = { exp = {min = 15, max = 25}, loot = {min = 10, max = 30} }, -- Ajustado para monstros mais fracos
        medium = { exp = {min = 25, max = 35}, loot = {min = 20, max = 40} }, -- Nova categoria
        hard = { exp = {min = 35, max = 45}, loot = {min = 30, max = 50} },   -- Nova categoria
        boss = { exp = {min = 50, max = 75}, loot = {min = 40, max = 70} }    -- Bônus maiores para bosses
    },
    positions = {
        normal = Position(92, 114, 7),
        medium = Position(92, 115, 7), -- Nova posicao para categoria 'medium'
        hard = Position(92, 117, 7),   -- Nova posicao para categoria 'hard'
        boss = Position(92, 118, 7)
    },
    messages = {
        normal = "A criatura escolhida e %s. Ao ser morta, voce recebe +%d de experiencia e +%d de loot.",
        medium = "A criatura de nivel medio escolhida e %s. Ao ser morta, voce recebe +%d de experiencia e +%d de loot.",
        hard = "A criatura forte escolhida e %s. Ao ser morta, voce recebe +%d de experiencia e +%d de loot.",
        boss = "O boss escolhido e %s. Ao ser morto, voce recebe +%d de experiencia e +%d de loot."
    },
    -- Dias da semana para cada tipo de criatura boosted
    -- Em Lua, os.date("*t").wday retorna:
    -- 1 = Domingo, 2 = Segunda, 3 = Terça, 4 = Quarta, 5 = Quinta, 6 = Sexta, 7 = Sábado
    schedule = {
        normal = {1, 2, 3, 4, 5, 6, 7}, -- Todos os dias
        medium = {2, 4, 6},            -- Segunda, Quarta, Sexta
        hard = {3, 5},                 -- Terça, Quinta
        boss = {1, 7}                  -- Domingo e Sábado
    }
}

function BoostedCreature:start()
    math.randomseed(os.time())
    for i = 1, 10 do
        math.random()
    end
    
    local currentDayOfWeek = os.date("*t").wday
    
    local rand = math.random
    boostCreature = {}
    
    for category, monsterList in pairs(self.monsters) do
        local isDayScheduled = false
        
        -- Verifica se a categoria esta agendada para o dia atual da semana
        if self.schedule[category] then
            for _, day in ipairs(self.schedule[category]) do
                if day == currentDayOfWeek then
                    isDayScheduled = true
                    break
                end
            end
        end
        
        if isDayScheduled then
            local monsterRand = monsterList[rand(#monsterList)]
            local expRand = rand(self.bonuses[category].exp.min, self.bonuses[category].exp.max)
            local lootRand = rand(self.bonuses[category].loot.min, self.bonuses[category].loot.max)
            table.insert(boostCreature, {name = monsterRand:lower(), exp = expRand, loot = lootRand, category = category})
            
            -- Cria o monstro no mapa
            local monster = Game.createMonster(boostCreature[#boostCreature].name, self.positions[category], false, true)
            if monster then
                monster:setDirection(SOUTH)
            end
        end
    end
end

function firstToUpper(str)
    return (str:gsub("^%l", string.upper))
end

function getBoostedCreature()
    return boostCreature
end
