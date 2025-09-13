-- christmas event configuration

local info = {
    action_ids = {
        lever = 41250,
        door = 41251,
    },
    storages = {
        defeated_grinches_amount = 6126,
        max_amount_status = 6127,
        storage_delay = 6128,
    },
    positions = {
        waiting_room_start_event = {
            [1] = {x = 31921, y = 31711, z = 7},  -- "Leader"
            [2] = {x = 31921, y = 31712, z = 7},
            [3] = {x = 31921, y = 31713, z = 7},
            [4] = {x = 31921, y = 31714, z = 7},
        },
        player_event_event = { -- posição para teleportar os jogadores ao iniciar o evento
            [1] = {x = 31884, y = 31709, z = 7},
            [2] = {x = 31894, y = 31709, z = 7},
            [3] = {x = 31894, y = 31719, z = 7},
            [4] = {x = 31884, y = 31719, z = 7},
        },
        on_enter_waiting_room = {x =31921 , y =31716 , z =7 },
        npc_spawn = { x = 31961, y = 31711, z = 7 }
    },
    teamLevelBonusModifiers = {
        -- proporcional a 2/3 do nível mais alto do time
        -- Como dificuldade, vamos somar o level de todos os jogadores como "team level"
        lifeIncreasePercentagePerLevel = 0.50,       -- % adicional para cada "team level" para vida
        damageIncreasePercentagePerLevel = 0.25,     -- % adicional para cada "team level" para dano.
        defenseIncreasePercentagePerLevel = 0.005,    -- % adicional para cada "team level" para defesa.
        regenIncreasePercentagePerLevel = 0.10,      -- % adicional para cada "team level" para regen.
        speedIncreasePercentagePerLevel = 0.05,      -- % adicional para cada "team level" para velocidade.
        experienceIncreasePercentagePerLevel = 0.05, -- % adicional para cada "team level" para experiência.
        maxLevelProportion = 2 / 3,
        sumLevelProportion = 1 / 10,
    },
    wild_behavior = {
        amount = 100, -- quantidade total de wilds espalhados aleatoriamente entre as regiões
        respawn_delay = 30, --INFO: Tempo de duração de respawn dos grinch selvagem
        regions = {
            -- regiões de spawn das criaturas wild
            {
                centerPosition = { x = 31978, y = 31708, z = 7 },
                radius = 5,
                helper_amount = 1,
            },
            {
                centerPosition = { x = 31956, y = 31726, z = 7 }, --31956, 31726, 7
                radius = 5,
                helper_amount = 1,
            },
            {
                centerPosition = { x = 31977, y = 31718, z = 7 }, --31977, 31718, 7
                radius = 5,
                helper_amount = 1,
            },
            {
                centerPosition = { x = 32000, y = 31710, z = 7 }, --32000, 31710, 7
                radius = 5,
                helper_amount = 1,
            },
            {
                centerPosition = { x = 31990, y = 31694, z = 7 }, --31990, 31694, 7
                radius = 5,
                helper_amount = 1,
            },
            {
                centerPosition = { x = 32013, y = 31694, z = 7 }, --32013, 31694, 7
                radius = 5,
                helper_amount = 1,
            },
        }
    },
    creatures = {
        minion = "Grinch",
        helper = "Helper Elf",
        boss = {
            name = "Evil Grinch",
            experience = 200000,
        }
    },

    -- event / room configs
    position_boss_spawn = {x = 31889, y = 31714, z = 7}, -- boss_spawn_
    room = {
        topleft = { x = 31882, y = 31709, z = 7 },
        bottomright = { x = 31896, y = 31719, z = 7 },
    },
    minions_trigger = {
        life_trigger = 0.4, -- % de vida do boss que desaparece e sumona minions, só volta após derrotá-los
        duration = 60, --INFO: Duração do tempo "recuperação" do Evil Grinch após sumir e spawnar os minions
        amount = 4,
    },
    event_duration = 10 * 60, --INFO: Duração máxima do evento
    duration_waiting_exit = 60, --INFO: Duração de tempo para resgatar recompensa
    rewards = {
        -- {itemid, amount, chance}
        rare = {
            backpack = 1990,
            {
                { 2108, 1, 100 }, -- wooden doll
                { 2109, 1, 100 }, -- footbal
                { 2110, 1, 100 }, -- doll
                { 2113, 1, 100 }, -- model ship
                { 2123, 1, 50 }, -- ring of the sky
                { 2153, 1, 100 }, -- violet gem
                { 2154, 1, 100 }, -- yellow gem
                { 2155, 1, 100 }, -- green gem
                { 2156, 1, 100 }, -- red gem
                { 2158, 1, 100 }, -- blue gem
                { 2162, 1, 100 }, -- magic light wand
                { 2164, 100, 100 }, -- might ring
                { 2165, 1, 100 }, -- stealth ring
                { 2167, 1, 100 }, -- energy ring
                { 2168, 1, 100 }, -- life ring
                { 2169, 1, 100 }, --  time ring
                { 2173, 1, 50 }, --  aol
                { 2179, 1, 100 }, --  gold ring
                { 2207, 1, 100 }, --  sword ring
                { 2208, 1, 100 }, --  axe ring
                { 2209, 1, 100 }, --  club ring
                { 2214, 1, 100 }, --  ring of healing
                { 2181, 1, 50 }, --  wooden wand
                { 2182, 1, 50 }, --  golden wand
                { 2183, 1, 50 }, --  elven wand
                { 2184, 1, 50 }, --  crystal wand
                { 2185, 1, 50 }, --  wand of might
                { 2186, 1, 50 }, --  conujurer wand
                { 2187, 1, 50 }, --  ritual wand
                { 2188, 1, 100 }, --  green spell wand
                { 2189, 1, 100 }, --  yellow spell wand
                { 2190, 1, 100 }, --  blue spell wand
                { 2191, 1, 100 }, --  red spell wand
                { 2644, 1, 50 }, --  bunnyslippers
                { 5129, 1, 150 }, --  grinch doll
                { 5130, 1, 150 }, --  santa klaus doll
                { 5131, 1, 150 }, --  christmas backpack
                { 5132, 1, 150 }, --  christmas backpack
                { 5133, 1, 150 }, --  grinch backpack
                { 5134, 1, 150 }, --  grinch backpack
                { 5135, 1, 150 }, --  grinch backpack
                { 5136, 1, 150 }, --  grinch backpack
            },
            {
                { 2108, 1, 100 }, -- wooden doll
                { 2109, 1, 100 }, -- footbal
                { 2110, 1, 100 }, -- doll
                { 2113, 1, 100 }, -- model ship
                { 2123, 1, 25 }, -- ring of the sky
                { 2153, 1, 100 }, -- violet gem
                { 2154, 1, 100 }, -- yellow gem
                { 2155, 1, 100 }, -- green gem
                { 2156, 1, 100 }, -- red gem
                { 2158, 1, 100 }, -- blue gem
                { 2162, 1, 100 }, -- magic light wand
                { 2164, 100, 100 }, -- might ring
                { 2165, 1, 100 }, -- stealth ring
                { 2167, 1, 100 }, -- energy ring
                { 2168, 1, 100 }, -- life ring
                { 2169, 1, 100 }, --  time ring
                { 2173, 1, 25 }, --  aol
                { 2179, 1, 100 }, --  gold ring
                { 2207, 1, 100 }, --  sword ring
                { 2208, 1, 100 }, --  axe ring
                { 2209, 1, 100 }, --  club ring
                { 2214, 1, 100 }, --  ring of healing
                { 2181, 1, 25 }, --  wooden wand
                { 2182, 1, 25 }, --  golden wand
                { 2183, 1, 25 }, --  elven wand
                { 2184, 1, 25 }, --  crystal wand
                { 2185, 1, 25 }, --  wand of might
                { 2186, 1, 25 }, --  conujurer wand
                { 2187, 1, 25 }, --  ritual wand
                { 2188, 1, 50 }, --  green spell wand
                { 2189, 1, 50 }, --  yellow spell wand
                { 2190, 1, 50 }, --  blue spell wand
                { 2191, 1, 50 }, --  red spell wand
                { 2644, 1, 25 }, --  bunnyslippers
                { 5129, 1, 150 }, --  grinch doll
                { 5130, 1, 150 }, --  santa klaus doll
                { 5131, 1, 150 }, --  christmas backpack
                { 5132, 1, 150 }, --  christmas backpack
                { 5133, 1, 150 }, --  grinch backpack
                { 5134, 1, 150 }, --  grinch backpack
                { 5135, 1, 150 }, --  grinch backpack
                { 5136, 1, 150 }, --  grinch backpack
            },
            {
                { 2108, 1, 100 }, -- wooden doll
                { 2109, 1, 100 }, -- footbal
                { 2110, 1, 100 }, -- doll
                { 2113, 1, 100 }, -- model ship
                { 2123, 1, 10 }, -- ring of the sky
                { 2153, 1, 100 }, -- violet gem
                { 2154, 1, 100 }, -- yellow gem
                { 2155, 1, 100 }, -- green gem
                { 2156, 1, 100 }, -- red gem
                { 2158, 1, 100 }, -- blue gem
                { 2162, 1, 100 }, -- magic light wand
                { 2164, 100, 100 }, -- might ring
                { 2165, 1, 100 }, -- stealth ring
                { 2167, 1, 100 }, -- energy ring
                { 2168, 1, 100 }, -- life ring
                { 2169, 1, 100 }, --  time ring
                { 2173, 1, 10 }, --  aol
                { 2179, 1, 100 }, --  gold ring
                { 2207, 1, 100 }, --  sword ring
                { 2208, 1, 100 }, --  axe ring
                { 2209, 1, 100 }, --  club ring
                { 2214, 1, 100 }, --  ring of healing
                { 2181, 1, 10 }, --  wooden wand
                { 2182, 1, 10 }, --  golden wand
                { 2183, 1, 10 }, --  elven wand
                { 2184, 1, 10 }, --  crystal wand
                { 2185, 1, 10 }, --  wand of might
                { 2186, 1, 10 }, --  conujurer wand
                { 2187, 1, 10 }, --  ritual wand
                { 2188, 1, 25 }, --  green spell wand
                { 2189, 1, 25 }, --  yellow spell wand
                { 2190, 1, 25 }, --  blue spell wand
                { 2191, 1, 25 }, --  red spell wand
                { 2644, 1, 10 }, --  bunnyslippers
                { 5129, 1, 150 }, --  grinch doll
                { 5130, 1, 150 }, --  santa klaus doll
                { 5131, 1, 150 }, --  christmas backpack
                { 5132, 1, 150 }, --  christmas backpack
                { 5133, 1, 150 }, --  grinch backpack
                { 5134, 1, 150 }, --  grinch backpack
                { 5135, 1, 150 }, --  grinch backpack
                { 5136, 1, 150 }, --  grinch backpack
            },
            {
                { 2151, 100, 100 }, -- talon
                { 2160, 10, 100 }, -- crystal coin
                { 2143, 100, 100 }, -- white pearl
                { 2144, 100, 100 }, -- black pearl
                { 2145, 100, 100 }, -- small diamond
                { 2146, 100, 100 }, -- small saphire
                { 2147, 100, 100 }, -- small ruby
                { 2149, 100, 100 }, -- small emerald
                { 2150, 100, 100 }, -- small amethyst
                { 2798, 15, 100 }, -- blood herb
            },
            {
                { 2268, 100, 100 }, -- SD
                { 2273, 100, 100 }, -- UH
                { 2304, 100, 100 }, -- GFB
                { 2311, 100, 100 }, -- HMM
                { 2313, 100, 100 }, -- EXPO
            },
        },
        uncommon = {
            backpack = 1990,
            {
                { 2108, 1, 100 }, -- wooden doll
                { 2109, 1, 100 }, -- footbal
                { 2110, 1, 100 }, -- doll
                { 2113, 1, 100 }, -- model ship
                { 2123, 1, 25 }, -- ring of the sky
                { 2153, 1, 100 }, -- violet gem
                { 2154, 1, 100 }, -- yellow gem
                { 2155, 1, 100 }, -- green gem
                { 2156, 1, 100 }, -- red gem
                { 2158, 1, 100 }, -- blue gem
                { 2162, 1, 100 }, -- magic light wand
                { 2164, 75, 100 }, -- might ring
                { 2165, 1, 100 }, -- stealth ring
                { 2167, 1, 100 }, -- energy ring
                { 2168, 1, 100 }, -- life ring
                { 2169, 1, 100 }, --  time ring
                { 2173, 1, 25 }, --  aol
                { 2179, 1, 100 }, --  gold ring
                { 2207, 1, 100 }, --  sword ring
                { 2208, 1, 100 }, --  axe ring
                { 2209, 1, 100 }, --  club ring
                { 2214, 1, 100 }, --  ring of healing
                { 2181, 1, 25 }, --  wooden wand
                { 2182, 1, 25 }, --  golden wand
                { 2183, 1, 25 }, --  elven wand
                { 2184, 1, 25 }, --  crystal wand
                { 2185, 1, 25 }, --  wand of might
                { 2186, 1, 25 }, --  conujurer wand
                { 2187, 1, 25 }, --  ritual wand
                { 2188, 1, 100 }, --  green spell wand
                { 2189, 1, 100 }, --  yellow spell wand
                { 2190, 1, 100 }, --  blue spell wand
                { 2191, 1, 100 }, --  red spell wand
                { 2644, 1, 25 }, --  bunnyslippers
                { 5129, 1, 100 }, --  grinch doll
                { 5130, 1, 100 }, --  santa klaus doll
                { 5131, 1, 100 }, --  christmas backpack
                { 5132, 1, 100 }, --  christmas backpack
                { 5133, 1, 100 }, --  grinch backpack
                { 5134, 1, 100 }, --  grinch backpack
                { 5135, 1, 100 }, --  grinch backpack
                { 5136, 1, 100 }, --  grinch backpack
            },
            {
                { 2108, 1, 100 }, -- wooden doll
                { 2109, 1, 100 }, -- footbal
                { 2110, 1, 100 }, -- doll
                { 2113, 1, 100 }, -- model ship
                { 2123, 1, 25 }, -- ring of the sky
                { 2153, 1, 100 }, -- violet gem
                { 2154, 1, 100 }, -- yellow gem
                { 2155, 1, 100 }, -- green gem
                { 2156, 1, 100 }, -- red gem
                { 2158, 1, 100 }, -- blue gem
                { 2162, 1, 100 }, -- magic light wand
                { 2164, 75, 100 }, -- might ring
                { 2165, 1, 100 }, -- stealth ring
                { 2167, 1, 100 }, -- energy ring
                { 2168, 1, 100 }, -- life ring
                { 2169, 1, 100 }, --  time ring
                { 2173, 1, 25 }, --  aol
                { 2179, 1, 100 }, --  gold ring
                { 2207, 1, 100 }, --  sword ring
                { 2208, 1, 100 }, --  axe ring
                { 2209, 1, 100 }, --  club ring
                { 2214, 1, 100 }, --  ring of healing
                { 2181, 1, 25 }, --  wooden wand
                { 2182, 1, 25 }, --  golden wand
                { 2183, 1, 25 }, --  elven wand
                { 2184, 1, 25 }, --  crystal wand
                { 2185, 1, 25 }, --  wand of might
                { 2186, 1, 25 }, --  conujurer wand
                { 2187, 1, 25 }, --  ritual wand
                { 2188, 1, 50 }, --  green spell wand
                { 2189, 1, 50 }, --  yellow spell wand
                { 2190, 1, 50 }, --  blue spell wand
                { 2191, 1, 50 }, --  red spell wand
                { 2644, 1, 25 }, --  bunnyslippers
                { 5129, 1, 100 }, --  grinch doll
                { 5130, 1, 100 }, --  santa klaus doll
                { 5131, 1, 100 }, --  christmas backpack
                { 5132, 1, 100 }, --  christmas backpack
                { 5133, 1, 100 }, --  grinch backpack
                { 5134, 1, 100 }, --  grinch backpack
                { 5135, 1, 100 }, --  grinch backpack
                { 5136, 1, 100 }, --  grinch backpack
            },            {
                { 2108, 1, 100 }, -- wooden doll
                { 2109, 1, 100 }, -- footbal
                { 2110, 1, 100 }, -- doll
                { 2113, 1, 100 }, -- model ship
                { 2123, 1, 25 }, -- ring of the sky
                { 2153, 1, 100 }, -- violet gem
                { 2154, 1, 100 }, -- yellow gem
                { 2155, 1, 100 }, -- green gem
                { 2156, 1, 100 }, -- red gem
                { 2158, 1, 100 }, -- blue gem
                { 2162, 1, 100 }, -- magic light wand
                { 2164, 75, 100 }, -- might ring
                { 2165, 1, 100 }, -- stealth ring
                { 2167, 1, 100 }, -- energy ring
                { 2168, 1, 100 }, -- life ring
                { 2169, 1, 100 }, --  time ring
                { 2173, 1, 25 }, --  aol
                { 2179, 1, 100 }, --  gold ring
                { 2207, 1, 100 }, --  sword ring
                { 2208, 1, 100 }, --  axe ring
                { 2209, 1, 100 }, --  club ring
                { 2214, 1, 100 }, --  ring of healing
                { 2181, 1, 25 }, --  wooden wand
                { 2182, 1, 25 }, --  golden wand
                { 2183, 1, 25 }, --  elven wand
                { 2184, 1, 25 }, --  crystal wand
                { 2185, 1, 25 }, --  wand of might
                { 2186, 1, 25 }, --  conujurer wand
                { 2187, 1, 25 }, --  ritual wand
                { 2188, 1, 25 }, --  green spell wand
                { 2189, 1, 25 }, --  yellow spell wand
                { 2190, 1, 25 }, --  blue spell wand
                { 2191, 1, 25 }, --  red spell wand
                { 2644, 1, 25 }, --  bunnyslippers
                { 5129, 1, 100 }, --  grinch doll
                { 5130, 1, 100 }, --  santa klaus doll
                { 5131, 1, 100 }, --  christmas backpack
                { 5132, 1, 100 }, --  christmas backpack
                { 5133, 1, 100 }, --  grinch backpack
                { 5134, 1, 100 }, --  grinch backpack
                { 5135, 1, 100 }, --  grinch backpack
                { 5136, 1, 100 }, --  grinch backpack
            },
            {
                { 2151, 75, 100 }, -- talon
                { 2160, 5, 100 }, -- crystal coin
                { 2143, 75, 100 }, -- white pearl
                { 2144, 75, 100 }, -- black pearl
                { 2145, 75, 100 }, -- small diamond
                { 2146, 75, 100 }, -- small saphire
                { 2147, 75, 100 }, -- small ruby
                { 2149, 75, 100 }, -- small emerald
                { 2150, 75, 100 }, -- small amethyst
                { 2798, 10, 100 }, -- blood herb
            },
            {
                { 2265, 75, 100 }, -- IH
                { 2268, 75, 100 }, -- SD
                { 2273, 75, 100 }, -- UH
                { 2287, 75, 100 }, -- LMM
                { 2301, 75, 100 }, -- FF
                { 2302, 75, 100 }, -- FB
                { 2304, 75, 100 }, -- GFB
                { 2311, 75, 100 }, -- HMM
                { 2313, 75, 100 }, -- EXPO
                { 2277, 75, 100 }, -- EF
            },
        },
        common = {
            backpack = 1990,
            {
                { 2108, 1, 100 }, -- wooden doll
                { 2109, 1, 100 }, -- footbal
                { 2110, 1, 100 }, -- doll
                { 2113, 1, 100 }, -- model ship
                { 2153, 1, 100 }, -- violet gem
                { 2154, 1, 100 }, -- yellow gem
                { 2155, 1, 100 }, -- green gem
                { 2156, 1, 100 }, -- red gem
                { 2158, 1, 100 }, -- blue gem
                { 2162, 1, 100 }, -- magic light wand
                { 2164, 50, 100 }, -- might ring
                { 2165, 1, 100 }, -- stealth ring
                { 2167, 1, 100 }, -- energy ring
                { 2168, 1, 100 }, -- life ring
                { 2169, 1, 100 }, --  time ring
                { 2179, 1, 100 }, --  gold ring
                { 2207, 1, 100 }, --  sword ring
                { 2208, 1, 100 }, --  axe ring
                { 2209, 1, 100 }, --  club ring
                { 2214, 1, 100 }, --  ring of healing
                { 2188, 1, 100 }, --  green spell wand
                { 2189, 1, 100 }, --  yellow spell wand
                { 2190, 1, 100 }, --  blue spell wand
                { 2191, 1, 100 }, --  red spell wand
                { 5129, 1, 100 }, --  grinch doll
                { 5130, 1, 100 }, --  santa klaus doll
                { 5131, 1, 100 }, --  christmas backpack
                { 5132, 1, 100 }, --  christmas backpack
                { 5133, 1, 100 }, --  grinch backpack
                { 5134, 1, 100 }, --  grinch backpack
                { 5135, 1, 100 }, --  grinch backpack
                { 5136, 1, 100 }, --  grinch backpack
            },            {
                { 2108, 1, 100 }, -- wooden doll
                { 2109, 1, 100 }, -- footbal
                { 2110, 1, 100 }, -- doll
                { 2113, 1, 100 }, -- model ship
                { 2153, 1, 100 }, -- violet gem
                { 2154, 1, 100 }, -- yellow gem
                { 2155, 1, 100 }, -- green gem
                { 2156, 1, 100 }, -- red gem
                { 2158, 1, 100 }, -- blue gem
                { 2162, 1, 100 }, -- magic light wand
                { 2164, 50, 100 }, -- might ring
                { 2165, 1, 100 }, -- stealth ring
                { 2167, 1, 100 }, -- energy ring
                { 2168, 1, 100 }, -- life ring
                { 2169, 1, 100 }, --  time ring
                { 2179, 1, 100 }, --  gold ring
                { 2207, 1, 100 }, --  sword ring
                { 2208, 1, 100 }, --  axe ring
                { 2209, 1, 100 }, --  club ring
                { 2214, 1, 100 }, --  ring of healing
                { 2188, 1, 50 }, --  green spell wand
                { 2189, 1, 50 }, --  yellow spell wand
                { 2190, 1, 50 }, --  blue spell wand
                { 2191, 1, 50 }, --  red spell wand
                { 5129, 1, 100 }, --  grinch doll
                { 5130, 1, 100 }, --  santa klaus doll
                { 5131, 1, 100 }, --  christmas backpack
                { 5132, 1, 100 }, --  christmas backpack
                { 5133, 1, 100 }, --  grinch backpack
                { 5134, 1, 100 }, --  grinch backpack
                { 5135, 1, 100 }, --  grinch backpack
                { 5136, 1, 100 }, --  grinch backpack
            },
            {
                { 2108, 1, 100 }, -- wooden doll
                { 2109, 1, 100 }, -- footbal
                { 2110, 1, 100 }, -- doll
                { 2113, 1, 100 }, -- model ship
                { 2153, 1, 100 }, -- violet gem
                { 2154, 1, 100 }, -- yellow gem
                { 2155, 1, 100 }, -- green gem
                { 2156, 1, 100 }, -- red gem
                { 2158, 1, 100 }, -- blue gem
                { 2162, 1, 100 }, -- magic light wand
                { 2164, 50, 100 }, -- might ring
                { 2165, 1, 100 }, -- stealth ring
                { 2167, 1, 100 }, -- energy ring
                { 2168, 1, 100 }, -- life ring
                { 2169, 1, 100 }, --  time ring
                { 2179, 1, 100 }, --  gold ring
                { 2207, 1, 100 }, --  sword ring
                { 2208, 1, 100 }, --  axe ring
                { 2209, 1, 100 }, --  club ring
                { 2214, 1, 100 }, --  ring of healing
                { 2188, 1, 25 }, --  green spell wand
                { 2189, 1, 25 }, --  yellow spell wand
                { 2190, 1, 25 }, --  blue spell wand
                { 2191, 1, 25 }, --  red spell wand
                { 5129, 1, 100 }, --  grinch doll
                { 5130, 1, 100 }, --  santa klaus doll
                { 5131, 1, 100 }, --  christmas backpack
                { 5132, 1, 100 }, --  christmas backpack
                { 5133, 1, 100 }, --  grinch backpack
                { 5134, 1, 100 }, --  grinch backpack
                { 5135, 1, 100 }, --  grinch backpack
                { 5136, 1, 100 }, --  grinch backpack
            },
            {
                { 2151, 50, 100 }, -- talon
                { 2152, 100, 100 }, -- platinum coin
                { 2143, 50, 100 }, -- white pearl
                { 2144, 50, 100 }, -- black pearl
                { 2145, 50, 100 }, -- small diamond
                { 2146, 50, 100 }, -- small saphire
                { 2147, 50, 100 }, -- small ruby
                { 2149, 50, 100 }, -- small emerald
                { 2150, 50, 100 }, -- small amethyst
                { 2798, 5, 100 }, -- blood herb
            },
            {
                { 2265, 50, 100 }, -- IH
                { 2287, 50, 100 }, -- LMM
                { 2301, 50, 100 }, -- FF
                { 2302, 50, 100 }, -- FB
                { 2277, 50, 100 }, -- EF
            },
        },
    },
}

