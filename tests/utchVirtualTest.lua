------------------------------------------------------------------------------
-- UTCh Virtual Test
-- Author: Sledmine
-- Tests for utchVirtual module functions
------------------------------------------------------------------------------
local lu = require("luaunit")
local glue = require("glue")

-- Modules
local utchVirtual = require("lib.utchVirtual")

-- Entities
local httpEvent = require("entities.httpEvent")

test_UtchVirtual = {}

function test_UtchVirtual:setUp()
    self.expectedToken = "yWcULcLYiAXMx3HknS6F1xB2xsi4yvDU"
end

-- Test correct token parsing
function test_UtchVirtual:test_parseToken()
    -- Event mock data
    local eventData = {
        isError = false,
        response = glue.readfile("tests\\resources\\html\\token.html") or
            system.pathForFile("tests/resources/html/token.html",
                               system.ResourceDirectory)
    }

    -- Create an http event entity
    ---@type httpEvent
    local event = httpEvent:new(eventData)

    local token = utchVirtual.parsers.parseToken(event)
    lu.assertEquals(token, self.expectedToken)
end

-- Test correct cookie parsing
function test_UtchVirtual:test_parseCookie()
    -- Event mock data
    local eventData = {
        isError = false,
        response = glue.readfile("tests\\resources\\html\\token.html") or
            system.pathForFile("tests/resources/html/token.html",
                               system.ResourceDirectory)
    }

    -- Create an http event entity
    ---@type httpEvent
    local event = httpEvent:new(eventData)

    local token = utchVirtual.parsers.parseToken(event)
    lu.assertEquals(token, self.expectedToken)
end

-- Test correct tasks parsing
function test_UtchVirtual:test_parseTasks()
    -- Event mock data
    local eventData = {
        isError = false,
        response = glue.readfile("tests\\resources\\html\\token.html") or
            system.pathForFile("tests/resources/html/token.html",
                               system.ResourceDirectory)
    }

    -- Create an http event entity
    ---@type httpEvent
    local event = httpEvent:new(eventData)

    local token = utchVirtual.parsers.parseToken(event)
    lu.assertEquals(token, self.expectedToken)
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
