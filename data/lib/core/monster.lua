function Monster.getStorageValue(self, key)
    local storageMap = MONSTER_STORAGE[self:getId()]
    if storageMap then
        return storageMap[key] or -1
    end
    return -1
end

function Monster.setStorageValue(self, key, value)
    local cid = self:getId()
    local storageMap = MONSTER_STORAGE[cid]
    if not storageMap then
        MONSTER_STORAGE[cid] = {[key] = value}
    else
        storageMap[key] = value
    end
end

function Monster.isSummon(self)
    if self:getMaster() then
        return true
    end
    return false
end