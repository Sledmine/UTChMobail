------------------------------------------------------------------------------
-- Login
-- Author: Gelatinoso
-- Login scene for UTCh Virtual data
------------------------------------------------------------------------------
local composer = require("composer")
local widget = require("widget")

local utchVirtual = require("lib.utchVirtual")

local scene = composer.newScene()

local backgroundImage
local userInput
local passwordInput
local buttonLogin

---@param studentTasks Task[]
local function tasksCallback(studentTasks)
    local options = {params = {studentTasks = studentTasks}}
    sceneController.setScene("scenes.tasksView", options)
end

local function loginCallback() utchVirtual.getTasks(tasksCallback) end

---@param token string
local function tokenCallback(token)
    if (token) then
        if (userInput.text ~= "" and passwordInput.text ~= "") then
            utchVirtual.login(userInput.text, passwordInput.text, token,
                              loginCallback)
        end
    end
end

function scene:create(event)
    local sceneGroup = self.view

    backgroundImage = display.newImageRect("img/background.png",
                                           display.actualContentWidth,
                                           display.actualContentHeight)
    backgroundImage.x = display.contentCenterX
    backgroundImage.y = display.contentCenterY

    userInput = native.newTextField(display.contentCenterX,
                                    display.contentCenterY - 60,
                                    display.actualContentWidth - 90, 40)
    userInput.align = "center"
    userInput.size = 16
    userInput:resizeHeightToFitFont()
    userInput.placeholder = "Usuario"

    passwordInput = native.newTextField(display.contentCenterX,
                                        userInput.y + 40,
                                        display.actualContentWidth - 90, 40)
    passwordInput.align = "center"
    passwordInput.isSecure = true
    passwordInput.size = 16
    passwordInput:resizeHeightToFitFont()
    passwordInput.placeholder = "Contraseña"

    local function loginButtonHandle(event)
        if ("ended" == event.phase) then
            -- sceneController.setScene("scenes.tasksView")
            utchVirtual.getToken(tokenCallback)
        end
    end

    buttonLogin = widget.newButton({
        x = passwordInput.x,
        y = passwordInput.y + 80,
        label = "Iniciar sesión",
        labelColor = {default = {0, 0, 0}, over = {0, 0, 0, 0.5}},
        onEvent = loginButtonHandle,
        id = "login",
        shape = "roundedRect",
        width = display.contentWidth - 100,
        height = 40,
        cornerRadius = 3,
        fillColor = {default = {255, 255, 255, 1}, over = {255, 255, 255, 0.5}},
        --strokeColor = {default = {0, 0, 0, 1}, over = {1, 1, 1, 1}},
        --strokeWidth = 2
    })
    sceneGroup:insert(backgroundImage)
    sceneGroup:insert(userInput)
    sceneGroup:insert(passwordInput)
    sceneGroup:insert(buttonLogin)
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

    end
end

-- destroy()
function scene:destroy(event)
    local sceneGroup = self.view
    userInput:removeSelf()
    passwordInput:removeSelf()
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
