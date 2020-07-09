------------------------------------------------------------------------------
-- Card to reflect Task entity
-- Author: Sledmine
-- Reusable task row card
------------------------------------------------------------------------------
local color = require("lua-color-converter")
local styles = require("styles.colors")

-- Import sub component
local Button = require("components.button")

local function taskCard(event)
    local row = event.row
    local rowParams = event.row.params

    ---@type Task
    local studentTask = rowParams.studentTask

    local rowHeight = row.actualContentHeight
    local rowWidth = row.actualContentWidth

    local taskTitle = studentTask:getTitle()
    local taskDate = studentTask:getDate()
    -- after the x and y params, we can define the limits of the text
    local rowTaskTitle = display.newText(row, taskTitle, display.contentCenterX, 20,
                                         display.actualContentWidth - 30, 60, nil, 15)
    rowTaskTitle:setFillColor(color.hex(styles.plain.gray))
    rowTaskTitle.anchorX = 0
    rowTaskTitle.anchorY = 0
    rowTaskTitle.x = 47
    rowTaskTitle.y = 20

    local clockIcon = display.newImageRect("img/icons/school/book.png", 28, 28)
    clockIcon.x = rowTaskTitle.x - 20
    clockIcon.y = rowTaskTitle.y + 7
    row:insert(clockIcon)

    local rowTaskDate = display.newText(row, taskDate, display.contentCenterX, 20,
                                        display.actualContentWidth - 30, 60, nil, 15)
    rowTaskDate:setFillColor(color.hex(styles.plain.gray))
    rowTaskDate.anchorX = 0
    rowTaskDate.anchorY = 0
    rowTaskDate.x = 47
    rowTaskDate.y = rowTaskTitle.y + 80

    local clockIcon = display.newImageRect("img/icons/school/clock.png", 28, 28)
    clockIcon.x = rowTaskDate.x - 20
    clockIcon.y = rowTaskDate.y + 7
    row:insert(clockIcon)

    local urlButton = Button(display.contentCenterX, rowTaskDate.y + 70, "Más información",
                             "urlButton", {
        styles.composed.white,
        styles.composed.green,
    }, function(event)
        if (event.phase == "ended") then
            print("Test")
        end
    end)
    row:insert(urlButton)

end

return taskCard
