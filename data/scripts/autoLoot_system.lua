--[[
  Sistema de AutoLoot (Final)
  Este script � uma fus�o do 'autoLoot_system (1).lua' (com sua l�gica de coleta de loot robusta)
  e o 'autoLoot_system (3).lua' (com sua comunica��o eficaz via extended opcode).
  
  O objetivo � fornecer uma solu��o completa e limpa, removendo c�digo redundante.
  
  Funcionalidades inclu�das:
  1. Carregamento da lista de loot do banco de dados na inicializa��o do servidor.
  2. Adi��o e remo��o de itens da lista via comunica��o com o cliente (extended opcode).
  3. Coleta autom�tica de itens para o `GOLD_POUCH` ou mochila do jogador.
  4. Gerenciamento de limites de itens para jogadores VIP e FREE.
  5. Envio de mensagens de status e atualiza��es de lista para o cliente.
  
  Pr�-requisitos:
  - Uma tabela no banco de dados chamada `auto_loot_list` com colunas `player_id` e `item_id`.
  - O script do cliente (`quickloot.lua` ou similar) deve estar configurado para usar o OPCODE 50.
--]]

-- Carrega o suporte a JSON
local json = require("cjson")

-- Tabela principal para armazenar as listas de loot dos jogadores
local AutoLootList = {
	players = {}
}

-- Configura��es globais, ajust�veis para o seu servidor
local config = {
  vipMaxItems = 15, -- Limite de itens para jogadores VIP
  freeMaxItems = 5, -- Limite de itens para jogadores FREE
  GOLD_POUCH = 2160, -- ID do Gold Pouch (saco de moedas)
  OPCODE_QUICKLOOT = 50, -- Opcode estendido para a comunica��o com o client
}

-- Fun��o auxiliar para enviar dados formatados em JSON ao cliente
local function sendToClient(player, data)
  local buffer = json.encode(data)
  player:sendExtendedOpcode(config.OPCODE_QUICKLOOT, buffer)
end

-- Constr�i o objeto de limites de itens para enviar ao cliente
local function buildLimits(player)
  local isVip = player:isVip() -- Assume a exist�ncia de uma fun��o isVip()
  local maxItems = isVip and config.vipMaxItems or config.freeMaxItems
  local currentItems = AutoLootList:countList(player:getGuid())
  return { current = currentItems, max = maxItems }
end

-- Inicializa a lista de loot para um jogador, carregando do banco de dados
function AutoLootList:init(playerGuid)
  -- Evita recarregar se j� estiver inicializado
  if self.players[playerGuid] then return end
	self.players[playerGuid] = { lootList = {} }
	local resultId = db.storeQuery("SELECT `item_id` FROM `auto_loot_list` WHERE `player_id` = " .. playerGuid)
	if resultId then
		self.players[playerGuid].lootList = queryToTable(resultId, {'item_id:number'})
		result.free(resultId)
	end
end

-- Adiciona um item � lista de autoloot do jogador e salva no banco de dados
function AutoLootList:addItem(playerGuid, itemId)
  self:init(playerGuid) -- Garante que a lista est� carregada

	if self:itemInList(playerGuid, itemId) then
		return false, "Item already in list."
	end
	
	local player = Player(playerGuid)
	if player then
		local isVip = player:isVip()
		local maxItems = isVip and config.vipMaxItems or config.freeMaxItems
		local currentItems = self:countList(playerGuid)
		if currentItems >= maxItems then
			return false, "Item limit reached."
		end
	end

	local result = db.query("INSERT INTO `auto_loot_list` (`player_id`, `item_id`) VALUES (" .. playerGuid .. ", " .. itemId .. ")")
	if result then
		table.insert(self.players[playerGuid].lootList, { item_id = itemId })
		return true
	end
	
	return false, "Failed to insert into database."
end

-- Remove um item da lista de autoloot do jogador e do banco de dados
function AutoLootList:removeItem(playerGuid, itemId)
  self:init(playerGuid)
	
	local result = db.query("DELETE FROM `auto_loot_list` WHERE `player_id` = " .. playerGuid .. " AND `item_id` = " .. itemId)
	if result then
		for i, lootItem in ipairs(self.players[playerGuid].lootList) do
			if lootItem.item_id == itemId then
				table.remove(self.players[playerGuid].lootList, i)
				return true
			end
		end
	end
	
	return false, "Failed to remove from database."
end

-- Verifica se um item est� na lista de loot
function AutoLootList:itemInList(playerGuid, itemId)
  self:init(playerGuid)
	for _, lootItem in ipairs(self.players[playerGuid].lootList) do
		if lootItem.item_id == itemId then
			return true
		end
	end
	return false
end

-- Retorna a contagem de itens na lista de um jogador
function AutoLootList:countList(playerGuid)
  self:init(playerGuid)
	return #self.players[playerGuid].lootList
end

-- Retorna a lista de itens de um jogador
function AutoLootList:getItemList(playerGuid)
  self:init(playerGuid)
	return self.players[playerGuid].lootList
