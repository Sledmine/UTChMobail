-----------------------------------------------------------------------------------------
--
-- home.lua
--
-----------------------------------------------------------------------------------------
local composer = require('composer')
local widget = require('widget')
local scene = composer.newScene()

local utchVirtual = require('utils.utchVirtual')
local inspect = require('inspect')
local glue = require("glue")

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------

-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

local background
local myToken
local button1

local function loginCallback(cookie)
    
    utchVirtual.getTasks(glue.noop)
end

local function tokenCallback(token)
    print('Token: ' .. inspect(token))
    if (token) then
        myToken.text = token
        utchVirtual.login('1117150050', 'pchack123', token, loginCallback)
    end
end

-- Function to handle button events
local function handleButtonEvent(event)
    if ('ended' == event.phase) then

        utchVirtual.getToken(tokenCallback)
        --utchVirtual.login('1117150050', 'pchack123', '', loginCallback)

        print('Button was pressed and released')
    end
end

-- create()
function scene:create(event)
    local sceneGroup = self.view
    -- Code here runs when the scene is first created but has not yet appeared on screen

    background =
        display.newRect(display.contentCenterX, display.contentCenterY, display.contentWidth, display.contentHeight)
    background:setFillColor(1)

    myToken = display.newText('No token', display.contentCenterX, display.contentCenterY, native.systemFont, 16)
    myToken:setFillColor(0)

    -- Create the widget
    button1 =
        widget.newButton(
        {
            left = 100,
            top = 200,
            id = 'button1',
            label = 'Default',
            onEvent = handleButtonEvent
        }
    )
end

-- show()
function scene:show(event)
    local sceneGroup = self.view
    local phase = event.phase

    if (phase == 'will') then
        -- Code here runs when the scene is still off screen (but is about to come on screen)
    elseif (phase == 'did') then
    -- Code here runs when the scene is entirely on screen
    end
end

-- hide()
function scene:hide(event)
    local sceneGroup = self.view
    local phase = event.phase

    if (phase == 'will') then
        -- Code here runs when the scene is on screen (but is about to go off screen)
    elseif (phase == 'did') then
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
scene:addEventListener('create', scene)
scene:addEventListener('show', scene)
scene:addEventListener('hide', scene)
scene:addEventListener('destroy', scene)
-- -----------------------------------------------------------------------------------

return scene
