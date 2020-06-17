------------------------------------------------------------------------------
-- taskViewTest
-- Author: Sledmine
-- Tests for taskView scene
------------------------------------------------------------------------------
local lu = require("luaunit")
local glue = require("glue")

local Task = require("entities.task")

----------------- Task View Tests -----------------------
test_TaskView = {}

function test_TaskView:setUp()
    ---@type Task[]
    local taskList = {}

    for i = 1, 10 do
        ---@type Task
        local longText =
            "Hi this is a really long long long long long long long long long text"
        local exampleTask = Task:new(longText, '12425', 'google.com')

        -- Add new example task to the list
        glue.append(taskList, exampleTask)
    end

    self.taskList = taskList
end

function test_TaskView:test_Render()
    -- Render new scece with example params
    local options = {params = {studentTasks = self.taskList}}
    sceneController.setScene("scenes.tasksView", options)
end

return function()
    local runner = lu.LuaUnit.new()
    runner:runSuite()
end
