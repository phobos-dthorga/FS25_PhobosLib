PhobosFS25 = PhobosFS25 or {}
PhobosFS25.Logging = PhobosFS25.Logging or {}

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

local function write(level, source, message, ...)
    local sourcePart = ""
    if source ~= nil and tostring(source) ~= "" then
        sourcePart = string.format("[%s]", tostring(source))
    end

    local text = string.format("[PhobosFS25][%s]%s %s", level, sourcePart, formatMessage(message, ...))

    if print ~= nil then
        print(text)
    end
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
