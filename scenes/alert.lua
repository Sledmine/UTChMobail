------------------------------------------------------------------------------
-- Alert
-- Author: Gelatinoso
-- Alert screen for showing warning and error messages
------------------------------------------------------------------------------
local composer = require("composer")
local display = require("display")

local color = require("lua-color-converter")
local styles = require("styles.colors")

local Button = require("components.button")

local scene = composer.newScene()

function scene:create(event)
    local sceneGroup = self.view
    local sceneParams = event.params or {}

    local isSuccess = sceneParams.isSuccess
    local message = sceneParams.message or "No hay texto para mostrar"

    -- Create background
    local background = display.newRect(display.contentCenterX, display.contentCenterY,
                                       display.actualContentWidth, display.actualContentHeight)
    background:setFillColor(color.hex(styles.plain.white))
    sceneGroup:insert(background)

    local details = display.newImageRect("img/background.png", display.actualContentWidth,
                                         display.actualContentHeight)
    details.x = display.contentCenterX
    details.y = display.contentCenterY
    sceneGroup:insert(details)

    local iconImage = "img/icons/error.png"

    if (isSuccess) then
        iconImage = "img/icons/success.png"
    end

    local iconBackground = display.newCircle(display.contentCenterX, display.contentCenterY - 100,
                                             75)
    sceneGroup:insert(iconBackground)

    local statusIcon = display.newImageRect(iconImage, 100, 100)
    statusIcon:translate(iconBackground.x, iconBackground.y)
    sceneGroup:insert(statusIcon)

    local textBackground = display.newRoundedRect(iconBackground.x, iconBackground.y + 150,
                                                  display.actualContentWidth - 50, 80, 8)
    sceneGroup:insert(textBackground)

    local statusText = display.newText({
        text = message,
        font = native.systemFont,
        fontSize = 24,
        align = "center",
        width = textBackground.width,
        x = textBackground.x,
        y = textBackground.y,
    })
    statusText:setFillColor(styles.plain.gray)
    sceneGroup:insert(statusText)

    local backButton = Button(textBackground.x, textBackground.y + textBackground.height + 10,
                              "Volver al inicio de sesión", "backButton",
                              {
        styles.composed.white,
        styles.composed.green,
    }, function(event)
        if (event.phase == "ended") then
            sceneController.setPreviousScene()
        end
    end)
    sceneGroup:insert(backButton)
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
