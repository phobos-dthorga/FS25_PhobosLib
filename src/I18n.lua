PhobosFS25 = PhobosFS25 or {}
PhobosFS25.I18n = PhobosFS25.I18n or {}

local function formatText(text, ...)
    if select("#", ...) == 0 then
        return tostring(text or "")
    end

    local ok, formatted = pcall(string.format, tostring(text or ""), ...)
    if ok then
        return formatted
    end

    return tostring(text or "")
end

local function getModEnvironmentText(modName, key)
    if modName == nil or g_i18n == nil or g_i18n.modEnvironments == nil then
        return nil
    end

    local modEnvironment = g_i18n.modEnvironments[modName]
    if modEnvironment == nil or modEnvironment.texts == nil then
        return nil
    end

    return modEnvironment.texts[key]
end

local function getGlobalText(key)
    if g_i18n == nil or g_i18n.getText == nil then
        return nil
    end

    local ok, value = pcall(function()
        return g_i18n:getText(key)
    end)

    if not ok or value == nil or value == "" or value == key then
        return nil
    end

    return value
end

function PhobosFS25.I18n.get(modName, key, fallback, ...)
    local value = getModEnvironmentText(modName, key) or getGlobalText(key) or fallback or key

    return formatText(value, ...)
end
