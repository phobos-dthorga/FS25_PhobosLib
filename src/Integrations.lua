PhobosFS25 = PhobosFS25 or {}
PhobosFS25.Integrations = PhobosFS25.Integrations or {}

function PhobosFS25.Integrations.isAvailable(modName)
    return PhobosFS25.Mods ~= nil and PhobosFS25.Mods.isLoaded(modName)
end

function PhobosFS25.Integrations.withOptionalMod(modName, callback, ...)
    if not PhobosFS25.Integrations.isAvailable(modName) then
        return false, nil
    end

    if callback == nil then
        return true, nil
    end

    return true, callback(...)
end

function PhobosFS25.Integrations.withRequiredMod(modName, caller, callback, ...)
    if PhobosFS25.Mods == nil or not PhobosFS25.Mods.requireLoaded(modName, caller or "Integrations") then
        return false, nil
    end

    if callback == nil then
        return true, nil
    end

    return true, callback(...)
end