-- christmas event local functions

local Event = {
    running = false,
    cooldown = 0,

    maxLevel = 0,
    sumLevel = 0,
    running_minions = -1,
    rewards = {},
    regenMap = {},
    damageMap = {},
    playerDamageMap = {},
    
    -- add events
    addEventEventFinished = nil,
    bossIsBack = nil,
    receive_minions = nil,
    kickEventId = nil,

    bossname = "Evil Grinch",
}

local function broadcast_function(players, func)
    for _, player in pairs(players) do
        if player and player:isPlayer() then
            func(player)
        end
    end
end

local function broadcast_event_message(players, message, ...)
    local args = ...
    broadcast_function(players, function(player)
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format(message, args))
    end)
end

local function getEventCreatures()

    local center = {
        x = math.floor((info.room.topleft.x + info.room.bottomright.x) / 2),
        y = math.floor((info.room.topleft.y + info.room.bottomright.y) / 2),
        z = info.room.topleft.z
    }

    local rangeX = math.ceil(math.abs(info.room.bottomright.x - info.room.topleft.x) / 2 + 0.5)
    local rangeY = math.ceil(math.abs(info.room.bottomright.y - info.room.topleft.y) / 2 + 0.5)

    return Game.getSpectators(center, false, false, rangeX, rangeX, rangeY, rangeY)
