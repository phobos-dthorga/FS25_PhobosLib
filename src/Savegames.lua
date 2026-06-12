PhobosFS25 = PhobosFS25 or {}
PhobosFS25.Savegames = PhobosFS25.Savegames or {}

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

function PhobosFS25.Savegames.getCurrentSavegameDirectory(mission)
    local activeMission = mission or g_currentMission
    if activeMission == nil or activeMission.missionInfo == nil then
        return nil
    end

    local missionInfo = activeMission.missionInfo
    local configuredPath = ensureTrailingSlash(missionInfo.savegameDirectory)
    if configuredPath ~= nil then
        return configuredPath
    end

    if missionInfo.savegameIndex ~= nil and type(getUserProfileAppPath) == "function" then
        return ensureTrailingSlash(string.format("%ssavegame%d", getUserProfileAppPath(), missionInfo.savegameIndex))
    end

    return nil
end

function PhobosFS25.Savegames.buildSavegamePath(fileName, mission)
    if fileName == nil or fileName == "" then
        return nil
    end

    local savegameDirectory = PhobosFS25.Savegames.getCurrentSavegameDirectory(mission)
    if savegameDirectory == nil then
        return nil
    end

    return savegameDirectory .. fileName
end

function PhobosFS25.Savegames.buildSavegameXmlPath(fileName, mission)
    if fileName == nil or fileName == "" then
        return nil
    end

    local normalized = tostring(fileName)
    if string.sub(normalized, -4) ~= ".xml" then
        normalized = normalized .. ".xml"
    end

    return PhobosFS25.Savegames.buildSavegamePath(normalized, mission)
end

function PhobosFS25.Savegames.canUseSavegameXml(mission)
    return PhobosFS25.Savegames.getCurrentSavegameDirectory(mission) ~= nil
end
