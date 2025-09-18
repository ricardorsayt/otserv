local StartupEvent = GlobalEvent("GuildsStartUp")
function StartupEvent.onStartup()
  getTopGuilds()
  return true
end

local ThinkEvent = GlobalEvent("GuildWarsProcess")
-- varre todas as guilds periodicamente para processar pacifismo e guerras
function ThinkEvent.onThink()
  local guilds = getAllGuilds()
  local now = os.time()
  local nowMs = os.mtime()

  for _, guild in ipairs(guilds) do
    -- proteger chamadas caso algum método não exista no core
    if guild.getPacifismStatus and guild.getPacifism then
      local status = guild:getPacifismStatus()
      local pacifismUntil = guild:getPacifism()

      if status == GUILDS_CFG.PACIFISM.ACTIVE then
        if (pacifismUntil <= nowMs) and guild.cooldownPacifism then
          guild:cooldownPacifism()
        end
      elseif status == GUILDS_CFG.PACIFISM.EXHAUSTED then
        if (pacifismUntil <= nowMs) and guild.inactivePacifism then
          guild:inactivePacifism()
        end
      end
    end

    -- processar guerras se a API existir
    if guild.getWars then
      local wars = guild:getWars()
      for _, war in ipairs(wars) do
        if (war.status == GUILDS_CFG.WARS.STATUS.STARTED) and ((war.started + war.duration) <= now) then
          if guild.endWar then
            guild:endWar(war.guildId, GUILDS_CFG.WARS.END_TYPE.EXPIERD)
          end
        elseif (war.status == GUILDS_CFG.WARS.STATUS.PREPARING) and (war.started <= now) then
          if guild.startWar then
            guild:startWar(war.guildId)
          end
        end
      end
    end
  end
  return true
end

local LoginEvent = CreatureEvent("GuildsLogin")
function LoginEvent.onLogin(player)
  player:registerEvent("GuildsExtended")
  player:registerEvent("GuildWarDeath")
  if player.sendOnlineUpdate then
    player:sendOnlineUpdate()
  end
  -- migrar contribuição antiga
  local goldStorage = player:getStorageValue(GUILDS_CFG.GOLD_STORAGE)
  if goldStorage and (goldStorage > 0) then
    local g = (player.getGuild and player:getGuild()) or nil
    if g and player.addGuildContribution then
      player:addGuildContribution(goldStorage)
    end
    player:setStorageValue(GUILDS_CFG.GOLD_STORAGE, -1)
  end
  return true
end

local LogoutEvent = CreatureEvent("GuildsLogout")
function LogoutEvent.onLogout(player)
  if player.sendOnlineUpdate then
    player:sendOnlineUpdate(true)
  end
  return true
end

local DeathEvent = CreatureEvent("GuildWarDeath")
function DeathEvent.onDeath(player, corpse, killer, mostDamageKiller, lastHitUnjustified, mostDamageUnjustified)
  local byPlayer = false
  if killer then
    if killer.isPlayer and killer:isPlayer() then
      byPlayer = true
    else
      local master = (killer.getMaster and killer:getMaster()) or nil
      if master and (master ~= killer) and master.isPlayer and master:isPlayer() then
        killer = master
        byPlayer = true
      end
    end
  end
  if not byPlayer then
    return true
  end

  local killerGuild = (killer.getGuild and killer:getGuild()) or nil
  local victimGuild = (player.getGuild and player:getGuild()) or nil
  if (not killerGuild) or (not victimGuild) then
    return true
  end

  if (not killerGuild.isInWar) or (not killerGuild.getWar) then
    return true
  end

  local victimId = victimGuild:getId()
  if not killerGuild:isInWar(victimId) then
    return true
  end

  local war = killerGuild:getWar(victimId)
  if not war then
    return true
  end

  local kName = killer:getName()
  local vName = player:getName()

  if killerGuild.addWarKill then
    killerGuild:addWarKill(victimId, 1)
  end

  db.asyncQuery(string.format(
    "INSERT INTO `guildwar_kills` VALUES (0, %d, %s, %s, %d, %d, %d)",
    war.warId,
    db.escapeString(kName),
    db.escapeString(vName),
    killerGuild:getId(),
    victimId,
    os.time()
  ))

  local kMembers = (killerGuild.getMembersOnline and killerGuild:getMembersOnline()) or {}
  local vMembers = (victimGuild.getMembersOnline and victimGuild:getMembersOnline()) or {}

  local data = { warId = war.warId, killer = kName, victim = vName, ally = true }
  for _, member in ipairs(kMembers) do
    if member.sendGuildPacket then
      member:sendGuildPacket("warKill", data)
    end
  end

  data.ally = false
  for _, member in ipairs(vMembers) do
    if member.sendGuildPacket then
      member:sendGuildPacket("warKill", data)
    end
  end

  if war.kills and war.killsMax and ((war.kills + 1) >= war.killsMax) then
    if killerGuild.endWar then
      killerGuild:endWar(victimId, GUILDS_CFG.WARS.END_TYPE.KILLS)
    end
  end
  return true
end

StartupEvent:type("startup")
StartupEvent:register()

ThinkEvent:interval(30 * 1000)
ThinkEvent:register()

LoginEvent:type("login")
LoginEvent:register()

LogoutEvent:type("logout")
LogoutEvent:register()

DeathEvent:type("death")
DeathEvent:register()
