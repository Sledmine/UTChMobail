------------------------------------------------------------------------------
-- Main
-- Author: Sledmine
-- Main entry for the application
------------------------------------------------------------------------------
sceneController = require('lib.sceneController')

inspect = require("inspect")

-- Called when a key event has been received
local function onKeyEvent(event)
    -- Print which key was pressed down/up
    local message = "Key '" .. event.keyName .. "' was pressed " .. event.phase
    print(message)

    -- If the "back" key was pressed on Android, prevent it from backing out of the app
    if (event.keyName == 'back') then
        if (system.getInfo('platform') == 'android') then
            --sceneController.setPreviousScene()
            return false
        end
    end

    -- IMPORTANT! Return false to indicate that this app is NOT overriding the received key
    -- This lets the operating system execute its default handling of the key
    return false
end

-- Add the key event listener
--Runtime:addEventListener('key', onKeyEvent)

-- Load first application scene
sceneController.setScene('scenes.login')
