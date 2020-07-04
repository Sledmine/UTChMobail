------------------------------------------------------------------------------
-- UTCh Virtual Test
-- Author: Sledmine
-- Tests for utchVirtual module functions
------------------------------------------------------------------------------
local lu = require("luaunit")
local glue = require("glue")
local inspect = require("inspect")

-- Modules
local utchVirtual = require("lib.utchVirtual")

-- Entities
local Task = require("entities.task")
local HTTPEvent = require("entities.httpEvent")

test_UtchVirtual = {}

function test_UtchVirtual:setUp()
    self.expectedToken = "yWcULcLYiAXMx3HknS6F1xB2xsi4yvDU"
    self.expectedEmptyTasks = {}
    self.expectedTasks = {
        secondTask = {
            title = "Ensayo de investigación",
            date = "Martes 07/07/2020 a las 17:00 UTC",
            link = "http://virtual.utch.edu.mx/mod/assign/view.php?id=71376"
        },
        firstTask = {
            title = "III.2. Desarrollo de base de datos con transacciones (30%)",
            date = "Domingo 05/07/2020 a las 21:12 UTC",
            link = "http://virtual.utch.edu.mx/mod/assign/view.php?id=1896"
        }
    }
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
    ---@type HTTPEvent
    local event = HTTPEvent:new(eventData)

    local token = utchVirtual.parsers.parseToken(event)
    lu.assertEquals(token, self.expectedToken)
end

-- Test correct tasks parsing
function test_UtchVirtual:test_parseTasksEmpty()
    -- Event mock data
    local eventData = {
        isError = false,
        response = glue.readfile("tests\\resources\\html\\tasksEmpty.html") or
            system.pathForFile("tests/resources/html/tasksEmpty.html",
                               system.ResourceDirectory)
    }

    -- Create an http event entity
    ---@type HTTPEvent
    local event = HTTPEvent:new(eventData)

    ---@type Task[]
    local tasks = utchVirtual.parsers.parseTasks(event)
    lu.assertEquals(tasks, self.expectedEmptyTasks)
end

-- Test correct tasks parsing
function test_UtchVirtual:test_parseTasksFull()
    -- Event mock data
    local eventData = {
        isError = false,
        response = glue.readfile("tests\\resources\\html\\tasksFull.html") or
            system.pathForFile("tests/resources/html/tasksFull.html",
                               system.ResourceDirectory)
    }

    -- Create an http event entity
    ---@type HTTPEvent
    local event = HTTPEvent:new(eventData)

    ---@type Task[]
    local tasks = utchVirtual.parsers.parseTasks(event)

    ---@type Task
    local firstTask = tasks[1]
    lu.assertEquals(firstTask:getTitle(), self.expectedTasks.firstTask.title)
    lu.assertEquals(firstTask:getDate(), self.expectedTasks.firstTask.date)
    lu.assertEquals(firstTask:getLink(), self.expectedTasks.firstTask.link)

    ---@type Task
    local secondTask = tasks[2]
    lu.assertEquals(secondTask:getTitle(), self.expectedTasks.secondTask.title)
    lu.assertEquals(secondTask:getDate(), self.expectedTasks.secondTask.date)
    lu.assertEquals(secondTask:getLink(), self.expectedTasks.secondTask.link)
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
