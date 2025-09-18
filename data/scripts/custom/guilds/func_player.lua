-- =================================================================================================
-- | FUNÇÃO ADICIONADA PARA CORRIGIR A FALTA DE 'getGuildInbox' |
-- =================================================================================================
-- Esta função busca as mensagens da guilda de um jogador diretamente do banco de dados,
-- substituindo a função nativa que não existe no seu servidor.
function Player:getGuildInboxFromDB()
    local guid = self:getGuid()
    if not guid then
        return {}
    end

    local query = string.format(
        "SELECT msg.id, msg.type, msg.text, msg.finished, msg.target_id, msg.guild_id, msg.date " ..
        "FROM `guilds_inbox` AS msg " ..
        "JOIN `guilds_player_inbox` AS player_inbox ON msg.id = player_inbox.message_id " ..
        "WHERE player_inbox.player_id = %d ORDER BY msg.date DESC;",
        guid
    )

    local resultId = db.storeQuery(query)
    if not resultId then
        return {}
    end

    local inbox = {}
    repeat
        table.insert(inbox, {
            id = result.getNumber(resultId, "id"),
            type = result.getNumber(resultId, "type"),
            text = result.getString(resultId, "text"),
            finished = result.getNumber(resultId, "finished"),
            targetId = result.getNumber(resultId, "target_id"),
            guildId = result.getNumber(resultId, "guild_id"),
            date = result.getNumber(resultId, "date")
        })
    until not result.next(resultId)

    result.free(resultId)
    return inbox
end

function rankHasPermission(rank, permission)
    if not rank then
        return false
    end
    local perms = rank:getPermissions()
    if perms == -1 then
        return true
    end
    return bit.band(perms, math.pow(2, permission)) ~= 0
end

-- =================================================================================================
-- | RESTANTE DO ARQUIVO ORIGINAL COM AS CORREÇÕES APLICADAS |
-- =================================================================================================

function Player:sendGuildPacket(action, data)
  self:sendExtendedOpcode(GUILDS_CFG.EXTOPCODE, json.encode({action = action, data = data}))
end

function Player:sendErrorMsg(msg)
  self:sendGuildPacket("error", msg)
end

function Player:fetchGuildGeneral()
  local data = nil

  local guild = self:getGuild()
  if guild then
    local rank = self:getGuildRank()
    data = {
      id = guild:getId(),
      name = guild:getName(),
      level = guild:getLevel(),
      gold = guild:getBalance(),
      contribution = self:getGuildContribution(),
      emblem = guild:getEmblem(),
      motd = guild:getMotd(),
      reqLevel = guild:getRequiredLevel(),
      language = guild:getLanguage(),
      joinStatus = guild:getJoinStatus(),
      buffs = guild:getBuffs(),
      total = guild:getCombinedLevels(),
      leader = guild:getLeaderName(),
      won = guild:getWarsWon(),
      lost = guild:getWarsLost(),
      rank = guild:getRankPosition(),
      exp = {guild:getBalance(), getGoldForLevel(guild:getLevel() + 1)},
      members = {guild:getMemberCount(), guild:getMaxMembers()},
      permissions = rank and rank:getPermissions() or 0,
      serverTime = os.time(),
      pacifism = guild:getPacifism(),
      pacifismStatus = guild:getPacifismStatus(),
      lastBuffSave = guild:getLastBuffSave()
    }
  end

  self:sendGuildPacket("general", data)

  if guild then
    self:fetchGuildMembers()
    self:fetchGuildRanks()
  end
end

function Player:fetchGuildMembers()
  local guild = self:getGuild()
  if guild then
    local data = {}
    local members = guild:getMembers()
    for _, member in ipairs(members) do
      table.insert(
        data,
        {
          voc = member.vocation,
          name = member.name,
          rank = member.rank,
          level = member.level,
          online = Player(member.name) ~= nil,
          last = member.lastLogin,
          contribution = member.contribution
        }
      )
    end
    self:sendGuildPacket("members", data)
  end
end

function Player:fetchGuildRanks()
  local guild = self:getGuild()
  if not guild then
    return
  end

  local ranks = guild:getRanks()
  local rankData = {}
  for _, rank in ipairs(ranks) do
    table.insert(rankData, {
        id = rank:getId(),
        name = rank:getName(),
        permissions = rank:getPermissions(),
        default = rank:isDefault() and 1 or 0,
        leader = rank:isLeader() and 1 or 0
    })
  end
  self:sendGuildPacket("ranks", rankData)
end

