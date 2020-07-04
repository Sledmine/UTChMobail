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
    self.expectedSettings = {
        userName = "test",
        password = "123"
    }
end

-- Test some lib feature
function test_AppConfig:test_set()
    local config = self.expectedSettings
    local result = appConfig.set(config)
    lu.assertEquals(result, true)
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
