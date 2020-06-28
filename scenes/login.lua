------------------------------------------------------------------------------
-- Login
-- Author: Gelatinoso
-- Login scene for UTCh Virtual data
------------------------------------------------------------------------------
local composer = require("composer")
local widget = require("widget")

local color = require("lua-color-converter")

local utchVirtual = require("lib.utchVirtual")

local scene = composer.newScene()

local background
local appIcon
local userInput
local passwordInput
local buttonLogin

---@param studentTasks Task[]
local function tasksCallback(studentTasks)
    local options = {params = {studentTasks = studentTasks}}
    sceneController.setScene("scenes.tasksView", options)
end

local function loginCallback(cookie)
    if (cookie) then
        utchVirtual.getTasks(tasksCallback)
    else
        print("Error at trying to log in!")
    end
end

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

    local background = display.newRect(display.contentCenterX,
                                       display.contentCenterY,
                                       display.actualContentWidth,
                                       display.actualContentHeight)
    background:setFillColor(color.hex("#c9f3df"))

    appIcon = display.newImageRect("img/appIcon.png", 128, 128)
    appIcon.x = display.contentCenterX
    appIcon.y = 120

    userInput = native.newTextField(display.contentCenterX,
                                    display.contentCenterY - 50,
                                    display.actualContentWidth - 30, 40)
    userInput.align = "center"
    userInput.size = 15
    -- userInput:resizeHeightToFitFont()
    userInput.height = 40
    userInput.placeholder = " Usuario"

    passwordInput = native.newTextField(display.contentCenterX,
                                        userInput.y + 50,
                                        display.actualContentWidth - 30, 40)
    passwordInput.align = "center"
    passwordInput.isSecure = true
    passwordInput.size = 15
    -- passwordInput:resizeHeightToFitFont()
    passwordInput.height = 40
    passwordInput.placeholder = " Contraseña"

    local function loginButtonHandle(event)
        if ("ended" == event.phase) then
            -- sceneController.setScene("scenes.tasksView")
            utchVirtual.getToken(tokenCallback)
        end
    end

    buttonLogin = widget.newButton({
        x = passwordInput.x,
        y = passwordInput.y + 53,
        label = "Iniciar sesión",
        labelColor = {
            default = {color.hex("#FFFFFF")},
            over = {color.hex("#e8e8e8")}
        },
        onEvent = loginButtonHandle,
        id = "login",
        shape = "roundedRect",
        width = display.contentWidth - 30,
        height = 45,
        cornerRadius = 3,
        fillColor = {
            default = {color.hex("#00796B")},
            over = {color.hex("#004D40")}
        }
        -- strokeColor = {default = {0, 0, 0, 1}, over = {1, 1, 1, 1}},
        -- strokeWidth = 2
    })
    sceneGroup:insert(background)
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