end

-- Lida com a coleta de loot ap�s uma criatura ser morta
local function handleLoot(creature, container)
    local player = creature:getPlayer()
    if not player or not container then return end

    local lootList = AutoLootList:getItemList(player:getGuid())
    if not lootList or #lootList == 0 then return end
    
    -- Tenta encontrar o Gold Pouch
    local lootPouch = player:getContainer(config.GOLD_POUCH)
    local movedItems = {}
    local movedItemsCount = 0

    -- Itera de tr�s para frente para evitar problemas de �ndice ao mover itens
    for i = container:getSize() - 1, 0, -1 do
        local item = container:getItem(i)
        if item then
            local itemId = item:getId()
            local shouldLoot = AutoLootList:itemInList(player:getGuid(), itemId)
            
            if shouldLoot then
                local moveItem
                if lootPouch then
                    moveItem = item:moveTo(lootPouch)
                else
                    -- Move para a primeira mochila dispon�vel se n�o houver Gold Pouch
                    moveItem = item:moveTo(player)
                end
                
                if moveItem then
                    local itemName = item:getName()
                    local itemCount = item:getCount()
                    movedItems[#movedItems + 1] = { name = itemName, count = itemCount }
                    movedItemsCount = movedItemsCount + 1
                end
            end
        end
    end

    -- Envia uma mensagem ao jogador com os itens coletados
    if movedItemsCount > 0 then
        local strLoot = ""
        for _, loot in ipairs(movedItems) do
            strLoot = strLoot .. string.format('%dx %s, ', loot.count, loot.name)
        end
        strLoot = strLoot:sub(1, #strLoot-2)
        if strLoot:len() >= 250 then
            strLoot = strLoot:sub(1, 250) .. " ..."
        end
        player:sendTextMessage(MESSAGE_STATUS_SMALL, string.format('Collected loot: %s', strLoot))
    end
end

-- Evento onKill
local onLootEvent = Event()
function onLootEvent.onKill(creature, container)
  if not creature:isPlayer() and container:getSize() > 0 then
    handleLoot(creature, container)
  end
  return true
end

-- Evento de login para registrar os eventos do sistema
local autoLootLogin = CreatureEvent("AutoLootLogin")
function autoLootLogin.onLogin(player)
  -- Registra os eventos no jogador
  player:registerEvent("AutoLootExtendedOpcode")
  player:registerEvent("AutoLoot")
	
  AutoLootList:init(player:getGuid())
	
  return true
end

-- Handler para o extended opcode do cliente
local autoLootExtendedOpcode = CreatureEvent("AutoLootExtendedOpcode")
function autoLootExtendedOpcode.onExtendedOpcode(player, opcode, buffer)
  -- Verifica se o opcode corresponde ao do QuickLoot
  if opcode ~= config.OPCODE_QUICKLOOT then
    return false
  end

  local data = json.decode(buffer)
  if not data or not data.action then
    return false
  end

  local action = data.action
  local playerGuid = player:getGuid()

  if action == "load" then
    local lootList = AutoLootList:getItemList(playerGuid)
    local limits = buildLimits(player)
    sendToClient(player, { action = "loaded", loot = lootList, limits = limits })
    return true
  elseif action == "add" and data.itemId then
    local iid = tonumber(data.itemId)
    if not iid then
      sendToClient(player, { action = "error", message = "Invalid itemId" })
      return false
    end
    
    local ok, res = pcall(function() return AutoLootList:addItem(playerGuid, iid) end)
    if ok and res == true then
      local limits = buildLimits(player)
      local newLoot = { item_id = iid }
      sendToClient(player, { action = "added", limits = limits, item = newLoot })
    else
      local message = "Failed to add item"
      if type(res) == "string" then
        message = res
      end
      sendToClient(player, { action = "error", message = message })
    end
    return true
  elseif action == "remove" and data.itemId then
    local iid = tonumber(data.itemId)
    if not iid then
      sendToClient(player, { action = "error", message = "Invalid itemId" })
      return false
    end
    
    local ok, res = pcall(function() return AutoLootList:removeItem(playerGuid, iid) end)
    if ok and res == true then
      local limits = buildLimits(player)
      sendToClient(player, { action = "removed", limits = limits })
    else
      local message = "Failed to remove item"
      if type(res) == "string" then
        message = res
      end
      sendToClient(player, { action = "error", message = message })
    end
    return true
  end

  sendToClient(player, { action = "error", message = "Unsupported action" })
  return false
end

-- Expor handlers globalmente para o sistema de eventos do servidor
_G.onQuickLootOpcode = autoLootExtendedOpcode.onExtendedOpcode
_G.AutoLootList = AutoLootList

-- Registra todos os eventos
autoLootStartup:register()
autoLootLogin:register()
onLootEvent:register()
autoLootExtendedOpcode:register()

print("[AutoLoot] Sistema de AutoLoot (Final) carregado com sucesso.")