end

local function notifyWaitingRoomSelectedPositions()
    for _, position in pairs(info.positions.waiting_room_start_event) do
        local pos = Position(position)
        if pos then
            pos:sendMagicEffect(CONST_ME_POFF)
        end
    end
end

local function spawn_christmas_creature(name, position, life_percent)
    local monster = Game.createMonster(name, position, true)
    if monster then
        monster:registerEvent("HealthChristmasEvent")
        monster:registerEvent("DeathChristmasEvent")

        local maxHealth = monster:getMaxHealth()
        local teamDifficulty = Event.getTeamLevelChallenge()
        maxHealth = maxHealth * (1 + teamDifficulty * info.teamLevelBonusModifiers.lifeIncreasePercentagePerLevel)

        monster:setMaxHealth(maxHealth)
        monster:setHealth(maxHealth * life_percent)

        monster:changeSpeed(monster:getSpeed() * (teamDifficulty * info.teamLevelBonusModifiers.speedIncreasePercentagePerLevel))
        return monster
    end
end

local function clean_room(message, toPosition)

    for _, creature in pairs(getEventCreatures()) do -- garantir que não tenha ninguém!
        if creature:isPlayer() then
            creature:getPosition():sendMagicEffect(CONST_ME_POFF)
            creature:teleportTo(toPosition, false)
            creature:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
            creature:sendTextMessage(MESSAGE_EVENT_ADVANCE, message)
            Event.unloadPlayer(creature)
            creature:setHealth(creature:getMaxHealth())
        else
            creature:remove()
        end
    end

    -- -- cleaning room
    -- local room = info.room
    -- for x = room.topleft.x, room.bottomright.x do
    --     for y = room.topleft.y, room.bottomright.y do
    --         for z = room.topleft.z, room.bottomright.z do
    --             local tile = Tile(Position(x, y, z))
    --             if tile and tile:getItemCount() > 0 then --TODO: Test with protection
    --                 -- Remove items
    --                 local items = tile:getItems()
    --                 if items then

    --                     for _, item in pairs(items) do
    --                         if item:getId() ~= 2768 then
    --                             item:remove()
    --                         end
    --                     end
    --                 end
    --             end
    --         end
    --     end
    -- end