function Player:fetchTopGuilds(from, force, new)
  getTopGuilds(force)
  local data = {last = #TopGuilds, top = {}}
  if new then
    data.new = true
  end
  for i = from + 1, from + math.min(#TopGuilds - from, 10) do
    local guild = Guild(TopGuilds[i])
    if guild then
        table.insert(
        data.top,
        {
            id = guild:getId(),
            name = guild:getName(),
            leader = guild:getLeaderName(),
            level = guild:getLevel(),
            members = {guild:getMemberCount(), guild:getMaxMembers()},
            won = guild:getWarsWon(),
            lost = guild:getWarsLost(),
            total = guild:getCombinedLevels(),
            avgLevel = math.floor((guild:getCombinedLevels() / guild:getMemberCount()) + 0.5),
            language = guild:getLanguage(),
            status = guild:getJoinStatus(),
            reqLevel = guild:getRequiredLevel(),
            emblem = guild:getEmblem(),
            pacifismStatus = guild:getPacifismStatus()
        }
        )
    end
  end
  self:sendGuildPacket("top", data)
end

function Player:fetchGuildInbox(from)
  -- CORREÇÃO APLICADA AQUI: Usando a nova função getGuildInboxFromDB
  local inbox = self:getGuildInboxFromDB()

  local size = (from + math.min(#inbox - from, 10)) - from
  local data = {size = size, last = #inbox, inbox = {}}
  for i = from + 1, from + math.min(#inbox - from, 10) do
    table.insert(data.inbox, inbox[i])
  end

  self:sendGuildPacket("inbox", data)
end

function Player:createGuild(data)
  if self:getLevel() < GUILDS_CFG.CREATION_REQUIRED_LEVEL then
    self:sendErrorMsg("You need at least level " .. GUILDS_CFG.CREATION_REQUIRED_LEVEL .. " to create own guild.")
    return
  end

  local guildName = data.name:match("^%s*(.*%S)") or ""
  if guildName:len() < GUILDS_CFG.NAME_MIN_LENGTH then
    self:sendErrorMsg("Guild name is too short, use at least " .. GUILDS_CFG.NAME_MIN_LENGTH .. " characters.")
    return
  end

  if guildName:len() > GUILDS_CFG.NAME_MAX_LENGTH then
    self:sendErrorMsg("Guild name is too long, max " .. GUILDS_CFG.NAME_MAX_LENGTH .. " characters.")
    return
  end

  if not guildName:find("^[A-Za-z0-9 %-%']+$") then
    self:sendErrorMsg("Guild name contains invalid characters.")
    return
  end

  local testName = guildName:lower()
  if testName:find("  ") then
    self:sendErrorMsg("Guild name contains too many spaces.")
    return
  end

  for _, word in ipairs(GUILDS_CFG.NAME_BLACKLIST) do
    if testName:lower():find(word) then
      self:sendErrorMsg("Guild name contains blocked word.")
      return
    end
  end

  guildName = testName:gsub( "(%a)(%a+)", function(a, b) return string.upper(a) .. string.lower(b) end )

  if type(data.status) ~= "number" or type(data.lang) ~= "number" or type(data.reqLevel) ~= "number" or type(data.emblem) ~= "number" then
    self:sendErrorMsg("Creation data corrupted.")
    return
  end

  local escapedGuildName = db.escapeString(guildName)
  
  -- CORREÇÃO APLICADA AQUI: Usando a função getAllGuilds() que criamos no outro arquivo
  local allGuilds = getAllGuilds()
  for _, guild in ipairs(allGuilds) do
    if guild:getName() == guildName then
      self:sendErrorMsg("Guild name already taken.")
      return
    end
  end

  local pacifism = 0
  local pacifismStatus = GUILDS_CFG.PACIFISM.INACTIVE
  if GUILDS_CFG.PACIFISM.NEW_GUILD.ENABLED then
    pacifism = os.mtime() + getNewPacifismDuration()
    pacifismStatus = GUILDS_CFG.PACIFISM.ACTIVE
  end

  local guid = self:getGuid()
  db.query(
    string.format(
      "INSERT INTO `guilds` (`name`, `ownerid`, `creationdata`, `motd`, `balance`, `join_status`, `language`, `required_level`, `emblem`, `pacifism`, `pacifism_status`) VALUES (%s, %d, %d, '', 0, %d, %d, %d, %d, %d, %d)",
      escapedGuildName, guid, os.time(), data.status, data.lang, data.reqLevel, data.emblem, pacifism, pacifismStatus
    )
  )

  local guildId = db.lastInsertId()
  local guild = Guild(guildId)
  if guild then
    db.query("INSERT INTO `guild_ranks` (`guild_id`, `name`, `level`, `permissions`) VALUES (" .. guildId .. ", 'the Leader', 3, -1)")
	local leaderRankId = db.lastInsertId()
	db.query("INSERT INTO `guild_ranks` (`guild_id`, `name`, `level`, `permissions`) VALUES (" .. guildId .. ", 'a Vice-Leader', 2, 65535)")
	db.query("INSERT INTO `guild_ranks` (`guild_id`, `name`, `level`, `permissions`) VALUES (" .. guildId .. ", 'a Member', 1, 31)")

    local leaderRank = guild:getRankById(leaderRankId)
    db.query(string.format("INSERT INTO `guild_members` (`player_id`, `guild_id`, `rank_id`, `nick`) VALUES (%d, %d, %d, '');", self:getGuid(), guildId, leaderRank:getId()))

    self:setGuild(guild)
    self:setGuildRank(leaderRank)
    guild:setMotd("")
    guild:setLeaderName(self:getName())

    local spectators = Game.getSpectators(self:getPosition(), true, true)
    local pid = self:getId()
    for _, player in ipairs(spectators) do
        player:sendGuildPacket("emblems", {emblem = player:getGuildEmblem(self), players = {pid}})
    end

    self:fetchGuildGeneral()

    getTopGuilds(true)
    self:fetchTopGuilds(0, false, true)
    for _, player in ipairs(Game.getPlayers()) do
        if player:getId() ~= self:getId() then
        player:fetchTopGuilds(0, false, true)
        end
    end
  end
end

function Player:donateToGuild(gold)
  if gold <= 0 then
    return false
  end

  local guild = self:getGuild()
  if not guild then
    return false
  end

  if self:getMoney() + self:getBankBalance() < gold then
    return false
  end

  self:removeMoney(gold)
  guild:setBalance(guild:getBalance() + gold)
  self:addGuildContribution(gold)

  local newGold = guild:getBalance()
  local membersOnline = guild:getMembersOnline()
  local data = {
    gold = newGold,
    next = getGoldForLevel(guild:getLevel() + 1)
  }
  local msgText = self:getName() .. " deposited {" .. gold .. "}."
  local msgId = guild:addInboxMessage(GUILDS_CFG.MESSAGE_TYPES.GOLD_DEPOSIT, msgText)

  for _, member in ipairs(membersOnline) do
    member:sendGuildPacket("gold", data)
    member:sendInboxMessage(msgId, GUILDS_CFG.MESSAGE_TYPES.GOLD_DEPOSIT, msgText)
  end

  local contribution = self:getGuildContribution()
  data = {
    name = self:getName(),
    contribution = contribution
  }
  self:sendGuildPacket("contribution", contribution)
  for _, member in ipairs(membersOnline) do
    member:sendGuildPacket("contribution", data)
  end
  return true
end

function Player:levelUpGuild()
  local guild = self:getGuild()
  if not guild then
    return
  end

  local level = guild:getLevel()
  local gold = guild:getBalance()
  local newLevel = level + 1
  local need = getGoldForLevel(newLevel)
  if gold < need then
    return
  end

  guild:setBalance(guild:getBalance() - need)
  guild:setLevel(newLevel)

  local newGold = guild:getBalance()
  local members = guild:getMembersOnline()
  local membersCount = {guild:getMemberCount(), guild:getMaxMembers()}
  local data = {
    level = newLevel,
    gold = newGold,
    next = getGoldForLevel(newLevel + 1),
    members = membersCount
  }
  for _, member in ipairs(members) do
    member:sendGuildPacket("level", data)
  end

  data = {
    id = guild:getId(),
    level = newLevel,
    members = membersCount
  }
  local players = Game.getPlayers()
  for _, player in ipairs(players) do
    player:sendGuildPacket("topUpdate", data)
  end
end

function Player:invitePlayerToGuild(name)
  local guild = self:getGuild()
  if not guild then
    return
  end

  local rank = self:getGuildRank()
  if not rank or not rankHasPermission(rank, GUILDS_CFG.PERMISSIONS.INVITE_MEMBERS) then
    return
  end

  local target = Player(name)
  if not target then
    self:sendErrorMsg("A player with this name is not online.")
    return
  end

  if target:getGuild() then
    self:sendErrorMsg("Player is already in a guild.")
    return
  end

  if target:getLevel() < guild:getRequiredLevel() then
    self:sendErrorMsg("Player doesn't meet level requirement.")
    return
  end

  local guildId = guild:getId()
  
  -- CORREÇÃO APLICADA AQUI: Usando a nova função getGuildInboxFromDB
  local targetInbox = target:getGuildInboxFromDB()
  for _, message in ipairs(targetInbox) do
    if message.finished == 0 then
      if message.type == GUILDS_CFG.MESSAGE_TYPES.JOIN_INVITATION and message.guildId == guildId then
        self:sendErrorMsg("This player was already invited to this guild.")
        return
      end
    end
  end

  local text = string.format("Player {%s} invited you to join guild {%s}.", self:getName(), guild:getName())
  db.query(
    string.format(
      "INSERT INTO `guilds_inbox` VALUES (NULL, %d, %d, %d, %d, %s, %d);",
      0, guildId, os.time(), GUILDS_CFG.MESSAGE_TYPES.JOIN_INVITATION, db.escapeString(text), 0
    )
  )
  local msgId = db.lastInsertId()
  db.query(string.format("INSERT INTO `guilds_player_inbox` VALUES (%d, %d);", target:getGuid(), msgId))
  target:sendInboxMessage(msgId, GUILDS_CFG.MESSAGE_TYPES.JOIN_INVITATION, text, false, 0, guildId)
end

function Player:kickGuildMember(name)
  local guild = self:getGuild()
  if not guild then
    return
  end
  
  local myRank = self:getGuildRank()
  if not myRank or not rankHasPermission(myRank, GUILDS_CFG.PERMISSIONS.EDIT_MEMBERS) then
    return
  end

  local guid = 0
  local rankId = 0

  local target = Player(name)
  if target then
    guid = target:getGuid()
	local targetRank = target:getGuildRank()
	if targetRank then
	    rankId = targetRank:getId()
	end
  else
    local resultId = db.storeQuery(string.format("SELECT p.id, gm.rank_id FROM players p JOIN guild_members gm ON p.id = gm.player_id WHERE p.name = %s", db.escapeString(name)))
    if resultId ~= false then
      guid = result.getNumber(resultId, "id")
      rankId = result.getNumber(resultId, "rank_id")
      result.free(resultId)
    end
  end

  if guid == 0 then return end
  
  local rank = guild:getRankById(rankId)
  if not rank or rank:isLeader() or myRank:getLevel() <= rank:getLevel() then
    return
  end

  local msgText = string.format("{{%s} was kicked from the guild by {%s}.", name, self:getName())
  local msgId = guild:addInboxMessage(GUILDS_CFG.MESSAGE_TYPES.KICKED_OUT, msgText)

  db.query("DELETE FROM guild_members WHERE player_id = " .. guid)
  
  local players = Game.getPlayers()

  if target then
    target:setGuild(nil)
    target:sendGuildPacket("left")
    target:sendClosePrivate(0)

    local pid = target:getId()
    for _, player in ipairs(players) do
      player:sendGuildPacket("removeEmblem", pid)
    end
  end

  local members = guild:getMembersOnline()
  if target then
    local data = {emblem = 0, players = {}} -- Assuming 0 is other emblem
    for _, member in ipairs(members) do
      table.insert(data.players, member:getId())
    end
    target:sendGuildPacket("emblems", data)
  end

  local combinedLevels = guild:getCombinedLevels()
  local newMembers = {guild:getMemberCount(), guild:getMaxMembers()}
  local data = {
    name = name,
    levels = combinedLevels,
    members = newMembers
  }

  for _, member in ipairs(members) do
    member:sendGuildPacket("kicked", data)
  end

  sendGuildChannelMessage(guild:getId(), TALKTYPE_CHANNEL_R1, name .. " was kicked from the guild by " .. self:getName() .. ".")

  data = {
    id = guild:getId(),
    avgLevel = math.floor(combinedLevels / guild:getMemberCount() + 0.5),
    levels = combinedLevels,
    members = newMembers
  }

  for _, player in ipairs(players) do
    player:sendGuildPacket("topUpdate", data)
  end

  for _, member in ipairs(members) do
    member:sendInboxMessage(msgId, GUILDS_CFG.MESSAGE_TYPES.KICKED_OUT, msgText)
  end
end

function Player:saveGuildRanks(data)
  local guild = self:getGuild()
  if not guild then
    return
  end

  local myRank = self:getGuildRank()
  if not myRank or not rankHasPermission(myRank, GUILDS_CFG.PERMISSIONS.EDIT_ROLES) then
    return
  end

  if #data < 2 then
    return
  end

  for _, tempRank in ipairs(data) do
    if tempRank.leader and tempRank.removed then
      return
    elseif tempRank.default and tempRank.removed then
      return
    end
  end

  if #data == 2 then
    for _, tempRank in ipairs(data) do
      if not tempRank.leader and not tempRank.default then
        return
      end
    end
  end

  local hasDefault = false
  for _, tempRank in ipairs(data) do
    if tempRank.default then
      hasDefault = true
      break
    end
  end
  if not hasDefault then
    return
  end

  local membersOnline = guild:getMembersOnline()
  for _, tempRank in ipairs(data) do
    if tempRank.removed then
      for _, member in ipairs(membersOnline) do
        local rank = member:getGuildRank()
        if rank.id == tempRank.id then
          member:setGuildRank(guild:getDefaultRank())
        end
      end
      db.query("DELETE FROM `guild_ranks` WHERE `id` = " .. tempRank.id)
    elseif tempRank.new then
      db.query(
        string.format(
          "INSERT INTO guild_ranks VALUES(NULL, %d, %s, %d, %d, 0)",
          guild:getId(),
          db.escapeString(tempRank.name),
          tempRank.permissions,
          tempRank.default and 1 or 0
        )
      )
      tempRank.id = db.lastInsertId()
      tempRank.new = nil
    else
      db.query(string.format("UPDATE `guild_ranks` SET `name` = %s, `permissions` = %d, `default` = %d WHERE `id` = %d", db.escapeString(tempRank.name), tempRank.permissions, tempRank.default and 1 or 0, tempRank.id))
    end
  end
  
  local ranks = guild:getRanks()
  local rankData = {}
  for _, rank in ipairs(ranks) do
    table.insert(rankData, {
        id = rank:getId(),
        name = rank:getName(),
        permissions = rank:getPermissions(),
        default = rank:isDefault() and 1 or 0,
        leader = rank:isLeader() and 1 or 0
    })
  end

  for _, member in ipairs(membersOnline) do
    member:sendGuildPacket("perms", member:getGuildRank():getPermissions())
    member:sendGuildPacket("ranks", rankData)
  end
end

function Player:updateGuildSettings(data)
  local guild = self:getGuild()
  if not guild then
    return
  end

  local myRank = self:getGuildRank()
  if not myRank or not rankHasPermission(myRank, GUILDS_CFG.PERMISSIONS.EDIT_SETTINGS) then
    return
  end

  guild:setJoinStatus(data.status)
  guild:setLanguage(data.language)
  guild:setRequiredLevel(data.reqLevel)
  guild:setEmblem(data.emblem)
  guild:setMotd(data.motd)

  local members = guild:getMembersOnline()
  for _, member in ipairs(members) do
    member:sendGuildPacket("settings", data)
  end

  local updateData = {
    id = guild:getId(),
    status = data.status,
    language = data.language,
    reqLevel = data.reqLevel,
    emblem = data.emblem
  }
  local players = Game.getPlayers()
  for _, player in ipairs(players) do
    player:sendGuildPacket("topUpdate", updateData)
  end
end

function Player:sendOnlineUpdate(offline)
  local guild = self:getGuild()
  if not guild then
    return
  end

  local name = self:getName()
  local members = guild:getMembersOnline()
  for _, member in ipairs(members) do
    if self ~= member then
      member:sendGuildPacket(offline and "offline" or "online", name)
    end
  end
end

function Player:setGuildMemberRank(data)
  local guild = self:getGuild()
  if not guild then
    return
  end

  local myRank = self:getGuildRank()
  if not myRank or not rankHasPermission(myRank, GUILDS_CFG.PERMISSIONS.EDIT_MEMBERS) then
    return
  end

  local newRank = guild:getRankById(data.rankId)
  if not newRank or newRank:isLeader() then
    return
  end

  local guid = 0
  local currentRankId = 0
  local target = Player(data.name)
  if target then
    guid = target:getGuid()
    currentRankId = target:getGuildRank():getId()
  else
    local resultId = db.storeQuery(string.format("SELECT p.id, gm.rank_id FROM players p JOIN guild_members gm ON p.id = gm.player_id WHERE p.name = %s", db.escapeString(data.name)))
    if resultId then
        guid = result.getNumber(resultId, "id")
        currentRankId = result.getNumber(resultId, "rank_id")
        result.free(resultId)
    end
  end

  if guid == 0 then return end
  
  local currentRank = guild:getRankById(currentRankId)
  if not currentRank or currentRank:isLeader() then
    return
  end

  db.query(string.format("UPDATE `guild_members` SET `rank_id` = %d WHERE `player_id` = %d", newRank:getId(), guid))

  local members = guild:getMembersOnline()
  for _, member in ipairs(members) do
    member:sendGuildPacket("memberRank", {name = data.name, rank = newRank:getName()})
  end

  if target then
    target:setGuildRank(newRank)
    target:sendGuildPacket("perms", newRank:getPermissions())
  end
end

function Player:leaveGuild()
  local guild = self:getGuild()
  if not guild then
    return
  end

  local players = Game.getPlayers()
  local guildName = guild:getName()
  local guildId = guild:getId()
  local pid = self:getId()
  local myRank = self:getGuildRank()
  local disband = myRank and myRank:isLeader()

  if disband then
    local wars = guild:getWars()
    for _, war in ipairs(wars) do
      local targetGuild = Guild(war.guildId)
      if targetGuild then
        targetGuild:endWar(guildId, GUILDS_CFG.WARS.END_TYPE.SURRENDER)
      end
    end
    
    db.query("DELETE FROM guild_members WHERE guild_id = " .. guildId)
    db.query("DELETE FROM guild_ranks WHERE guild_id = " .. guildId)
    db.query("DELETE FROM guilds WHERE id = " .. guildId)

    local msgText = string.format("Guild {%s} has been disbanded by the leader.", guildName)
    
    local membersOnline = guild:getMembersOnline()
    local removeEmblemPlayers = {}
    for _, member in ipairs(membersOnline) do
      member:setGuild(nil)
      member:sendClosePrivate(0)
      member:sendGuildPacket("disbanded")

      local spectators = Game.getSpectators(member:getPosition(), true, true)
      for _, player in ipairs(spectators) do
        if not removeEmblemPlayers[player:getId()] then
          removeEmblemPlayers[player:getId()] = player
        end
      end
    end

    local data = {}
    for _, member in ipairs(membersOnline) do
      table.insert(data, member:getId())
    end

    for _, player in ipairs(removeEmblemPlayers) do
      player:sendGuildPacket("removeEmblem", data)
    end

    getTopGuilds(true)
    for _, player in ipairs(players) do
      player:fetchTopGuilds(0, false, true)
    end

  else
    if not GUILDS_CFG.WARS.CAN_LEAVE and guild:isInAnyWar() then
      self:sendErrorMsg("You can't leave the guild while at war.")
      return
    end

    local guid = self:getGuid()
    local msgText = string.format("Member {%s} has left the guild.", self:getName())
    guild:addInboxMessage(GUILDS_CFG.MESSAGE_TYPES.MEMBER_LEFT, msgText)

    db.query("DELETE FROM guild_members WHERE player_id = " .. guid)

    self:setGuild(nil)
    self:sendGuildPacket("left")
    self:sendClosePrivate(0)

    for _, player in ipairs(players) do
      player:sendGuildPacket("removeEmblem", pid)
    end

    local members = guild:getMembersOnline()
    local data = {emblem = 0, players = {}}
    for _, member in ipairs(members) do
      table.insert(data.players, member:getId())
    end
    self:sendGuildPacket("emblems", data)

    local combinedLevels = guild:getCombinedLevels()
    local membersCount = guild:getMemberCount()
    local newMembers = {membersCount, guild:getMaxMembers()}
    data = {
      name = self:getName(),
      levels = combinedLevels,
      members = newMembers
    }
    for _, member in ipairs(members) do
      member:sendGuildPacket("kicked", data)
    end

    data = {
      id = guildId,
      avgLevel = membersCount > 0 and math.floor(combinedLevels / membersCount + 0.5) or 0,
      levels = combinedLevels,
      members = newMembers
    }

    for _, player in ipairs(players) do
      player:sendGuildPacket("topUpdate", data)
    end
  end
end

function Player:acceptGuildMessage(data)
  local msgId = data.id
  local type = data.type
  local guildId = data.guildId
  local targetId = data.targetId
  if type == GUILDS_CFG.MESSAGE_TYPES.JOIN_INVITATION then
    if self:getGuild() then
      self:sendErrorMsg("You are already in a guild.")
      return
    end

    local guild = Guild(guildId)
    if guild then
      if guild:getMemberCount() >= guild:getMaxMembers() then
        self:sendErrorMsg("Guild's max members count reached.")
      else
        guild:addNewMember(self)
      end
    else
      self:sendErrorMsg("Target guild no longer exists.")
    end
    db.query("UPDATE `guilds_inbox` SET `finished` = 1 WHERE `id` = " .. msgId)
    self:sendGuildPacket("finished", msgId)
  elseif type == GUILDS_CFG.MESSAGE_TYPES.JOIN_REQUEST then
    local guild = self:getGuild()
    if not guild or not rankHasPermission(self:getGuildRank(), GUILDS_CFG.PERMISSIONS.INVITE_MEMBERS) then
      self:sendErrorMsg("You don't have permissions to do this.")
      return
    end

    local resultId = db.storeQuery(string.format("SELECT `id` FROM `players` WHERE `id` = %d AND `guild_id` = 0", targetId))
    if not resultId then
        self:sendErrorMsg("This player is already in a guild or does not exist.")
        return
    end
    result.free(resultId)

    local target = Player(targetId)
    if guild:getMemberCount() >= guild:getMaxMembers() then
        self:sendErrorMsg("Guild's max members count reached.")
    else
        if target then guild:addNewMember(target) else guild:addNewMemberOffline(targetId) end
    end
    
    guild:finishInboxMessage(msgId, type)
  elseif type == GUILDS_CFG.MESSAGE_TYPES.WAR_DECLARATION then
    local guild = self:getGuild()
    if not guild or not rankHasPermission(self:getGuildRank(), GUILDS_CFG.PERMISSIONS.MANAGE_WARS) then
      self:sendErrorMsg("You don't have permissions to do this.")
      return
    end

    local targetGuild = Guild(data.guildId)
    if not targetGuild then return end

    local war = guild:getWar(data.guildId)
    if not war then
        self:sendErrorMsg("Something went wrong. Declaration is outdated?")
        return
    end
    
    if guild:getBalance() < war.goldBet then
      self:sendErrorMsg("Your guild doesn't have enough gold.")
      return
    end

    if targetGuild:getBalance() < war.goldBet then
      self:sendErrorMsg("Opposite guild doesn't have enough gold.")
      return
    end

    guild:setBalance(guild:getBalance() - war.goldBet)
    targetGuild:setBalance(targetGuild:getBalance() - war.goldBet)

    guild:sendGold()
    targetGuild:sendGold()

    db.asyncQuery(string.format("UPDATE `guild_wars` SET `status` = %d WHERE `id` = %d", GUILDS_CFG.WARS.STATUS.PREPARING, war.warId))

    guild:finishInboxMessage(msgId, type)

    local members = guild:getMembersOnline()
    local targetMembers = targetGuild:getMembersOnline()

    for _, member in ipairs(members) do member:sendGuildPacket("warPrepare", war.warId) end
    for _, targetMember in ipairs(targetMembers) do targetMember:sendGuildPacket("warPrepare", war.warId) end
  end
end

function Player:rejectGuildMessage(data)
  local msgId = data.id
  local type = data.type
  if type == GUILDS_CFG.MESSAGE_TYPES.JOIN_INVITATION then
    db.query("UPDATE `guilds_inbox` SET `finished` = 1 WHERE `id` = " .. msgId)
    self:sendGuildPacket("finished", msgId)
    return
  end

  local guild = self:getGuild()
  if not guild then
    self:sendErrorMsg("You are not in a guild.")
    return
  end

  if type == GUILDS_CFG.MESSAGE_TYPES.JOIN_REQUEST and not rankHasPermission(self:getGuildRank(), GUILDS_CFG.PERMISSIONS.INVITE_MEMBERS) then
    self:sendErrorMsg("You don't have permissions to do this.")
    return
  end

  if type == GUILDS_CFG.MESSAGE_TYPES.WAR_DECLARATION and not rankHasPermission(self:getGuildRank(), GUILDS_CFG.PERMISSIONS.MANAGE_WARS) then
    self:sendErrorMsg("You don't have permissions to do this.")
    return
  end

  if type == GUILDS_CFG.MESSAGE_TYPES.JOIN_REQUEST then
    guild:finishInboxMessage(msgId, type)
  elseif type == GUILDS_CFG.MESSAGE_TYPES.WAR_DECLARATION then
    local targetGuild = Guild(data.guildId)
    if targetGuild then
      local targetMembers = targetGuild:getMembersOnline()
      for _, member in ipairs(targetMembers) do
        member:sendGuildPacket("warEnd", data.targetId)
      end
    end
    guild:finishInboxMessage(msgId, type)

    local members = guild:getMembersOnline()
    for _, member in ipairs(members) do
      member:sendGuildPacket("warEnd", data.targetId)
    end
  end
end

function Player:requestGuildJoin(guildId)
  if self:getGuild() then
    self:sendErrorMsg("You are already in a guild.")
    return
  end

  local guild = Guild(guildId)
  if not guild then
    self:sendErrorMsg("Target guild no longer exists.")
    return
  end

  local level = self:getLevel()
  if level < guild:getRequiredLevel() then
    self:sendErrorMsg("You are missing required level to join this guild.")
    return
  end

  local guid = self:getGuid()
  local resultId = db.storeQuery(string.format("SELECT `finished` FROM `guilds_inbox` WHERE `target_id` = %d AND `guild_id` = %d AND `type` = %d AND `finished` = 0 LIMIT 1;", guid, guildId, GUILDS_CFG.MESSAGE_TYPES.JOIN_REQUEST))
  if resultId ~= false then
    local finished = result.getNumber(resultId, "finished") == 1
    result.free(resultId)
    if not finished then
      self:sendErrorMsg("Your last request is still pending for a decision.")
      return
    end
  end

  local sex = self:getSex() == PLAYERSEX_FEMALE and "She" or "He"
  local vocation = self:getVocation():getName()
  local msgText = string.format("Player {%s} (Level {%d}) requested to join your guild. %s is a %s.", self:getName(), level, sex, vocation)
  local msgId = guild:addInboxMessage(GUILDS_CFG.MESSAGE_TYPES.JOIN_REQUEST, msgText, guid, guildId)
  local membersOnline = guild:getMembersOnline()
  for _, member in ipairs(membersOnline) do
    if rankHasPermission(member:getGuildRank(), GUILDS_CFG.PERMISSIONS.INVITE_MEMBERS) then
      member:sendInboxMessage(msgId, GUILDS_CFG.MESSAGE_TYPES.JOIN_REQUEST, msgText, false, guid, guildId)
    end
  end
end

function Player:saveGuildBuffs(buffs)
  local guild = self:getGuild()
  if not guild or not rankHasPermission(self:getGuildRank(), GUILDS_CFG.PERMISSIONS.MANAGE_BUFFS) then
    return
  end

  if guild:getLastBuffSave() + getBuffsDelayDuration() > os.mtime() then
    self:sendErrorMsg("You can't save buffs yet.")
    return
  end

  local online = guild:getMembersOnline()

  for _, member in ipairs(online) do
    member:removeGuildBuffs()
  end
  
  local buffString = ""
  for row, buff in ipairs(buffs) do
    buffString = buffString .. buff .. ";"
  end

  db.query("UPDATE `guilds` SET `buffs` = '"..buffString.."' WHERE id = " .. guild:getId())
  db.query("UPDATE `guilds` SET `last_buff_save` = "..os.time().." WHERE id = " .. guild:getId())
  
  local data = {lastSave = os.mtime(), buffs = buffs}
  for _, member in ipairs(online) do
    member:applyGuildBuffs()
    member:sendGuildPacket("buffs", data)
  end
end

function Player:startPacifistMode()
  local guild = self:getGuild()
  if not guild or not rankHasPermission(self:getGuildRank(), GUILDS_CFG.PERMISSIONS.MANAGE_WARS) then
    return
  end

  if guild:getPacifismStatus() == GUILDS_CFG.PACIFISM.ACTIVE then
    self:sendErrorMsg("Guild is already using Pacifist Mode.")
    return
  end

  if guild:getPacifismStatus() == GUILDS_CFG.PACIFISM.EXHAUSTED then
    self:sendErrorMsg("Pacifist Mode is currently exhausted.")
    return
  end

  if guild:getBalance() < getPacifismCost() then
    self:sendErrorMsg("Not enough gold in guild bank.")
    return
  end

  local endDate = os.mtime() + getPacifismDuration()
  db.query("UPDATE `guilds` SET `pacifism` = "..endDate..", `pacifism_status` = "..GUILDS_CFG.PACIFISM.ACTIVE.." WHERE `id` = " .. guild:getId())
  guild:setBalance(guild:getBalance() - getPacifismCost())

  guild:sendGold()
  guild:sendPacifismStatus()

  local guildId = guild:getId()
  local pacifismUp = {
    guildId = guildId,
    pacifismStatus = guild:getPacifismStatus()
  }
  local players = Game.getPlayers()
  for _, player in ipairs(players) do
    player:sendGuildPacket("pacifismUp", pacifismUp)
  end

  local wars = guild:getWars()
  for _, war in ipairs(wars) do
    local targetGuild = Guild(war.guildId)
    if targetGuild then
      targetGuild:endWar(guildId, GUILDS_CFG.WARS.END_TYPE.SURRENDER)
    end
  end
end

function Player:declareGuildWar(data)
  local guild = self:getGuild()
  if not guild or not rankHasPermission(self:getGuildRank(), GUILDS_CFG.PERMISSIONS.MANAGE_WARS) then
    return
  end

  local targetGuild = Guild(data.guildId)
  if not targetGuild then
    self:sendErrorMsg("This guild does not exist.")
    return
  end

  if targetGuild:getPacifismStatus() == GUILDS_CFG.PACIFISM.ACTIVE then
    self:sendErrorMsg("This guild is under Pacifist Mode.")
    return
  end

  if guild:isInAnyWar(targetGuild:getId()) then
    self:sendErrorMsg("Your guild is already in war with this guild.")
    return
  end

  if not data.forced and guild:getBalance() < data.goldBet then
    self:sendErrorMsg("Your guild doesen't have enough gold")
    return
  end

  if not data.forced and targetGuild:getBalance() < data.goldBet then
    self:sendErrorMsg("Target guild doesen't have enough gold")
    return
  end

  if data.forced then
    data.goldBet = 0
  else
    data.goldBet = math.clamp(data.goldBet, GUILDS_CFG.WARS.GOLD_BET.MIN, GUILDS_CFG.WARS.GOLD_BET.MAX)
  end
  data.duration = data.duration
  data.duration = math.clamp(data.duration, GUILDS_CFG.WARS.DURATION.MIN * 24 * 60 * 60, GUILDS_CFG.WARS.DURATION.MAX * 24 * 60 * 60)
  data.kills = math.clamp(data.kills, GUILDS_CFG.WARS.KILLS.MIN, GUILDS_CFG.WARS.KILLS.MAX)

  local started = os.time() + getWarPrepTime()
  local ended = os.time() + getWarPrepTime() + data.duration

  if guild:getPacifismStatus() == GUILDS_CFG.PACIFISM.ACTIVE then
    guild:cooldownPacifism()
  end

  if data.forced then
    if guild:getBalance() < getForcedWarCost() then
      self:sendErrorMsg("Your guild doesen't have enough gold")
      return
    end
    guild:setBalance(guild:getBalance() - getForcedWarCost())
  end

  local guildId = guild:getId()
  local targetId = targetGuild:getId()

  local status = data.forced and GUILDS_CFG.WARS.STATUS.PREPARING or GUILDS_CFG.WARS.STATUS.DECLARATION
  db.query(
    string.format(
      "INSERT INTO `guild_wars` VALUES (NULL, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d)",
      guildId, targetId, status, data.goldBet, data.duration, data.kills, data.forced and 1 or 0, started, ended, guildId
    )
  )

  local warId = db.lastInsertId()
  
  if not data.forced then
    local msgText = string.format("Guild {%s} delcared war with your guild, war will take up to {%s}, {%d kills} and victorious guild is paid {%s gold} by defeated guild.", guild:getName(), toTime(data.duration), data.kills, comma_value(data.goldBet))
    local membersOnline = targetGuild:getMembersOnline()
    local msgId = targetGuild:addInboxMessage(GUILDS_CFG.MESSAGE_TYPES.WAR_DECLARATION, msgText, warId, guildId)
    for _, member in ipairs(membersOnline) do
      if rankHasPermission(member:getGuildRank(), GUILDS_CFG.PERMISSIONS.MANAGE_WARS) then
        member:sendInboxMessage(msgId, GUILDS_CFG.MESSAGE_TYPES.WAR_DECLARATION, msgText, false, warId, guildId)
      end
    end
  end

  do
    local war = {
      guildId = targetId, warId = warId, status = status, killsMax = data.kills, goldBet = data.goldBet, duration = data.duration, started = started, forced = data.forced, name = targetGuild:getName(), emblem = targetGuild:getEmblem()
    }
    local membersOnline = guild:getMembersOnline()
    for _, member in ipairs(membersOnline) do
      member:sendGuildPacket("newWar", war)
    end
  end

  do
    local war = {
      guildId = guildId, warId = warId, status = status, killsMax = data.kills, goldBet = data.goldBet, duration = data.duration, started = started, forced = data.forced, name = guild:getName(), emblem = guild:getEmblem()
    }
    local membersOnline = targetGuild:getMembersOnline()
    for _, member in ipairs(membersOnline) do
      member:sendGuildPacket("newWar", war)
    end
  end
end

function Player:fetchGuildWars()
  local guild = self:getGuild()
  if not guild then
    return
  end

  local wars = {}
  local result = db.storeQuery("SELECT * FROM `guild_wars` WHERE `guild1` = " .. guild:getId() .. " OR `guild2` = " .. guild:getId())
  if result then
    repeat
        table.insert(wars, {
            guildId = result.getNumber(result, "guild1") == guild:getId() and result.getNumber(result, "guild2") or result.getNumber(result, "guild1"),
            warId = result.getNumber(result, "id"),
            status = result.getNumber(result, "status"),
            killsMax = result.getNumber(result, "frags"),
            goldBet = result.getNumber(result, "payment"),
            duration = result.getNumber(result, "total_time"),
            started = result.getNumber(result, "started"),
            forced = result.getNumber(result, "forced") == 1
        })
    until not result.next(result)
    result.free(result)
  end

  local data = {}
  for _, war in ipairs(wars) do
    if war.status ~= GUILDS_CFG.WARS.STATUS.ENDED then
      local targetGuild = Guild(war.guildId)
      if targetGuild then
        table.insert(data, {
            guildId = war.guildId, warId = war.warId, status = war.status, killsMax = war.killsMax, goldBet = war.goldBet,
            duration = war.duration, started = war.started, forced = war.forced, name = targetGuild:getName(), emblem = targetGuild:getEmblem()
        })
      end
    end
  end

  local guildId = guild:getId()
  local resultId = db.storeQuery(string.format([[SELECT k.warid, k.killer, k.target, k.killerguild FROM `guildwar_kills` AS k INNER JOIN `guild_wars` AS w ON w.id = k.warid WHERE (`killerguild` = %d or `targetguild` = %d) AND w.status = %d]], guildId, guildId, GUILDS_CFG.WARS.STATUS.STARTED))
  local warKills = {}
  if resultId ~= false then
    repeat
      local warId = result.getNumber(resultId, "warid")
      local killer = result.getString(resultId, "killer")
      local target = result.getString(resultId, "target")
      local killerGuild = result.getNumber(resultId, "killerguild")
      table.insert(warKills, {
          warId = warId, killer = killer, target = target, ally = killerGuild == guildId
      })
    until not result.next(resultId)
    result.free(resultId)
  end

  local msg = NetworkMessage()
  msg:addByte(GUILDS_CFG.OPCODE)
  msg:addU32(#warKills)
  for _, kill in ipairs(warKills) do
    msg:addU16(kill.warId)
    msg:addString(kill.killer)
    msg:addString(kill.target)
    msg:addByte(kill.ally and 1 or 0)
  end
  msg:sendToPlayer(self)

  self:sendGuildPacket("wars", data)
end

function Player:fetchGuildsConfig()
  self:sendGuildPacket("config", GUILDS_CFG)
end

function Player:revokeGuildDeclaration(targetId)
  local guild = self:getGuild()
  if not guild then return end

  local targetGuild = Guild(targetId)
  if not targetGuild then return end

  local war = guild:getWar(targetId)
  if not war then return end

  local initiator = db.storeQuery("SELECT `initiator` FROM `guild_wars` WHERE `id` = " .. war.warId)
  if not initiator then return end
  local initId = result.getNumber(initiator, "initiator")
  result.free(initiator)

  local resultId = db.storeQuery(string.format("SELECT id FROM guilds_inbox WHERE guild_id = %d AND target_id = %d AND type = %d AND finished = 0;", initId == guild:getId() and guild:getId() or targetId, war.warId, GUILDS_CFG.MESSAGE_TYPES.WAR_DECLARATION))
  local msgId = 0
  if resultId ~= false then
    msgId = result.getNumber(resultId, "id")
    result.free(resultId)
  end

  if msgId == 0 then return end

  if initId == guild:getId() then
    targetGuild:finishInboxMessage(msgId, GUILDS_CFG.MESSAGE_TYPES.WAR_DECLARATION)
  else
    guild:finishInboxMessage(msgId, GUILDS_CFG.MESSAGE_TYPES.WAR_DECLARATION)
  end

  db.query("DELETE FROM `guild_wars` WHERE `id` = " .. war.warId)

  local members = guild:getMembersOnline()
  for _, member in ipairs(members) do member:sendGuildPacket("warRevoked", war.warId) end

  local targetMembers = targetGuild:getMembersOnline()
  for _, member in ipairs(targetMembers) do member:sendGuildPacket("warRevoked", war.warId) end
end

function Player:surrenderGuildWar(guildId)
  local guild = self:getGuild()
  if not guild then return end

  local targetGuild = Guild(guildId)
  if not targetGuild then return end

  local war = guild:getWar(guildId)
  if not war then return end

  db.asyncQuery(string.format("UPDATE `guild_wars` SET `status` = %d, `ended` = %d WHERE id = %d", GUILDS_CFG.WARS.STATUS.ENDED, os.time(), war.warId))
  targetGuild:endWar(guild:getId(), GUILDS_CFG.WARS.END_TYPE.SURRENDER)
end

function Player:passLeader(name)
  local guild = self:getGuild()
  if not guild then
    return
  end

  local myRank = self:getGuildRank()
  if not myRank or not myRank:isLeader() then
    return
  end

  local target = Player(name)
  if not target then
    self:sendErrorMsg("Player has to be online!")
    return
  end

  if target:getName() == self:getName() then
    return
  end
  
  if target:getGuild() ~= guild then
    self:sendErrorMsg("Player is not in your guild.")
    return
  end

  local targetRank = target:getGuildRank()
  db.query(string.format("UPDATE `guild_members` SET `rank_id` = %d WHERE `player_id` = %d", targetRank:getId(), self:getGuid()))
  db.query(string.format("UPDATE `guild_members` SET `rank_id` = %d WHERE `player_id` = %d", myRank:getId(), target:getGuid()))
  db.query(string.format("UPDATE `guilds` SET `ownerid` = %d WHERE `id` = %d", target:getGuid(), guild:getId()))

  self:setGuildRank(targetRank)
  target:setGuildRank(myRank)

  local data = {
    newLeader = target:getName(),
    newLeaderRank = myRank:getName(),
    oldLeader = self:getName(),
    oldLeaderRank = targetRank:getName()
  }
  local members = guild:getMembersOnline()
  for _, member in ipairs(members) do
    member:sendGuildPacket("newLeader", data)
  end
  self:sendGuildPacket("perms", targetRank:getPermissions())
  target:sendGuildPacket("perms", myRank:getPermissions())
end

-- =====================================================================
-- | ÚLTIMA CORREÇÃO |
-- =====================================================================
-- CORREÇÃO APLICADA AQUI: A função original chamava métodos que não existem.
-- Esta versão envia os dados diretamente para o cliente.
function Player:sendInboxMessage(msgId, msgType, text, finished, targetId, guildId)
  local newMsg = {
    id = msgId,
    type = msgType,
    text = text,
    finished = (finished and 1 or 0),
    targetId = targetId or 0,
    guildId = guildId or 0,
    date = os.time()
  }
  self:sendGuildPacket("message", newMsg)
end

function toTime(time)
  local weeks = math.floor(time / 604800)
  local days = math.floor(math.fmod(time, 604800) / 86400)
  local hours = math.floor(math.fmod(time, 86400) / 3600)
  local minutes = math.floor(math.fmod(time, 3600) / 60)
  local seconds = math.floor(math.fmod(time, 60))

  local space = false
  local str = ""
  if weeks > 0 then
    str = string.format("%d week%s", weeks, (weeks > 1 and "s" or ""))
    space = true
  end
  if days > 0 then
    if space then
      str = string.format("%s ", str)
      space = false
    end
    str = string.format("%s%d day%s", str, days, (days > 1 and "s" or ""))
    space = true
  end
  if hours > 0 then
    if space then
      str = string.format("%s ", str)
      space = false
    end
    str = string.format("%s%d hour%s", str, hours, (hours > 1 and "s" or ""))
    space = true
  end
  if minutes > 0 then
    if space then
      str = string.format("%s ", str)
      space = false
    end
    str = string.format("%s%d minute%s", str, minutes, (minutes > 1 and "s" or ""))
    space = true
  end
  if seconds > 0 then
    if space then
      str = string.format("%s ", str)
      space = false
    end
    str = string.format("%s%d second%s", str, seconds, (seconds > 1 and "s" or ""))
  end
  return str
end

-- formata número com separador de milhar em pontos
function comma_value(n)
  local left, num, right = string.match(n, "^([^%d]*%d)(%d*)(.-)$")
  if not left then
    return tostring(n)
  end
  return left .. (num:reverse():gsub("(%d%d%d)", "%1."):reverse()) .. right
end

-- retorna o nome do rank do jogador na guild (ou nil)
if not Player.getGuildRank then
  function Player:getGuildRank()
    local guid = self.getGuid and self:getGuid() or nil
    if not guid then
      return nil
    end
    local res = db.storeQuery(string.format(
      "SELECT r.name FROM guild_membership m JOIN guild_ranks r ON r.id=m.rank_id WHERE m.player_id=%d LIMIT 1",
      guid
    ))
    if res ~= false then
      local name = result.getString(res, "name")
      result.free(res)
      return name
    end
    return nil
  end
end

-- proteger fetchGuildGeneral contra ausência de guild/objeto e contra ausência do original
local _orig_fetchGuildGeneral = Player.fetchGuildGeneral
function Player:fetchGuildGeneral(...)
  -- se não houver implementação original, apenas sair silenciosamente
  if not _orig_fetchGuildGeneral then
    return
  end

  -- obter guild id de forma segura
  local gid = (self.getGuildId and self:getGuildId()) or 0
  if not gid or gid == 0 then
    return
  end

  -- garantir objeto guild válido antes de prosseguir
  local g = Game.getGuild and Game.getGuild(gid) or nil
  if not g then
    return
  end

  -- chamada protegida da função original
  return _orig_fetchGuildGeneral(self, ...)
end
