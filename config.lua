---------------------------------------------
-- THE VIOLET PROJECT - CONFIGURATION FILE --
---------------------------------------------

-------------------------
-- Connection Settings --
-------------------------
-- maxPlayers: set to 0 for no limit
--ip = "shanera-retro.com"       --oficial proxy
--bindOnlyGlobalAddress = true --proxy
--statusProtocolPort = 7173 --proxy
ip = "34.95.243.186"
statusIP = "34.95.243.186"
bindOnlyGlobalAddress = false
loginProtocolPort = 7171
gameProtocolPort = 7172
statusProtocolPort = 7173
maxPlayers = 0
motd = "Welcome to Shanera-Retro!"
onePlayerOnlinePerAccount = false
allowClones = false
serverName = "Shanera-Retro"
statusTimeout = 5000
replaceKickOnLogin = true
maxPacketsPerSecond = 100

-----------------------------
-- MySql Database Settings --
-----------------------------
mysqlHost = "127.0.0.1"
mysqlUser = "homero"
mysqlPass = "Muaythai163157!@#"
mysqlDatabase = "ravenor"
mysqlPort = 3306
mysqlSock = ""

------------------------------
-- Protocol Status Settings --
------------------------------
ownerName = "Ricardo Rosa"
ownerEmail = "ricardorsayt@gmail.com"
url = ""
location = "Brazil"

-----------------------
-- Server Statistics --
-----------------------
-- time in seconds: 30 = 30 seconds, 0 = disabled
statsDumpInterval = 30
-- time in milliseconds: 10 = 0.01 sec, 0 = disabled
statsSlowLogTime = 10
-- time in milliseconds: 50 = 0.05 sec, 0 = disabled
statsVerySlowLogTime = 50

-------------------------------------
-- Process Priority (Windows only) --
-------------------------------------
-- defaultPriority: "normal", "above-normal", "high"
defaultPriority = "high"
startupDatabaseOptimization = false

------------------
-- Map Settings --
------------------
mapName = "map"
mapAuthor = "Ezzz & CipSoft"

--------------------------
-- Map Refresh Settings --
--------------------------
-- mapRefreshTileVisibilityInterval: players near such tiles do not refresh for the given interval
enableMapRefresh = true
mapRefreshInterval = 1 * 60 * 1000
mapRefreshTilesPerCycle = 32 * 32
mapRefreshTileVisibilityInterval = 60 * 60 * 1000

--------------------------
-- Server Save Settings --
--------------------------
enableMapDataFiles = false

---------------------
-- Combat Settings --
---------------------
-- worldType options: "pvp", "no-pvp" and "pvp-enforced".
-- deathLosePercent: use -1 for modern Tibia formula. 10 for oldschool formulas.
-- banDaysLength: total days to ban the player when exceeding killsToBan
-- onlyOneFragPerKill: if true, either last hit or most damage gets the unjust, 
-- 					   most damage only gets unjust if there is no valid last hit or it was a justified last hit
worldType = "pvp"
protectionLevel = 1
banDaysLength = 30
pzLocked = 60000
onlyOneFragPerKill = false
removeChargesFromRunes = false
removeChargesFromPotions = false
removeWeaponAmmunition = false
removeWeaponCharges = false
redSkullDuration = 15 * 24 * 60 * 60
killsDayRedSkull = 7
killsWeekRedSkull = 15
killsMonthRedSkull = 30
killsDayBanishment = 15
killsWeekBanishment = 30
killsMonthBanishment = 50
whiteSkullTime = 15 * 60
experienceByKillingPlayers = false
pvpExpFormula = 10
deathLosePercent = 10
allowUnfairFightDeathReduction = false
useClassicCombatFormulas = true

--------------------
-- House Settings --
--------------------
-- housePriceEachSQM: use -1 to disable the ingame buy house functionality
-- houseRentPeriod options: "daily", "weekly", "monthly", "yearly", "none" to disable rents
housePriceEachSQM = 150
houseRentPeriod = "monthly"
houseOwnedByAccount = true
houseDoorShowPrice = true
onlyInvitedCanMoveHouseItems = false
onlyInvitedCanAddHouseItems = true
housesBankSystem = false
guildHallsOnlyForLeaders = false
housesOnlyPremium = true

