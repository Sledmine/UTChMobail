------------------------------------------------------------------------------
-- Lib Test Name Here
-- Author: Your Name here
-- Shor lib test description
------------------------------------------------------------------------------
local lu = require("luaunit")
local glue = require("glue")
local inspect = require("inspect")

-- Modules to import
myModule = require("myModule")

-- Prepare tests collection
test_MyModule = {}


-- On first test run set up
function test_MyModule:setUp()
    self.utilOrExpectedValue = expected
end

-- Test some lib feature
function test_MyModule:test_myFeature()
    lu.assertEquals(current, expected)
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
