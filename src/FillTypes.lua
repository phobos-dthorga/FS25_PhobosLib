PhobosFS25 = PhobosFS25 or {}
PhobosFS25.FillTypes = PhobosFS25.FillTypes or {}

function PhobosFS25.FillTypes.getIndex(fillTypeName)
    if fillTypeName == nil or g_fillTypeManager == nil then
        return nil
    end

    if g_fillTypeManager.getFillTypeIndexByName == nil then
        return nil
    end

    return g_fillTypeManager:getFillTypeIndexByName(fillTypeName)
end

function PhobosFS25.FillTypes.getIndexByName(fillTypeName)
    return PhobosFS25.FillTypes.getIndex(fillTypeName)
end

function PhobosFS25.FillTypes.exists(fillTypeName)
    return PhobosFS25.FillTypes.getIndex(fillTypeName) ~= nil
end

function PhobosFS25.FillTypes.requireIndex(fillTypeName, caller)
    local index = PhobosFS25.FillTypes.getIndex(fillTypeName)
    if index ~= nil then
        return index
    end

    if PhobosFS25.Logging ~= nil then
        PhobosFS25.Logging.warnSource(caller or "FillTypes", "Fill type is not available: %s", tostring(fillTypeName))
    end

    return nil
end
