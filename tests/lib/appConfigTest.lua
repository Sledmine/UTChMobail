------------------------------------------------------------------------------
-- App config library module test
-- Author: Gelatinoso
-- Test collection for app config
------------------------------------------------------------------------------
local lu = require("luaunit")
local glue = require("glue")
local inspect = require("inspect")

-- Modules to import
appConfig = require("lib.appConfig")

-- Prepare tests collection
test_AppConfig = {}

-- On first test run set up
function test_AppConfig:setUp()
    self.expectedSpecificSettings = {
        userName = "test",
        password = "123",
        autoLogin = false
    }
end

-- Test app config set method result
function test_AppConfig:test_set()
    local config = self.expectedSpecificSettings
    local result = appConfig.set(config)
    -- Remove settings file
    os.remove("settings.json")
    lu.assertEquals(result, true)
end

-- Test app config get default config case
function test_AppConfig:test_getDefaultCase()
    local config = appConfig.get()
    lu.assertEquals(config, {userName = nil, password = nil})
end

-- Test app config get specific config case
function test_AppConfig:test_getSpecificCase()
    appConfig.set(self.expectedSpecificSettings)
    local config = appConfig.get()
    lu.assertEquals(config, self.expectedSpecificSettings)
end

local function runTests()
    local runner = lu.LuaUnit.new()
    runner:runSuite()
end

if (not arg) then
    return runTests
else
    runTests()
end