-------------------
-- Game Settings --
-------------------
-- defaultWorldLight: set to false to have a static world light
-- enablePlayerDataFiles: saves player inventory and depot items to /gamedata/players/ folder instead of DB
-- enablePlayerInventoryDatabase: makes it so if player data files is enabled, player inventory will be saved & loaded from database instead
defaultWorldLight = true
timeBetweenActions = 100
timeBetweenExActions = 1000
allowChangeOutfit = true
freePremium = false
kickIdlePlayerAfterMinutes = 15
premiumKickIdlePlayerAfterMinutes = 30
maxMessageBuffer = 4
emoteSpells = false
showScriptsLogInConsole = false
yellMinimumLevel = 2
yellAlwaysAllowPremium = false
forceMonsterTypesOnLoad = false
luaItemDesc = false
staminaSystem = false
showPlayerLogInConsole = true
disabledMailboxes = "Rookgaard,Isle of Solitude"
vipFreeLimit = 20
vipPremiumLimit = 100
depotFreeLimit = 1000
depotPremiumLimit = 2000
removeOnDespawn = true
playerInventoryAutoStack = true
showMonsterLootMessage = false
monstersSpawnWithLoot = true
classicPlayerLootDrop = true
enablePlayerDataFiles = true
enablePlayerInventoryDatabase = false
tileItemLimit = 1000
houseTileItemLimit = 100
classicInventorySwap = true
allowMonsterOverspawn = true

-- Show aggressive spell effects in protection areas as a GM? 
-- Default: false
gamemasterDamageProtectOnZoneEffects = false


-- When looking at a house door with an item, shall it display house info or the item's ?
houseDoorsDisplayHouseInfo = false

-- Allow searching for a valid container inside inner containers of a player?
-- This only applies for using an item from a distance
deepPlayerContainerSearch = false 

-- Rarity Items System
itemUncommonChance = 70
itemRareChance = 100
itemEpicChance = 90
itemLegendaryChance = 80

-- Allow sending parcels and letters with trash on top of mailboxes
trashableMailbox = false

-- Failed account login attempts to disable an account and ban IP-Address
-- Use a big number to disable usage.
failedLoginAttemptsAccountLock = 10
failedLoginAttemptsIPBan = 15

accountLockDuration = 5 * 60 * 1000
ipLockDuration = 30 * 60 * 1000

ipLockMessage = "IP address blocked for 30 minutes. Please wait."
accountLockMessage = "Account disabled for five minutes. Please wait."

-- If the OTBM map has been updated, upon login, player will be sent to the temple.
uponMapUpdateSendPlayersToTemple = true

logPath = "gamedata/logs"

--------------------
-- Rooking System --
--------------------
allowPlayerRooking = true
rookingLevel = 6
rookTownName = "Rookgaard"

-------------------
-- Rate Settings --
-------------------
-- rateSpawn: increases respawn time by the given percentage, 50 = 50% faster respawn time
rateExp = 100
rateSkill = 20
rateLoot = 100
rateMagic = 20
rateSpawn = 100

--------------------------
-- Battlepass Settings --
--------------------------
battlePassEndDate = "10.08.2025.10.00" -- // Date format - 20.09.2023.10.00

-----------------
-- LUA Scripts --
-----------------
warnUnsafeScripts = true
convertUnsafeScripts = true


-------------------------------
-- Test Environment Settings --
-------------------------------
-- Set to true to enable the default behavior of Tibia of learning spells
-- This makes it so all spells are learned by default
needLearnSpells = false
-- Disables all spell requirements for all players
noSpellRequirements = false
-- Disable players losing HP or MP
unlimitedPlayerHP = false
unlimitedPlayerMP = false
-- Disable monster spawns
disableMonsterSpawns = false
--Disable method Maintance
ignoreMaintance = true
