local composer = require("composer")

local color = require("lua-color-converter")
local styles = require("styles.colors")

-- Import application components
local TaskCard = require("components.taskCard")

local scene = composer.newScene()

function scene:create(event)
    alreadyStarted = true
    local sceneGroup = self.view
    -- Important to set empty table by default
    local sceneParams = event.params or {}

    -- Create background
    local background = display.newRect(display.contentCenterX, display.contentCenterY,
                                       display.actualContentWidth, display.actualContentHeight)
    background:setFillColor(color.hex(styles.plain.semigray))
    sceneGroup:insert(background)

    -- table view options
    local tableView = widget.newTableView({
        left = 0,
        top = 0,
        width = display.actualContentWidth,
        height = display.actualContentHeight - 50,
        hideBackground = true,
        onRowRender = TaskCard,
    })
    sceneGroup:insert(tableView)

    -- Create rows for every task
    local studentTasks = sceneParams.studentTasks
    if (studentTasks and #studentTasks > 0) then
        for studentTaskIndex, studentTask in pairs(studentTasks) do
            tableView:insertRow({
                rowColor = styles.composed.hope,
                rowHeight = 210,
                params = {
                    studentTask = studentTask,
                },
            })
        end
    else
        local noTasksLabel = display.newText("No hay tareas pendientes.", display.contentCenterX,
                                             display.contentCenterY, native.systemFont, 16)
        noTasksLabel:setFillColor(color.hex(styles.plain.gray))
        sceneGroup:insert(noTasksLabel)
    end

    -- Show application tab bar
    ApplicationTabBar:toFront()
    ApplicationTabBar.isVisible = true
    ApplicationTabBar:setSelected(1)
end

-- show()
function scene:show(event)

    local sceneGroup = self.view
    local phase = event.phase

    if (phase == "will") then
        -- Code here runs when the scene is still off screen (but is about to come on screen)

    elseif (phase == "did") then
        -- Code here runs when the scene is entirely on screen

    end
end

-- hide()
function scene:hide(event)

    local sceneGroup = self.view
    local phase = event.phase

    if (phase == "will") then
        -- Code here runs when the scene is on screen (but is about to go off screen)

    elseif (phase == "did") then
        -- Code here runs immediately after the scene goes entirely off screen

    end
end

-- destroy()
function scene:destroy(event)

    local sceneGroup = self.view
    -- Code here runs prior to the removal of scene's view

end

-- -----------------------------------------------------------------------------------
-- Scene event function listeners
-- -----------------------------------------------------------------------------------
scene:addEventListener("create", scene)
scene:addEventListener("show", scene)
scene:addEventListener("hide", scene)
scene:addEventListener("destroy", scene)
-- -----------------------------------------------------------------------------------

return scene
