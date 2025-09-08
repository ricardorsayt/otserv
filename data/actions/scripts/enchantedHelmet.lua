-- use_ruby_enchant.lua
-- Action simples: usar Small Ruby (2147) sobre Helmet normal (2342) -> transforma em 2343 e consome 1 ruby.
-- NÃO agenda revert (conforme solicitado).

local SMALL_RUBY_ID = 2147
local HELMET_NORMAL_ID = 2342
local HELMET_ENCHANTED_ID = 2343

-- Consome 1 unidade do item (stack-safe)
local function consumeOne(item)
  if not item then return false end
  if type(item) == "table" and item.uid then
    pcall(function() Item(item.uid):remove(1) end)
    return true
  end
  local ok, _ = pcall(function() item:remove(1) end)
  return ok
end

-- Tenta transformar o objeto item (pode ser table com uid ou Item userdata)
local function transformItem(obj, newId)
  if not obj then return false end
  local ok = pcall(function()
    if type(obj) == "table" and obj.uid then
      Item(obj.uid):transform(newId)
    else
      obj:transform(newId)
    end
  end)
  return ok
end

-- Tenta obter id do target (aceita table ou Item)
local function getId(obj)
  if not obj then return nil end
  if type(obj) == "table" and obj.itemid then return obj.itemid end
  local ok, id = pcall(function() return obj:getId() end)
  if ok then return id end
  if type(obj) == "table" and obj.uid then
    local ok2, it = pcall(function() return Item(obj.uid) end)
    if ok2 and it then
      local ok3, id2 = pcall(function() return it:getId() end)
      if ok3 then return id2 end
    end
  end
  return nil
end

-- Tenta obter uid do target (para efeitos / logs se necessário)
local function getUid(obj)
  if not obj then return nil end
  if type(obj) == "table" and obj.uid then return obj.uid end
  local ok, uid = pcall(function() return obj.uid end)
  if ok and uid then return uid end
  return nil
end

-- onUse signature: (player, item, fromPosition, target, toPosition, isHotkey)
function onUse(player, item, fromPosition, target, toPosition, isHotkey)
  -- verifica se a pedra usada é a Small Ruby
  local itemId = getId(item)
  if itemId ~= SMALL_RUBY_ID then
    player:sendTextMessage(MESSAGE_STATUS_CONSOLE_RED, "Você precisa usar uma Small Ruby para encantar o helmet.")
    return true
  end

  if not target then
    player:sendTextMessage(MESSAGE_STATUS_CONSOLE_RED, "Use a Small Ruby sobre o helmet.")
    return true
  end

  -- caso target seja o próprio item (no chão/backpack)
  local targetId = getId(target)

  -- Se o alvo for o helmet normal (item)
  if targetId == HELMET_NORMAL_ID then
    local ok = transformItem(target, HELMET_ENCHANTED_ID)
    if ok then
      consumeOne(item)
      -- efeito visual na posição do alvo (fallback para posição do player)
      local pos = nil
      pcall(function()
        if type(target) == "table" and target.position then
          pos = target.position
        elseif target.getPosition then
          pos = target:getPosition()
        end
      end)
      if pos then
        pcall(function() Tile(pos):sendMagicEffect(CONST_ME_MAGIC_BLUE) end)
      else
        pcall(function() player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE) end)
      end
      player:sendTextMessage(MESSAGE_INFO_DESCR, "Seu helmet foi encantado.")
    else
      player:sendTextMessage(MESSAGE_STATUS_CONSOLE_RED, "Falha ao encantar o helmet.")
    end
    return true
  end

  -- Se o target for uma creature (ex.: jogador) — tenta encantar o item equipado no head slot
  local okIsCreature, isCreature = pcall(function() return target:isCreature() end)
  if okIsCreature and isCreature then
    local headItem = nil
    local okSlot, res = pcall(function() return target:getSlotItem(CONST_SLOT_HEAD) end)
    if okSlot then headItem = res end
    if headItem and pcall(function() return headItem:getId() end) and headItem:getId() == HELMET_NORMAL_ID then
      local ok = transformItem(headItem, HELMET_ENCHANTED_ID)
      if ok then
        consumeOne(item)
        pcall(function() target:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE) end)
        player:sendTextMessage(MESSAGE_INFO_DESCR, "O helmet equipado foi encantado.")
      else
        player:sendTextMessage(MESSAGE_STATUS_CONSOLE_RED, "Falha ao encantar o helmet equipado.")
      end
      return true
    else
      player:sendTextMessage(MESSAGE_STATUS_CONSOLE_RED, "O alvo não possui um helmet normal equipado.")
      return true
    end
  end

  -- fallback: se não é item nem creature com helmet
  player:sendTextMessage(MESSAGE_STATUS_CONSOLE_RED, "Você deve usar a Small Ruby sobre o helmet normal.")
  return true
end
