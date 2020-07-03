------------------------------------------------------------------------------
-- Generic Tab Bar
-- Author: EduRicharte
-- Reusable tab bar component
------------------------------------------------------------------------------
local widget = require("widget")

-- Application libraries
sceneController = require('lib.sceneController')

-- Current instance of the tabBar
local tabBarInstance

local function tabBar(buttons)

    local tabButtons = {
        {
            label = "",
            defaultFile = "img/buttons/home.png",
            overFile = "img/buttons/home.png",
            width = 32,
            height = 32,
            onPress = function()
                sceneController.setScene("scenes.login")
            end
        }, {
            label = "",
            defaultFile = "img/buttons/list.png",
            overFile = "img/buttons/list.png",
            width = 32,
            height = 32,
            onPress = nil,
            selected = true
        }, {
            label = "",
            defaultFile = "img/buttons/settings.png",
            overFile = "img/buttons/settings.png",
            width = 32,
            height = 32,
            onPress = nil
        }
    }

    tabBarInstance = tabBarInstance or widget.newTabBar {
        top = display.contentHeight - 50,
        height = 50,
        backgroundFile = "img/tabBar.png",
        tabSelectedLeftFile = "img/tabBarSelected.png",
        tabSelectedRightFile = "img/tabBarSelected.png",
        tabSelectedMiddleFile = "img/tabBarSelected.png",
        tabSelectedFrameWidth = 40,
        tabSelectedFrameHeight = 120,
        buttons = tabButtons
    }

    return tabBarInstance
end

return tabBar
