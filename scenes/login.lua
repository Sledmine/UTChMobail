------------------------------------------------------------------------------
-- Login
-- Author: Gelatinoso
-- Login scene for UTCh Virtual data
------------------------------------------------------------------------------
local composer = require("composer")
local widget = require("widget")

local color = require("lua-color-converter")
local styles = require("styles.colors")

local utchVirtual = require("lib.utchVirtual")

-- Components importation
local Button = require("components.button")
local Input = require("components.input")

local scene = composer.newScene()

local userInput
local passwordInput

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

    -- Hide application global tab bar
    ApplicationTabBar.isVisible = false

    -- Create background
    local background = display.newRect(display.contentCenterX,
                                       display.contentCenterY,
                                       display.actualContentWidth,
                                       display.actualContentHeight)
    background:setFillColor(color.hex("#B2DFDB"))

    local details = display.newImageRect("img/background.png",
                                         display.actualContentWidth,
                                         display.actualContentHeight)
    details.x = display.contentCenterX
    details.y = display.contentCenterY

    local appIcon = display.newImageRect("img/appIcon.png", 128, 128)
    appIcon.x = display.contentCenterX
    appIcon.y = 120

    userInput = Input(display.contentCenterX, display.contentCenterY - 50,
                      "Usuario")

    passwordInput = Input(display.contentCenterX, userInput.y + 50,
                          "Contraseña", true)
                          passwordInput.text = "pchack123"

    local aboutText = display.newText("Aplicación no oficial de la UTCh",
                                      display.contentCenterX,
                                      display.actualContentHeight - 30,
                                      native.systemFont, 16)
    aboutText:setFillColor(styles.plain.white)

    local function loginButtonHandle(event)
        if ("ended" == event.phase) then
            -- sceneController.setScene("scenes.tasksView")
            utchVirtual.getToken(tokenCallback)
        end
    end

    local loginButton = Button(passwordInput.x, passwordInput.y + 53,
                               "Iniciar sesión", "login",
                               {styles.composed.white, styles.composed.green},
                               loginButtonHandle)

    sceneGroup:insert(background)
    sceneGroup:insert(details)
    sceneGroup:insert(appIcon)
    sceneGroup:insert(userInput)
    sceneGroup:insert(passwordInput)
    sceneGroup:insert(loginButton)
    -- sceneGroup:insert(aboutText)
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
