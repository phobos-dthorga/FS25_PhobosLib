PhobosFS25 = PhobosFS25 or {}
PhobosFS25.Xml = PhobosFS25.Xml or {}

function PhobosFS25.Xml.hasProperty(xmlFile, key)
    if xmlFile == nil or key == nil or hasXMLProperty == nil then
        return false
    end

    return hasXMLProperty(xmlFile, key) == true
end

function PhobosFS25.Xml.getString(xmlFile, key, defaultValue)
    if xmlFile == nil or key == nil or getXMLString == nil then
        return defaultValue
    end

    local value = getXMLString(xmlFile, key)
    if value == nil then
        return defaultValue
    end

    return value
end

function PhobosFS25.Xml.getInt(xmlFile, key, defaultValue)
    if xmlFile == nil or key == nil or getXMLInt == nil then
        return defaultValue
    end

    local value = getXMLInt(xmlFile, key)
    if value == nil then
        return defaultValue
    end

    return value
end

function PhobosFS25.Xml.getFloat(xmlFile, key, defaultValue)
    if xmlFile == nil or key == nil or getXMLFloat == nil then
        return defaultValue
    end

    local value = getXMLFloat(xmlFile, key)
    if value == nil then
        return defaultValue
    end

    return value
end

function PhobosFS25.Xml.getBool(xmlFile, key, defaultValue)
    if xmlFile == nil or key == nil or getXMLBool == nil then
        return defaultValue
    end

    local value = getXMLBool(xmlFile, key)
    if value == nil then
        return defaultValue
    end

    return value
end

function PhobosFS25.Xml.setString(xmlFile, key, value)
    if xmlFile == nil or key == nil or value == nil or setXMLString == nil then
        return false
    end

    setXMLString(xmlFile, key, tostring(value))
    return true
end

function PhobosFS25.Xml.setInt(xmlFile, key, value)
    if xmlFile == nil or key == nil or value == nil or setXMLInt == nil then
        return false
    end

    setXMLInt(xmlFile, key, value)
    return true
end

function PhobosFS25.Xml.setFloat(xmlFile, key, value)
    if xmlFile == nil or key == nil or value == nil or setXMLFloat == nil then
        return false
    end

    setXMLFloat(xmlFile, key, value)
    return true
end

function PhobosFS25.Xml.setBool(xmlFile, key, value)
    if xmlFile == nil or key == nil or value == nil or setXMLBool == nil then
        return false
    end

    setXMLBool(xmlFile, key, value == true)
    return true
end

function PhobosFS25.Xml.forEachIndexed(xmlFile, keyPattern, callback, maxIterations)
    if xmlFile == nil or keyPattern == nil or callback == nil then
        return 0
    end

    local count = 0
    local limit = maxIterations or 10000

    for index = 0, limit - 1 do
        local key = string.format(keyPattern, index)
        if not PhobosFS25.Xml.hasProperty(xmlFile, key) then
            break
        end

        callback(xmlFile, key, index)
        count = count + 1
    end

    return count
end
