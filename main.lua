------------------------------------------------------------------------------
-- Main
-- Author: Sledmine
-- Main entry for the application
------------------------------------------------------------------------------
inspect = require("inspect")
utils = require("lib.utils")
widget = require("widget")
widget.setTheme("widget_theme_android_holo_dark")

-- Functional or project libs
appConfig = require("lib.appConfig")
local color = require("lua-color-converter")
local log = require("lib.log")

-- Import application components
TabBar = require("components.tabBar")

-- Application libraries
sceneController = require("lib.sceneController")

-- Called when a key event has been received
local function onKeyEvent(event)
    -- Print which key was pressed down/up
    local message = "Key '" .. event.keyName .. "' was pressed " .. event.phase
    -- print(message)

    -- If pressed "f12" key then run unit tests
    if (event.keyName == "f12" and event.phase == "down") then
    end

    -- If the "back" key was pressed on Android, prevent it from backing out of the app
    if (event.keyName == "back" and event.phase == "down") then
        if (system.getInfo("platform") == "android") then
            -- Return the result of the try of setting the previous scene
            -- If there is a previous scene intercept the button
            --return sceneController.setPreviousScene()
        end
    end

    -- IMPORTANT! Return false to indicate that this app is NOT overriding the received key
    -- This lets the operating system execute its default handling of the key
    return false
end

-- Add the key event listener
Runtime:addEventListener("key", onKeyEvent)

-- Create application global tab bar
ApplicationTabBar = TabBar()
ApplicationTabBar.isVisible = false

-- Load first application scene
sceneController.setScene("scenes.login")
