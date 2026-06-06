PhobosFS25 = PhobosFS25 or {}
PhobosFS25.Logging = PhobosFS25.Logging or {}

local function write(level, message)
    local text = string.format("[PhobosFS25][%s] %s", level, tostring(message))

    if print ~= nil then
        print(text)
    end
end

function PhobosFS25.Logging.info(message)
    write("INFO", message)
end

function PhobosFS25.Logging.warn(message)
    write("WARN", message)
end

function PhobosFS25.Logging.error(message)
    write("ERROR", message)
end