end

local function randomPosition(region)
    local center = region.centerPosition
    local x = center.x + math.random(- region.radius, region.radius)
    local y = center.y + math.random(- region.radius, region.radius)
    local z = center.z
    return { x = x, y = y, z = z }
end

local function spawn_santa_klaus_helper(region, maxTry)
    if maxTry < 0 then
        print(">>> Christmas Event: Numero maximo de tentativas de spawnar helper foi atingido. Erro ao spawnar helper por falta de posição.")
        return true
    end
    
    local position = randomPosition(region)
    local tile = Tile(position)
    if not tile:isWalkable() then
        return spawn_santa_klaus_helper(region, maxTry - 1)
    end

    local monster = Game.createMonster(info.creatures.helper, position, false)
    if monster then
        monster:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
        return true
    end

    return false
end

local function spawn_random_wild_minion(maxTry)
    if maxTry < 0 then
        print(">>> Christmas Event: Numero maximo de tentativas de spawnar minion foi atingido. Erro ao spawnar minion por falta de posição.")
        return true
    end

    local position = randomPosition(info.wild_behavior.regions[math.random(1, #info.wild_behavior.regions)])
    local tile = Tile(position)
    if not tile:isWalkable() then
        return spawn_random_wild_minion(maxTry - 1)
    end

    local monster = Game.createMonster(info.creatures.minion, position, false)
    if monster then
        monster:registerEvent("DeathWildChristmasEvent")
        monster:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
        local messages = {
            "Let's trick all",
            "Evil Grinch needs us",
            "I'm back to trick you again"
        }
        monster:say(messages[math.random(1, #messages)], TALKTYPE_MONSTER_SAY)
        return true
    end

    return false
end

local function getMinionsDefeatedAmount(level)
    return math.floor(50 + 200 * (level - 8) / (80 - 8) + 0.5)
end

local function clean_events()
    stopEvent(Event.addEventEventFinished)
    stopEvent(Event.bossIsBack)
    stopEvent(Event.receive_minions)
    stopEvent(Event.kickEventId)
end

local function format_time(seconds)
    local hours = math.floor(seconds / 3600)
    local minutes = math.floor((seconds % 3600) / 60)
    seconds = math.floor(seconds % 60)

    local time_string = ""

    if hours > 0 then
        time_string = time_string .. hours .. (hours > 1 and " hours" or " hour")
    end

    if minutes > 0 then
        if time_string ~= "" then time_string = time_string .. ", " end
        time_string = time_string .. minutes .. (minutes > 1 and " minutes" or " minute")
    end

    if seconds > 0 then
        if time_string ~= "" then time_string = time_string .. " and " end
        time_string = time_string .. seconds .. (seconds > 1 and " seconds" or " second")
    end

    return time_string
end

-- christmas event global functions

function Event.getPlayers()
    local team = {}
    for _, player in pairs(getEventCreatures()) do
        if player:isPlayer() then
            team[player:getName()] = player
        end
    end
    return team
end

function Event.getWaitingRoomPlayers()
    local team = {}
    for _, position in pairs(info.positions.waiting_room_start_event) do
        local tile = Tile(position)
        if tile then
            local player = tile:getTopCreature()
            if player and player:isPlayer() then
                table.insert(team, player)
            end
        end
    end
    return team
end

function getPlayerChristmasEventStatus(player)

    local result = {}
    result.permission = false
    result.completed = false
    result.exhaust = 0

    if not player or not player:isPlayer() then 
        return result 
    end

    local amount = player:getStorageValue(info.storages.defeated_grinches_amount)
    local maxAmount = player:getStorageValue(info.storages.max_amount_status)
    local exhaust = player:getStorageValue(info.storages.storage_delay)

    if exhaust then
        result.exhaust = exhaust - os.time()
    end

    if maxAmount < 65001 then
    elseif maxAmount > 65000 then
        result.permission = true
    elseif maxAmount == 65002 then
        result.completed = true
    elseif maxAmount == 65003 then
        result.completed = true
    end

    return result
end

function Event.canStartEvent()
    local players = Event.getWaitingRoomPlayers()

    if Event.cooldown > os.time() then
        broadcast_event_message(players, "The Christmas Event is on cooldown. You must wait %s seconds.", Event.cooldown - os.time())
        return false
    end

    if Event.running then
        broadcast_event_message(players, "The Christmas Event is already running. You must wait the event finishs.")
        return false
    end
    
    local minPlayers = #info.positions.waiting_room_start_event
    if #players ~= minPlayers then
        broadcast_event_message(players, "You need %d players to start christmas event.", minPlayers)
        notifyWaitingRoomSelectedPositions()
        return false
    end

    local highestLevel = 0
    for _, player in pairs(players) do
        highestLevel = math.max(highestLevel, player:getLevel())
    end

    local minimum_level = math.floor(highestLevel * 2 / 3)
    for _, player in pairs(players) do
        if player:getLevel() < minimum_level then
            broadcast_event_message(players, "Player '%s' level is too low to participate.", player:getName())
            return false
        end
        
        local status = getPlayerChristmasEventStatus(player)
        if status.exhaust and status.exhaust > 0 then
            broadcast_event_message(players, "Player ".. player:getName() .." is on cooldown. He must wait ".. format_time(status.exhaust) .." to help Santa Klaus again.")
            return false
        end
    end

    return true
end

function Event.loadPlayer(player)

    if not player:isCreature() then 
        return false
    end

    player:registerEvent("ChristmasEventLogout")
    player:registerEvent("HealthChristmasEvent")
    player:registerEvent("ManaChristmasEvent")
    player:registerEvent("PrepareDeathChristmasEvent")
end

function Event.unloadPlayer(player)
    if not player:isCreature() then 
        return false
    end

    player:unregisterEvent("ChristmasEventLogout")
    player:unregisterEvent("HealthChristmasEvent")
    player:unregisterEvent("ManaChristmasEvent")
    player:unregisterEvent("PrepareDeathChristmasEvent")
end

function Event.startEvent()
    if not Event.canStartEvent() then
        return false
    end

    clean_room("You were kicked from the Christmas Event because it started.", info.positions.on_enter_waiting_room)
    
    Event.running = true

    local players = Event.getWaitingRoomPlayers()

    broadcast_event_message(players, "The Christmas Event has started! You have ten minutes to complete the challenge. Good luck!")
    
    Event.maxLevel = 0
    Event.sumLevel = 0
    Event.regenMap = {}
    Event.damageMap = {}
    Event.playerDamageMap = {}

    print(">> Inicio da tentativa de Christmas Event")

    for i, player in pairs(players) do
        print("\t" .. player:getName() .. " lv. " .. player:getLevel())
        Event.sumLevel = Event.sumLevel + player:getLevel()
        Event.maxLevel = math.max(Event.maxLevel, player:getLevel())

        Event.regenMap[player:getName()] = 0
        Event.damageMap[player:getName()] = 0
        Event.playerDamageMap[player:getName()] = 0
        
        Event.loadPlayer(player)

        player:teleportTo(info.positions.player_event_event[i])
        player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
    end
    print(">> Início da tentativa de Christmas Event (fim das informacoes)")
    Event.running_minions = -1

    local creature = spawn_christmas_creature(info.creatures.boss.name, info.position_boss_spawn, 1)
    
    Event.bossname = string.format("%s [Lv. %d]", info.creatures.boss.name, math.floor(Event.getTeamLevelChallenge()))
    if creature then
        creature:rename(Event.bossname)
    end
    clean_events()
    Event.kickEventId = addEvent(Event.finishEvent, info.event_duration * 1000, "You were kicked from the Christmas Event because you didn't kill the boss in time.")
end

function Event.getTeamLevelChallenge()
    return Event.maxLevel * info.teamLevelBonusModifiers.maxLevelProportion + Event.sumLevel * info.teamLevelBonusModifiers.sumLevelProportion
end

function Event.completeEvent()
    if not Event.running then
        return false
    end

    print("\n>> Christmas Event foi finalizado com sucesso (inicio das informacoes)")

    local totalDamage, totalRegen = 0, 0
    -- calcules total damage
    for name, damage in pairs(Event.damageMap) do
        totalDamage = totalDamage + math.abs(damage)
    end
    -- calcules total regen
    for name, regen in pairs(Event.regenMap) do
        totalRegen = totalRegen + math.abs(regen)
    end

    local players = Event.getPlayers()

    local experience = info.creatures.boss.experience * (1 + Event.getTeamLevelChallenge() * info.teamLevelBonusModifiers.experienceIncreasePercentagePerLevel)

    print(string.format("\ttotalDamage %d", totalDamage))
    print(string.format("\ttotalRegen %d", totalRegen))
    print(string.format("\tEvent exp %d", experience))

    Event.rewards = {}
    for name, player in pairs(players) do
        if not Event.damageMap[name] then
            Event.damageMap[name] = 0
        end
        if not Event.regenMap[name] then
            Event.regenMap[name] = 0
        end
        if not Event.playerDamageMap[name] then
            Event.playerDamageMap[name] = 0
        end
        print(string.format("\t\tCharacter %s", name))
        print(string.format("\t\t\tDamage %d", Event.damageMap[name]))
        print(string.format("\t\t\tRegen %d", Event.regenMap[name]))
        print(string.format("\t\t\tLost hp %d", Event.playerDamageMap[name]))
        
        Event.rewards[name] = (totalRegen + totalDamage) > 0 and (Event.damageMap[name] + Event.regenMap[name]) / (totalRegen + totalDamage) or 0
        print(string.format("\t\t\tReward percent %s", tostring(Event.rewards[name])))
        
        local player_experience = math.floor(experience * Event.rewards[name])
        print(string.format("\t\t\tReward experience %s", tostring(player_experience)))
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("You received %d experience for defeating the boss.", player_experience))
        player:addExperience(player_experience)
        
        player:setStorageValue(info.storages.max_amount_status, 65002) -- completed status
        player:setStorageValue(info.storages.storage_delay, os.time() + 20 * 60 * 60) -- completed status
        
        local regenStats = totalRegen > 0 and math.floor(100 * Event.regenMap[name] / totalRegen) or 0
        local damageStats = totalDamage > 0 and math.floor(100 * Event.damageMap[name] / totalDamage) or 0
        print(string.format("\t\t\tRegen stats %s", tostring(regenStats)))
        print(string.format("\t\t\tDamage stats %s", tostring(damageStats)))
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("Congratulations! You've successfully completed the Christmas Event. You will be kicked out in %d seconds.\nYour contributions:\nYou dealed %d hit points (%d%% of your team total damage).\nYou received %d hit points during the event.\nYou healed %d life points (%d%% of your team total healing).", info.duration_waiting_exit, Event.damageMap[name], damageStats, Event.playerDamageMap[name], Event.regenMap[name], regenStats))
        
        local rewards, msg, desc
        if Event.rewards[name] >= 0.3 then
            rewards = info.rewards.rare
            desc = "Rare"
            msg = "Congratulations! You won a rare christmas reward!"
        elseif Event.rewards[name] >= 0.15 then
            rewards = info.rewards.uncommon
            msg = "Congratulations! You won an uncommon christmas reward!"
            desc = "Uncommon"
        else
            desc = "Common"
            rewards = info.rewards.common
            msg = "Congratulations! You won a common christmas reward!"
        end

        print(string.format("\t\t\tReward class %s", tostring(desc)))

        local bag = player:addItem(rewards.backpack)
        if bag then
            bag:setAttribute(ITEM_ATTRIBUTE_DESCRIPTION,
                string.format("\nA %s christmas gift from Santa Klaus himself.", desc))

            for _, reward in ipairs(rewards) do
                local sum = 0

                for _, possibility in pairs(reward) do
                    sum = sum + possibility[3]
                end

                local random = math.random(1, sum)

                for _, possibility in pairs(reward) do
                    random = random - possibility[3]
                    if random <= 0 then
                        bag:addItem(possibility[1], possibility[2])
                        break
                    end
                end
            end
        else
            print(">> Christmas event error -> Couldn't create a bag for player " ..
            name .. " with message '" .. msg .. "'")
        end

        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, msg)
        print("\t\tFinished player")
    end
    
    Event.cooldown = os.time() + info.duration_waiting_exit + 5    
    Event.running = false

    clean_events()
    Event.addEventEventFinished = addEvent(Event.finishEvent, info.duration_waiting_exit * 1000, "Ho-ho-ho, thank you for defeating the evil grinch! I will call you when the christmas are in dangerous again.")
    print(">> Christmas Event ocorreu com sucesso (fim das informacoes)")
    return true
end

function Event.finishEvent(message)

    local players = Event.getPlayers()
    print(">> Kickando jogadores do Christmas Event: \n\tMessage Status:" .. message)
    for name, player in pairs(players) do
        print("\t"..name .. " lv." .. player:getLevel())
    end
    print(">> Kickado jogadores do Christmas Event com sucesso (fim das informacoes)")

    clean_events()
    clean_room(message, info.positions.on_enter_waiting_room)
    Event.running = false
    return true
end

function Event.canPlayerParticipate(player)
    local players = {player}
    local status = getPlayerChristmasEventStatus(player)
    if not status.permission then
        broadcast_event_message(players, "You still need to defeat grinches and help the elfs.")
        return false
    end

    if status.completed then
        broadcast_event_message(players, "You have already helped Santa Klaus today! Come back tomorrow to help him again.")
        return false
    end

    return true
end

function Event.onHealthManaChange(creature, attacker, damage, type, origin)

    if not Event.running then
        return damage, type
    end

    if type == COMBAT_HEALING then
        if creature then
            if creature:isPlayer() then
                if attacker and attacker:isPlayer() then
                    if not Event.regenMap[attacker:getName()] then
                        Event.regenMap[attacker:getName()] = 0
                    end
            
                    Event.regenMap[attacker:getName()] = Event.regenMap[attacker:getName()] + math.min(math.abs(damage), creature:getMaxHealth() - creature:getHealth() )
                    return damage, type
                end
            elseif creature:isMonster() then
                damage = damage * (1 + info.teamLevelBonusModifiers.regenIncreasePercentagePerLevel * Event.getTeamLevelChallenge()) -- aumenta a regeneração dos monstros de natal
            end
        end
    else
        if creature then
            if creature:isMonster() then
                damage = damage * (1 - info.teamLevelBonusModifiers.defenseIncreasePercentagePerLevel) ^ Event.getTeamLevelChallenge() -- aumenta a defesa dos monstros de natal
            elseif attacker and attacker:isMonster() then
                damage = damage * (1 + info.teamLevelBonusModifiers.damageIncreasePercentagePerLevel * Event.getTeamLevelChallenge()) -- aumenta o ataque dos monstros de natal
            end

            if creature:isPlayer() then
                if not Event.playerDamageMap[creature:getName()] then
                    Event.playerDamageMap[attacker:getName()] = 0
                end

                Event.playerDamageMap[creature:getName()] = Event.playerDamageMap[creature:getName()] + math.abs(damage)
            end

        end

        -- saving damage map
        if attacker and attacker:isPlayer() then
            if not Event.damageMap[attacker:getName()] then
                Event.damageMap[attacker:getName()] = 0
            end
            
            
            Event.damageMap[attacker:getName()] = Event.damageMap[attacker:getName()] + math.abs(damage)
        end
        

        if Event.running_minions == -1 then
            if creature and creature:isMonster() and creature:getName() == Event.bossname then
                local healthPercent = creature:getHealth() / creature:getMaxHealth()
                if healthPercent < info.minions_trigger.life_trigger then
                    creature:say("Hahahah, my minions are coming to deal with you! I need to rest a bit.", TALKTYPE_MONSTER_SAY)

                    Event.running_minions = 0
                    stopEvent(Event.receive_minions)
                    Event.receive_minions = addEvent(function()
                        for i = 1, #info.positions.player_event_event do
                            local minion = spawn_christmas_creature(info.creatures.minion, info.positions.player_event_event[i], 1.0)
                            if minion then
                                minion:registerEvent("HealthChristmasEvent")
                                minion:registerEvent("DeathChristmasEvent")
                                Event.running_minions = Event.running_minions + 1
                            end
                        end
                    end, 10 * 1000)
                    
                    stopEvent(Event.bossIsBack)
                    Event.bossIsBack = addEvent(function()
                        if Event.running_minions > 0 then -- Ainda há minions
                            local boss = spawn_christmas_creature(info.creatures.boss.name, info.position_boss_spawn, 1.0)
                            if boss then
                                boss:rename(Event.bossname)
                                boss:say("I'm back! You can't defeat me!", TALKTYPE_MONSTER_SAY)
                            else
                                print(">>> Christmas error: Nao foi possivel spawnar boss")
                            end

                            Event.running_minions = -2
                        end
                    end, info.minions_trigger.duration * 1000)

                    creature:remove()
                    return damage, type
                end
            end
        end
    end

    return damage, type
end

-- christmas event callbacks

local actionEvent = Action()

function actionEvent.onUse(player, item, fromPosition, target, toPosition, isHotkey)
    if true then return true end --INFO: Christmas Event disabled
    local players = Event.getWaitingRoomPlayers()

    for _, p in pairs(players) do
        if p:getId() == player:getId() then
            Event.startEvent()
            return false
        end
    end

    player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You need to stay in the selected positions.")

    notifyWaitingRoomSelectedPositions()

    return false
end

actionEvent:aid(info.action_ids.lever)
actionEvent:register()

--

local actionDoorEvent = Action()

function actionDoorEvent.onUse(player, item, fromPosition, target, toPosition, isHotkey)
    if true then return true end --INFO: Christmas Event disabled
    if Event.canPlayerParticipate(player) then
        player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
        player:teleportTo(info.positions.on_enter_waiting_room)
        player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
    end
    return true
end

actionDoorEvent:aid(info.action_ids.door)
actionDoorEvent:register()

--
local onLoginEvent = CreatureEvent("ChristmasEventLogout")

function onLoginEvent.onLogin(player)
    Event.unloadPlayer(player)
    return true
end

onLoginEvent:register()

local logoutEvent = CreatureEvent("ChristmasEventLogout")

function logoutEvent.onLogout(player)
    if not Event.running then
        Event.unloadPlayer(player)
        return true
    end
    
    player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You can't logout while the Christmas Event is running.")
    return false
end

logoutEvent:register()

--

local manaEvent = CreatureEvent("ManaChristmasEvent")
function manaEvent.onManaChange(creature, attacker, damage, type, origin)
    return Event.onHealthManaChange(creature, attacker, damage, type, origin)
end

manaEvent:register()

--

local healthEvent = CreatureEvent("HealthChristmasEvent")
function healthEvent.onHealthChange(creature, attacker, damage, type, origin)
    return Event.onHealthManaChange(creature, attacker, damage, type, origin)
end

healthEvent:register()

--

local deathEvent = CreatureEvent("DeathChristmasEvent")

function deathEvent.onDeath(creature, corpse, killer, mostDamageKiller, unjustified, mostDamageUnjustified)

    if not Event.running then
        return true
    end

    if creature and creature:getName() == Event.bossname then -- boss
        Event.completeEvent()
        return true
    end

    if Event.running_minions > 0 then
        Event.running_minions = Event.running_minions - 1

        if Event.running_minions == 0 then
            local boss = spawn_christmas_creature(info.creatures.boss.name, info.position_boss_spawn, info.minions_trigger.life_trigger)
            if boss then
                boss:rename(Event.bossname)
                boss:say("Oh, no, you defeated my children! I'm gonna revenge them!", TALKTYPE_MONSTER_SAY)
                Event.running_minions = -2
            else
                print("Problema ao spawnar boss")
            end
        end
    end

    return false
end

deathEvent:register()

local deathWildEvent = CreatureEvent("DeathWildChristmasEvent")

function deathWildEvent.onDeath(creature, corpse, killer, mostDamageKiller, unjustified, mostDamageUnjustified)
    if killer:isPlayer() then
        local amount = killer:getStorageValue(info.storages.defeated_grinches_amount)
        local maxAmount = killer:getStorageValue(info.storages.max_amount_status)
        
        if maxAmount == 65000 then -- pegou a missão com o papai noel
            
            maxAmount = getMinionsDefeatedAmount(killer:getLevel())
            amount = 1
            killer:setStorageValue(info.storages.defeated_grinches_amount, amount)
            killer:setStorageValue(info.storages.max_amount_status, maxAmount)
            killer:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, string.format("[Santa Klaus mission] You need to defeat %d grinches with the Helper Elfs so you can fight the Evil Grinch and save the christmas!", maxAmount))
        elseif maxAmount == 65001 then -- Já completou a missão
            killer:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, "You have already defeated enough grinches to help Santa. Now you need to defeat the Evil Grinch.")
        elseif maxAmount and maxAmount > 65001 then
            -- não deve fazer nada
        elseif amount and maxAmount and amount > 0 and maxAmount > 0 then
            if amount+1 < maxAmount then
                amount = amount + 1
                killer:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, string.format("You have defeated %s of %s %s to help Santa Klaus Christmas.", amount, maxAmount, info.creatures.minion))
                killer:setStorageValue(info.storages.defeated_grinches_amount, amount)
            else
                killer:setStorageValue(info.storages.defeated_grinches_amount, 65001)
                killer:setStorageValue(info.storages.max_amount_status, 65001)
                killer:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Hey, Santa Klaus is really happy with your help, and he gave you permission to come in to Santa Klaus' house to your last help today.")
            end
        end
    end
    creature:getPosition():sendMagicEffect(CONST_ME_POFF)
    addEvent(spawn_random_wild_minion, info.wild_behavior.respawn_delay * 1000, 10) -- máximo 10 tentativas
