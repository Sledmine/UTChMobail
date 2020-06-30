local composer = require("composer")
local display = require("display")

local color = require("lua-color-converter")

local scene = composer.newScene()

function scene:create(event)
    local sceneGroup = self.view
    -- this flag is related if the user fails to login
    local isErrorLogin = false
    local textOptions = {}
    local statusIcon

    local iconBackground = display.newCircle(display.contentCenterX,
                                             display.contentCenterY - 100, 75)

    -- conditional to set the status icons on screen
    if (isErrorLogin) then
        statusIcon = display.newImageRect(iconBackground, "img/cerrar.png", 100,
                                          100)
        statusIcon:translate(iconBackground.x, iconBackground.y)

        textOptions = {
            text = "Hola, soy un texto y yo: falle en logear",
            font = native.systemFont,
            fontSize = 24,
            align = "center",
            width = display.actualContentWidth - 60,
            x = iconBackground.x,
            y = iconBackground.y + 150
        }

    else
        statusIcon = display.newImageRect(iconBackground, "img/comprobar.png",
                                          100, 100)
        statusIcon:translate(iconBackground.x + 5, iconBackground.y)

        textOptions = {
            text = "Hola, soy un texto y yo: inicie sesion",
            font = native.systemFont,
            fontSize = 24,
            align = "center",
            width = display.actualContentWidth - 60,
            x = iconBackground.x,
            y = iconBackground.y + 150
        }

    end

    local statusText = display.newText(textOptions)
    statusText:setFillColor(color.hex("#000000"))

    local textBackground = display.newRoundedRect(statusText.x, statusText.y,
                                                  statusText.width + 10, 80, 8)

    sceneGroup:insert(iconBackground)
    sceneGroup:insert(textBackground)
    sceneGroup:insert(statusText)

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
