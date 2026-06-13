PhobosFS25 = PhobosFS25 or {}
PhobosFS25.Logging = PhobosFS25.Logging or {}

local onceKeys = {}

local function formatMessage(message, ...)
    if select("#", ...) == 0 then
        return tostring(message)
    end

    local ok, formatted = pcall(string.format, tostring(message), ...)
    if ok then
        return formatted
    end

    return tostring(message)
end

local function writeFormatted(level, source, text)
    local sourcePart = ""
    if source ~= nil and tostring(source) ~= "" then
        sourcePart = string.format("[%s]", tostring(source))
    end

    text = string.format("[PhobosFS25][%s]%s %s", level, sourcePart, tostring(text or ""))

    if print ~= nil then
        print(text)
    end
end

local function write(level, source, message, ...)
    writeFormatted(level, source, formatMessage(message, ...))
end

local function writeOnce(level, source, message, ...)
    local formatted = formatMessage(message, ...)
    local key = string.format("%s|%s|%s", tostring(level or "INFO"), tostring(source or ""), formatted)

    if onceKeys[key] == true then
        return false
    end

    onceKeys[key] = true
    writeFormatted(level, source, formatted)
    return true
end

function PhobosFS25.Logging.write(level, source, message, ...)
    write(tostring(level or "INFO"), source, message, ...)
end

function PhobosFS25.Logging.info(message, ...)
    write("INFO", nil, message, ...)
end

function PhobosFS25.Logging.warn(message, ...)
    write("WARN", nil, message, ...)
end

function PhobosFS25.Logging.error(message, ...)
    write("ERROR", nil, message, ...)
end

function PhobosFS25.Logging.infoSource(source, message, ...)
    write("INFO", source, message, ...)
end

function PhobosFS25.Logging.warnSource(source, message, ...)
    write("WARN", source, message, ...)
end

function PhobosFS25.Logging.errorSource(source, message, ...)
    write("ERROR", source, message, ...)
end

function PhobosFS25.Logging.infoOnceSource(source, message, ...)
    return writeOnce("INFO", source, message, ...)
end

function PhobosFS25.Logging.warnOnceSource(source, message, ...)
    return writeOnce("WARN", source, message, ...)
end

function PhobosFS25.Logging.errorOnceSource(source, message, ...)
    return writeOnce("ERROR", source, message, ...)
end

function PhobosFS25.Logging.resetOnceCache()
    onceKeys = {}
end
