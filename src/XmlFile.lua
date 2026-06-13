PhobosFS25 = PhobosFS25 or {}
PhobosFS25.XmlFile = PhobosFS25.XmlFile or {}

local function callMethod(xmlFile, methodName, ...)
    if xmlFile == nil or xmlFile[methodName] == nil then
        return false, nil
    end

    local ok, value = pcall(xmlFile[methodName], xmlFile, ...)
    return ok, value
end

local function coerceBool(value, defaultValue)
    if value == nil then
        return defaultValue
    end

    if type(value) == "boolean" then
        return value
    end

    if type(value) == "number" then
        return value ~= 0
    end

    local normalized = string.lower(tostring(value))
    if normalized == "true" or normalized == "1" or normalized == "yes" then
        return true
    end
    if normalized == "false" or normalized == "0" or normalized == "no" then
        return false
    end

    return defaultValue
end

function PhobosFS25.XmlFile.load(label, filename, schema)
    if XMLFile == nil or XMLFile.load == nil or filename == nil then
        return nil
    end

    return XMLFile.load(label or "PhobosFS25XmlFile", filename, schema)
end

function PhobosFS25.XmlFile.loadIfExists(label, filename, schema)
    if XMLFile == nil or XMLFile.loadIfExists == nil or filename == nil then
        return nil
    end

    return XMLFile.loadIfExists(label or "PhobosFS25XmlFile", filename, schema)
end

function PhobosFS25.XmlFile.create(label, filename, rootKey, schema)
    if XMLFile == nil or XMLFile.create == nil or filename == nil or rootKey == nil then
        return nil
    end

    return XMLFile.create(label or "PhobosFS25XmlFile", filename, rootKey, schema)
end

function PhobosFS25.XmlFile.hasProperty(xmlFile, key)
    local ok, value = callMethod(xmlFile, "hasProperty", key)
    return ok and value == true
end

function PhobosFS25.XmlFile.getString(xmlFile, key, defaultValue)
    local ok, value = callMethod(xmlFile, "getString", key, defaultValue)
    if ok and value ~= nil then
        return value
    end

    ok, value = callMethod(xmlFile, "getValue", key, defaultValue)
    if ok and value ~= nil then
        return tostring(value)
    end

    return defaultValue
end

function PhobosFS25.XmlFile.getInt(xmlFile, key, defaultValue)
    local ok, value = callMethod(xmlFile, "getInt", key, defaultValue)
    if ok and value ~= nil then
        return value
    end

    ok, value = callMethod(xmlFile, "getValue", key, defaultValue)
    value = ok and value or nil
    value = tonumber(value)

    return value ~= nil and math.floor(value) or defaultValue
end

function PhobosFS25.XmlFile.getFloat(xmlFile, key, defaultValue)
    local ok, value = callMethod(xmlFile, "getFloat", key, defaultValue)
    if ok and value ~= nil then
        return value
    end

    ok, value = callMethod(xmlFile, "getValue", key, defaultValue)
    value = ok and value or nil
    value = tonumber(value)

    return value ~= nil and value or defaultValue
end

function PhobosFS25.XmlFile.getBool(xmlFile, key, defaultValue)
    local ok, value = callMethod(xmlFile, "getBool", key, defaultValue)
    if ok and value ~= nil then
        return value == true
    end

    ok, value = callMethod(xmlFile, "getValue", key, defaultValue)
    return coerceBool(ok and value or nil, defaultValue)
end

function PhobosFS25.XmlFile.setString(xmlFile, key, value)
    if value == nil then
        return false
    end

    local ok = callMethod(xmlFile, "setString", key, tostring(value))
    if ok then
        return true
    end

    ok = callMethod(xmlFile, "setValue", key, tostring(value))
    return ok
end

function PhobosFS25.XmlFile.setInt(xmlFile, key, value)
    if value == nil then
        return false
    end

    local ok = callMethod(xmlFile, "setInt", key, value)
    if ok then
        return true
    end

    ok = callMethod(xmlFile, "setValue", key, value)
    return ok
end

function PhobosFS25.XmlFile.setFloat(xmlFile, key, value)
    if value == nil then
        return false
    end

    local ok = callMethod(xmlFile, "setFloat", key, value)
    if ok then
        return true
    end

    ok = callMethod(xmlFile, "setValue", key, value)
    return ok
end

function PhobosFS25.XmlFile.setBool(xmlFile, key, value)
    if value == nil then
        return false
    end

    local ok = callMethod(xmlFile, "setBool", key, value == true)
    if ok then
        return true
    end

    ok = callMethod(xmlFile, "setValue", key, value == true)
    return ok
end

function PhobosFS25.XmlFile.forEachIndexed(xmlFile, keyPattern, callback, maxIterations)
    if xmlFile == nil or keyPattern == nil or callback == nil then
        return 0
    end

    local count = 0
    local limit = maxIterations or 10000

    for index = 0, limit - 1 do
        local key = string.format(keyPattern, index)
        if not PhobosFS25.XmlFile.hasProperty(xmlFile, key) then
            break
        end

        callback(xmlFile, key, index)
        count = count + 1
    end

    return count
end

function PhobosFS25.XmlFile.iterate(xmlFile, key, callback, maxIterations)
    if xmlFile == nil or key == nil or callback == nil or xmlFile.iterate == nil then
        return 0
    end

    local count = 0
    local limit = maxIterations or 10000

    xmlFile:iterate(key, function(...)
        if count >= limit then
            return
        end

        count = count + 1
        callback(...)
    end)

    return count
end

function PhobosFS25.XmlFile.save(xmlFile)
    local ok = callMethod(xmlFile, "save")
    return ok
end

function PhobosFS25.XmlFile.delete(xmlFile)
    local ok = callMethod(xmlFile, "delete")
    return ok
end

function PhobosFS25.XmlFile.saveAndDelete(xmlFile)
    if xmlFile == nil then
        return false
    end

    local saved = PhobosFS25.XmlFile.save(xmlFile)
    PhobosFS25.XmlFile.delete(xmlFile)
    return saved
end
