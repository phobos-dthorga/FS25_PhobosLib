local repoRoot = arg ~= nil and arg[1] or "."

local function source(path)
    dofile(repoRoot .. "/" .. path)
end

local function assertEquals(expected, actual, message)
    if expected ~= actual then
        error(string.format("%s: expected '%s', got '%s'", message or "assertEquals", tostring(expected), tostring(actual)), 2)
    end
end

local function assertTrue(value, message)
    if value ~= true then
        error(message or "assertTrue failed", 2)
    end
end

local function assertFalse(value, message)
    if value ~= false then
        error(message or "assertFalse failed", 2)
    end
end

source("src/PhobosFS25.lua")
source("src/Logging.lua")
source("src/I18n.lua")
source("src/ModSettings.lua")
source("src/XmlFile.lua")

assertEquals("0.1.2.0", PhobosFS25.getVersion(), "version should be updated")

local printed = {}
local originalPrint = print
print = function(line)
    printed[#printed + 1] = line
end

PhobosFS25.Logging.resetOnceCache()
assertTrue(PhobosFS25.Logging.warnOnceSource("Smoke", "Repeated %s", "line"), "first once log should write")
assertFalse(PhobosFS25.Logging.warnOnceSource("Smoke", "Repeated %s", "line"), "second once log should be skipped")
assertEquals(1, #printed, "once logging should emit one line")
PhobosFS25.Logging.resetOnceCache()
assertTrue(PhobosFS25.Logging.warnOnceSource("Smoke", "Repeated %s", "line"), "reset should allow logging again")
print = originalPrint

g_i18n = {
    modEnvironments = {
        TestMod = {
            texts = {
                hello = "Hallo %s",
            },
        },
    },
    getText = function(_, key)
        if key == "global_key" then
            return "Global %s"
        end
        return key
    end,
}

assertEquals("Hallo Welt", PhobosFS25.I18n.get("TestMod", "hello", "Hello %s", "Welt"), "mod environment translation should win")
assertEquals("Global Text", PhobosFS25.I18n.get("TestMod", "global_key", "Fallback %s", "Text"), "global translation should be used")
assertEquals("Fallback Text", PhobosFS25.I18n.get("TestMod", "missing_key", "Fallback %s", "Text"), "fallback should format")

g_currentModSettingsDirectory = nil
g_modSettingsDirectory = "settings/"
local createdDirectory = nil
createFolder = function(path)
    createdDirectory = path
end

assertEquals("settings/TestMod/", PhobosFS25.ModSettings.getDirectory("TestMod"), "settings directory should use global settings root")
assertEquals("settings/TestMod/settings.xml", PhobosFS25.ModSettings.buildXmlPath("TestMod"), "default settings XML path should resolve")
assertEquals("settings/TestMod/custom.xml", PhobosFS25.ModSettings.buildXmlPath("TestMod", "custom"), "xml extension should be appended")
assertEquals("settings/TestMod/", PhobosFS25.ModSettings.ensureDirectory("TestMod"), "ensure directory should return path")
assertEquals("settings/TestMod/", createdDirectory, "ensure directory should call createFolder")

local FakeXml = {}
FakeXml.__index = FakeXml

function FakeXml.new(values)
    return setmetatable({values = values or {}, saved = false, deleted = false}, FakeXml)
end

function FakeXml:getValue(key, defaultValue)
    local value = self.values[key]
    if value == nil then
        return defaultValue
    end
    return value
end

function FakeXml:getBool(key, defaultValue)
    local value = self.values[key]
    if value == nil then
        return defaultValue
    end
    return value == true
end

function FakeXml:setValue(key, value)
    self.values[key] = value
end

function FakeXml:setBool(key, value)
    self.values[key] = value == true
end

function FakeXml:hasProperty(key)
    return self.values[key] ~= nil
end

function FakeXml:iterate(key, callback)
    local index = 0
    while self.values[string.format("%s(%d)#id", key, index)] ~= nil do
        callback(self, string.format("%s(%d)", key, index))
        index = index + 1
    end
end

function FakeXml:save()
    self.saved = true
end

function FakeXml:delete()
    self.deleted = true
end

local createdXml = nil
XMLFile = {
    loadIfExists = function(label, filename)
        return FakeXml.new({["root#enabled"] = true, ["root.item(0)#id"] = "a", ["root.item(1)#id"] = "b"})
    end,
    create = function(label, filename, rootKey)
        createdXml = FakeXml.new({[rootKey] = true})
        return createdXml
    end,
}

local xmlFile = PhobosFS25.XmlFile.loadIfExists("Smoke", "settings.xml")
assertTrue(PhobosFS25.XmlFile.getBool(xmlFile, "root#enabled", false), "bool getter should read XMLFile object")
assertEquals("fallback", PhobosFS25.XmlFile.getString(xmlFile, "root#missing", "fallback"), "string getter should use fallback")
assertTrue(PhobosFS25.XmlFile.setString(xmlFile, "root#name", "Phobos"), "string setter should work")
assertEquals("Phobos", xmlFile.values["root#name"], "string setter should update fake XML")

local indexed = 0
PhobosFS25.XmlFile.forEachIndexed(xmlFile, "root.item(%d)#id", function(_, _, index)
    indexed = indexed + index + 1
end, 4)
assertEquals(3, indexed, "bounded indexed iteration should visit existing indexed rows")

local iterated = 0
PhobosFS25.XmlFile.iterate(xmlFile, "root.item", function()
    iterated = iterated + 1
end, 1)
assertEquals(1, iterated, "iterate callback should respect the callback cap")

local newXml = PhobosFS25.XmlFile.create("Smoke", "settings.xml", "root")
assertEquals(createdXml, newXml, "create should return XMLFile object")
assertTrue(PhobosFS25.XmlFile.saveAndDelete(newXml), "saveAndDelete should report save success")
assertTrue(newXml.saved, "saveAndDelete should save")
assertTrue(newXml.deleted, "saveAndDelete should delete")

print("PhobosLib smoke tests passed.")
