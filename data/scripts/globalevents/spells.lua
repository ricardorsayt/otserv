local globalevent = GlobalEvent("Register Spells")

local function explodeString(str, delimiter)
    local result = {}
    local pattern = string.format("([^%s]+)", delimiter)
    str:gsub(pattern, function(token) result[#result + 1] = token end)
    return result
end

local function mergeSpellWords(words)
    local str = explodeString(words, ",")
    local merged = table.concat(str)
    return merged
end

local function capitalizeWords(str)
    return str:gsub("(%w)([%w]*)", function(first, rest)
        return first:upper() .. rest:lower()
    end)
end

function globalevent.onStartup()
    print(">> Starting spell database update process...")
    for _, spell in ipairs(Game.getInstantSpells()) do
        local spellObj = Spell(spell.name)
        local words = capitalizeWords(mergeSpellWords(spellObj:words()))
        local vocations = spellObj:vocation()
        local vocTbl = {}

        for i, vocation in ipairs(vocations) do
            local vocationObj = Vocation(vocation)
            vocTbl[#vocTbl + 1] = math.floor(vocationObj:getId())
        end

        local vocStr = table.concat(vocTbl, ",")
        local premium = spellObj:isPremium() and 1 or 0
        local param = spellObj:hasParams() and 1 or 0
        local learn = spellObj:needLearn() and 1 or 0

        local existingQuery = db.storeQuery("SELECT `id` FROM `web_spells` WHERE `words` = " .. db.escapeString(words))
        if existingQuery ~= false then
            local updateQuery = string.format("UPDATE `web_spells` SET `name` = %s, `category` = %d, `mana` = %d, `mlvl` = %d, `premium` = %d, `vocations` = %s, `param` = %d, `learn` = %d, `updated_at` = NOW() WHERE `words` = %s",
                db.escapeString(spellObj:getName()),
                spellObj:category(),
                spellObj:mana(),
                spellObj:magicLevel(),
                premium,
                db.escapeString(vocStr),
                param,
                learn,
                db.escapeString(words)
            )
            db.query(updateQuery)
        else
            local insertQuery = string.format("INSERT INTO `web_spells` (`name`, `words`, `category`, `mana`, `mlvl`, `premium`, `vocations`, `param`, `learn`, `created_at`, `updated_at`) VALUES (%s, %s, %d, %d, %d, %d, %s, %d, %d, NOW(), NOW())",
                db.escapeString(spellObj:getName()),
                db.escapeString(words),
                spellObj:category(),
                spellObj:mana(),
                spellObj:magicLevel(),
                premium,
                db.escapeString(vocStr),
                param,
                learn
            )
            db.query(insertQuery)
        end

		result.free(existingQuery)
    end
    return true
end



globalevent:register()
