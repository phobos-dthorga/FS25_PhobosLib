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

