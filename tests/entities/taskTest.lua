------------------------------------------------------------------------------
-- Task entity test
-- Author: Sledmine
-- Tests for task entity
------------------------------------------------------------------------------
local lu = require("luaunit")
local glue = require("glue")

-- Entities
local Task = require("entities.task")

test_TaskEntity = {}

function test_TaskEntity:setUp()
    self.expectedTasks = {
        firstTask = {
            title = "Test Task Title", -- Test Task Title está en fecha de entrega
            date = "Domingo 05/07/2020 a las 21:12 UTC", -- 1594005120
            link = "http://test.com", -- http://test.com
        },
        secondTask = {
            title = "Test Second Task Title", -- Test Second Task Title
            date = "Martes 07/07/2020 a las 17:00 UTC", -- 1594162800
            link = "http://test.com", -- http://test.com
        }
    }
end

-- Test correct entity constructor
function test_TaskEntity:test_TaskConstructor()
    ---@type Task
    local taskInstance = Task:new("Test Task Title está en fecha de entrega",
                                 "1594005120", "http://test.com")
    lu.assertEquals(taskInstance:getTitle(), self.expectedTasks.firstTask.title)
    lu.assertEquals(taskInstance:getDate(), self.expectedTasks.firstTask.date)
    lu.assertEquals(taskInstance:getLink(), self.expectedTasks.firstTask.link)

    local secondTaskInstance  = Task:new("Test Second Task Title",
                                 "1594162800", "http://test.com")
    lu.assertEquals(secondTaskInstance:getTitle(), self.expectedTasks.secondTask.title)
    lu.assertEquals(secondTaskInstance:getDate(), self.expectedTasks.secondTask.date)
    lu.assertEquals(secondTaskInstance:getLink(), self.expectedTasks.secondTask.link)
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
