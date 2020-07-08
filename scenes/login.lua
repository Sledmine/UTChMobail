------------------------------------------------------------------------------
-- Login
-- Author: Sledmnine
-- Login scene for UTCh Virtual data
------------------------------------------------------------------------------
local composer = require("composer")
local widget = require("widget")
local json = require("json")

local color = require("lua-color-converter")
local styles = require("styles.colors")

local utchVirtual = require("lib.utchVirtual")
local glue = require("glue")

-- Components importation
local Button = require("components.button")
local Input = require("components.input")

local scene = composer.newScene()

-- These objects are special inputs and we need to share them across the scene
local userInput
local passwordInput

-- Callbacks creation
-- TODO: Implement redux to provide better async state handle and remove function callbacks

--- Callback to handle parsed tasks from UTCh Virtual module
---@param studentTasks Task[]
local function tasksCallback(studentTasks)
    local options = {
        params = {studentTasks = studentTasks},
    }
    sceneController.setScene("scenes.tasksView", options)
end

--- Callback to handle login success from UTCh Virtual module
local function loginCallback(cookie)
    if (cookie) then
        -- Get current app config
        local newConfig = appConfig.get()

        -- Update config fields
        newConfig.userName = userInput.text
        newConfig.password = passwordInput.text

        -- Save app config
        appConfig.set(newConfig)

        -- Get tasks async with a callback
        utchVirtual.getTasks(tasksCallback)
    else
        -- TODO: Change this to a screen in the app
        local options = {
            params = {
                isSuccess = false,
                message = "Error al intentar iniciar sesión",
            },
        }
        sceneController.setScene("scenes.alert", options)
        print("Error at trying to log in!")
    end
end

--- Callback to handle parsed token from UTCh Virtual module
---@param token string
local function tokenCallback(token)
    if (token) then
        if (userInput.text ~= "" and passwordInput.text ~= "") then
            utchVirtual.login(userInput.text, passwordInput.text, token, loginCallback)
        end
    end
end

function scene:create(event)
    local sceneGroup = self.view

    -- Hide application global tab bar
    ApplicationTabBar.isVisible = false

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

    local appIcon = display.newImageRect("img/appIcon.png", 128, 128)
    appIcon.x = display.contentCenterX
    appIcon.y = 120
    sceneGroup:insert(appIcon)

    userInput = Input(display.contentCenterX, display.contentCenterY - 50, "Usuario")
    -- Load previous user name in app config
    userInput.text = appConfig.get().userName or ""
    sceneGroup:insert(userInput)

    passwordInput = Input(display.contentCenterX, userInput.y + 50, "Contraseña", true)
    -- Load previous password in app config
    passwordInput.text = appConfig.get().password or ""
    sceneGroup:insert(passwordInput)

    local aboutText = display.newText("Aplicación no oficial de la UTCh", display.contentCenterX,
                                      display.actualContentHeight - 30, native.systemFont, 16)
    aboutText:setFillColor(color.hex(styles.plain.white))
    sceneGroup:insert(aboutText)

    local function loginButtonHandle(event)
        if ("ended" == event.phase) then
            -- sceneController.setScene("scenes.tasksView")
            utchVirtual.getToken(tokenCallback)
        end
    end

    local loginButton = Button(passwordInput.x, passwordInput.y + 53, "Iniciar sesión", "login",
                               {
        styles.composed.white,
        styles.composed.green,
    }, loginButtonHandle)
    sceneGroup:insert(loginButton)

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
