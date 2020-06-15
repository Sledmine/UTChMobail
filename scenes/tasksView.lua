local composer = require( "composer" )
local color = require("convertcolor")
local widget = require("widget")

local scene = composer.newScene()

function scene:create( event )
    local sceneGroup = self.view

    background = display.newImageRect("img/background.png", display.actualContentWidth, display.actualContentHeight)
    background.x = display.contentCenterX
    background.y = display.contentCenterY

    local cards = {1,2,3,4,5,6}

    -- Creation of the tableView containing the student tasks
    local function onRowRender(event)
        local row = event.row
        local rowHeight = row.actualContentHeight
        local rowWidth = row.actualContentWidth

        local rowInfo = display.newText( row, "Tarea " .. row.index, 0, 0, nil, 16 )
        rowInfo:setFillColor( 0 )
        rowInfo.anchorX = 0
        rowInfo.x = 20
        rowInfo.y = 20
    end

    local tableView = widget.newTableView({
        x = display.contentCenterX,
        y = display.contentCenterY,
        width = display.actualContentWidth,
        heigth = display.actualContentHeight,
        onRowRender = onRowRender,
        hideBackground = true
    })

    for i = 1, #cards do
        tableView:insertRow{
            rowColor = { default={color.hex("FDF4FE")}},
            rowHeight = 150
        }
    end

end
 
 
-- show()
function scene:show( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        -- Code here runs when the scene is still off screen (but is about to come on screen)
 
    elseif ( phase == "did" ) then
        -- Code here runs when the scene is entirely on screen
 
    end
end
 
 
-- hide()
function scene:hide( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        -- Code here runs when the scene is on screen (but is about to go off screen)
 
    elseif ( phase == "did" ) then
        -- Code here runs immediately after the scene goes entirely off screen
 
    end
end
 
 
-- destroy()
function scene:destroy( event )
 
    local sceneGroup = self.view
    -- Code here runs prior to the removal of scene's view
 
end
 
 
-- -----------------------------------------------------------------------------------
-- Scene event function listeners
-- -----------------------------------------------------------------------------------
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
-- -----------------------------------------------------------------------------------
 
return scene
