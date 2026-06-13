PhobosFS25 = PhobosFS25 or {}
PhobosFS25.ModSettings = PhobosFS25.ModSettings or {}

local function ensureTrailingSlash(path)
    if path == nil or path == "" then
        return nil
    end

    local last = string.sub(path, -1)
    if last == "/" or last == "\\" then
        return path
    end

    return path .. "/"
end

function PhobosFS25.ModSettings.getDirectory(modName, baseDirectory)
    if baseDirectory ~= nil and baseDirectory ~= "" then
        return ensureTrailingSlash(baseDirectory)
    end

    if g_currentModSettingsDirectory ~= nil and g_currentModSettingsDirectory ~= "" then
        return ensureTrailingSlash(g_currentModSettingsDirectory)
    end

    if g_modSettingsDirectory ~= nil and g_modSettingsDirectory ~= "" and modName ~= nil and modName ~= "" then
        return ensureTrailingSlash(g_modSettingsDirectory .. tostring(modName))
    end

    return nil
end

function PhobosFS25.ModSettings.ensureDirectory(modName, baseDirectory)
    local directory = PhobosFS25.ModSettings.getDirectory(modName, baseDirectory)
    if directory ~= nil and createFolder ~= nil then
        createFolder(directory)
    end

    return directory
end

function PhobosFS25.ModSettings.buildPath(modName, fileName, baseDirectory)
    if fileName == nil or fileName == "" then
        return nil
    end

    local directory = PhobosFS25.ModSettings.getDirectory(modName, baseDirectory)
    if directory == nil then
        return nil
    end

    return directory .. tostring(fileName)
end

function PhobosFS25.ModSettings.buildXmlPath(modName, fileName, baseDirectory)
    local normalized = tostring(fileName or "settings.xml")
    if string.sub(normalized, -4) ~= ".xml" then
        normalized = normalized .. ".xml"
    end

    return PhobosFS25.ModSettings.buildPath(modName, normalized, baseDirectory)
end
