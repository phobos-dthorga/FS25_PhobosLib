PhobosFS25 = PhobosFS25 or {}
PhobosFS25.Mods = PhobosFS25.Mods or {}

function PhobosFS25.Mods.isLoaded(modName)
    if modName == nil then
        return false
    end

    if g_modIsLoaded ~= nil then
        return g_modIsLoaded[modName] == true
    end

    return false
end

function PhobosFS25.Mods.allLoaded(modNames)
    if modNames == nil then
        return true
    end

    for _, modName in ipairs(modNames) do
        if not PhobosFS25.Mods.isLoaded(modName) then
            return false
        end
    end

    return true
end

function PhobosFS25.Mods.anyLoaded(modNames)
    if modNames == nil then
        return false
    end

    for _, modName in ipairs(modNames) do
        if PhobosFS25.Mods.isLoaded(modName) then
            return true
        end
    end

    return false
end

function PhobosFS25.Mods.requireLoaded(modName, caller)
    if PhobosFS25.Mods.isLoaded(modName) then
        return true
    end

    if PhobosFS25.Logging ~= nil then
        PhobosFS25.Logging.warnSource(caller or "Mods", "Required mod is not loaded: %s", tostring(modName))
    end

    return false
end
