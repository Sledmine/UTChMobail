local composer = require("composer")
local widget = require("widget")

local color = require("lua-color-converter")
local styles = require("styles.colors")

-- Import application components

local scene = composer.newScene()

function scene:create(event)
    local sceneGroup = self.view
    local sceneParams = event.params

    -- Create background
    local background = display.newRect(display.contentCenterX,
                                       display.contentCenterY,
                                       display.actualContentWidth,
                                       display.actualContentHeight)
    background:setFillColor(styles.plain.white)
    sceneGroup:insert(background)

    -- Creation of the tableView containing the student tasks
    local function onRowRender(event)
        local row = event.row
        local rowParams = event.row.params

        ---@type Task
        local studentTask = rowParams.studentTask

        local rowHeight = row.actualContentHeight
        local rowWidth = row.actualContentWidth

        local taskTitle = studentTask:getTitle()
        -- after the x and y params, we can define the limits of the text
        local rowTaskTitle = display.newText(row, taskTitle,
                                             display.contentCenterX, 20,
                                             display.actualContentWidth - 30,
                                             60, nil, 16)
        rowTaskTitle:setFillColor(0)
        rowTaskTitle.anchorX = 0
        rowTaskTitle.anchorY = 0
        rowTaskTitle.x = 20
        rowTaskTitle.y = 20
    end

    -- table view options
    local tableView = widget.newTableView(
                          {
            x = display.contentCenterX,
            y = display.contentCenterY,
            width = display.actualContentWidth,
            heigth = display.actualContentHeight,
            onRowRender = onRowRender,
            hideBackground = true
        })
    sceneGroup:insert(tableView)

    -- in this section we can change the individual row options}
    local studentTasks = sceneParams.studentTasks
    if (studentTasks and #studentTasks > 0) then
        for studentTaskIndex, studentTask in pairs(studentTasks) do
            tableView:insertRow{
                rowColor = {default = {styles.plain.white}},
                rowHeight = 150,
                params = {studentTask = studentTask}
            }
        end
    else
        local noTasks = display.newText("No hay tareas que mostrar.",
                                        display.contentCenterX,
                                        display.contentCenterY,
                                        native.systemFont, 16)
        noTasks:setFillColor(0,0,0)
        sceneGroup:insert(noTasks)
    end

    -- Show application tab bar
    ApplicationTabBar:toFront()
    ApplicationTabBar.isVisible = true
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
