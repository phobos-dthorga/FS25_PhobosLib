PhobosFS25 = PhobosFS25 or {}
PhobosFS25.FillTypes = PhobosFS25.FillTypes or {}

function PhobosFS25.FillTypes.exists(fillTypeName)
    if fillTypeName == nil or g_fillTypeManager == nil then
        return false
    end

    if g_fillTypeManager.getFillTypeIndexByName == nil then
        return false
    end

    return g_fillTypeManager:getFillTypeIndexByName(fillTypeName) ~= nil
end

