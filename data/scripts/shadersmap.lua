SHADER_MAP_CODE = 105
local weatherStorage = 55029

local config = {
	{chance = 100, fromPos = Position(0, 0, 7), toPos = Position(0, 0, 7), shaders = {"map_HeavySnow"}},
	{chance = 100, fromPos = Position(0, 0, 7), toPos = Position(0, 0, 7), shaders = {"map_HeavyRain" , "map_LightRain", "map_HeavyRainLightning"}},
}




playersRaining = {}
local chance = 100 -- 100% for test   (this is main chaince for the weather to ask for the cities chances should be higher than 50%) kept 100% for testings
local WeatherCheckDelay = 20000 -- 20 seconds for test
local areaChangeDelay = 1000


function isInArea(player, pos, fromPos, toPos)
    if pos.x >= fromPos.x and pos.x <= toPos.x then
        if pos.y >= fromPos.y and pos.y <= toPos.y then
            if pos.z >= fromPos.z and pos.z <= toPos.z then
                return true
            end
        end
    end
    return false
end

function isRaining()
    if Game.getStorageValue(weatherStorage) > 0 then

		return true
    end
    return false
end
	local weatherStartup = GlobalEvent("WeatherStartup")

	function weatherStartup.onStartup()
		local rain = math.random(100)
		if rain > 100 - chance then
			Game.setStorageValue(weatherStorage, 1)
		else
			Game.setStorageValue(weatherStorage, 0)
		end
		return true
	end

	weatherStartup:register()

	local weather = GlobalEvent("Weather")

	function weather.onThink(interval, lastExecution)
		local rain = math.random(100)
		if rain > 100 - chance then
			Game.setStorageValue(weatherStorage, 1)
		else
			Game.setStorageValue(weatherStorage, 0)
			-- Shaders on Map removal
		end
		return true
	end

	weather:interval(WeatherCheckDelay) -- how often to randomize rain / weather
	weather:register()

	local weatherRain = GlobalEvent("WeatherRain")

	function weatherRain.onThink(interval, lastExecution)
		if Game.getStorageValue(weatherStorage) == 1 then
			local players = Game.getPlayers()
			if #players == 0 then
				return true
			end
			local player
			local randomConstant
			for i = 1, #players do
				player = players[i]
				local pos = player:getPosition()
				local shader
					for j = 1,#config do
						if isInArea(player, pos, config[j].fromPos, config[j].toPos) then
							if math.random(1,100) > config[j].chance then -- ifound the player inside the location specified i will check the chance given to start rains or disable it 
								if playersRaining[player:getId()] then
									player:removeMapShader()
									playersRaining[player:getId()] = nil
									return true
								end
							end
							shader = config[j].shaders[math.random(1,#config[j].shaders)]
							player:setMapShader(shader)
							local spectators = Game.getSpectators(player:getPosition(), false, true, 15, 15, 15, 15)
							for k = 1, #spectators do -- it must be same rain for players around each other here is the way to make it 
								spectators[k]:setMapShader(shader)
								if not playersRaining[spectators[k]:getId()] then
									playersRaining[spectators[k]:getId()] = true
								end
							end
							if not playersRaining[player:getId()] then
								playersRaining[player:getId()] = true
							end
							
							return true
						end
					end
				player:removeMapShader()
			end
		end
		return true
	end

	weatherRain:interval(areaChangeDelay) -- 10seconds less rain = greater value ////////////// more rains = higher CPU XD stay higher than 100
	weatherRain:register()