end

deathWildEvent:register()

local prepareDeathEvent = CreatureEvent("PrepareDeathChristmasEvent")

function prepareDeathEvent.onPrepareDeath(creature, killer)    
    Event.finishEvent(string.format("%s died and your team was eliminated from the Christmas Event.", creature:getName()))
    return false
end

prepareDeathEvent:register()

--

local globalevent = GlobalEvent("ChristmasEvent")

function globalevent.onStartup()

    if true then return true end --INFO: Christmas Event disabled

    print(">> Starting Christmas Event...")
    print(">>> Cleaning Christmas Event storages...")

    local cleanStorages = "DELETE FROM `player_storage` WHERE "
    cleanStorages = cleanStorages .. " `key` = " .. info.storages.defeated_grinches_amount
    cleanStorages = cleanStorages .. ";"
    db.asyncQuery(cleanStorages)

    db.asyncQuery("UPDATE `player_storage` SET `value` = 65004 WHERE `key` = " .. info.storages.max_amount_status .. " AND `value` > 0;")
    
    print(">> Cleaned Christmas Event storage.")

    print(">> Spawning Christmas Event wild monsters...")
    
    local amount = info.wild_behavior.amount
    while (amount > 0) do
        if spawn_random_wild_minion(5) then -- máximo 5 tentativas
            amount = amount - 1
        end
    end
    
    print(">> Spawning Christmas Helper Elfs...")
    for _, region in pairs(info.wild_behavior.regions) do
        local amount = region.helper_amount
        while (amount > 0) do
            if spawn_santa_klaus_helper(region, 5) then
                amount = amount - 1
            end
        end
    end

    print(">> Spawning Santa Klaus...")

    local npc = Game.createNpc("santa klaus", info.positions.npc_spawn)
	if npc then
        npc:setMasterPos(info.positions.npc_spawn, 5)
    end

    print(">> everything spawned ok")
    
    return true
end

globalevent:register()

local talkaction = TalkAction("/clean_christmas")

function talkaction.onSay(player, words, param)

    if not player:getGroup():getAccess() then
		return true
	end

	if player:getAccountType() < ACCOUNT_TYPE_GOD then
		return false
	end

    clean_events()
    clean_room(message, info.positions.on_enter_waiting_room)
    Event.running = false
    
    for _, creature in pairs(Game.getPlayers()) do
        if creature:isPlayer() then
            creature:getPosition():sendMagicEffect(CONST_ME_POFF)
            Event.unloadPlayer(creature)
        end
    end

    player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Todos os jogadores on-line foram limpos pelo evento!")

    return true
end

talkaction:separator(" ")
talkaction:register()