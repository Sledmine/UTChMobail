------------------------------------------------------------------------------
-- Generic Tab Bar
-- Author: EduRicharte
-- Reusable tab bar component
------------------------------------------------------------------------------
local widget = require("widget")

local function onFirstView(event) print("Estás en la página 1") end

local function onSecondView(event) print("Estás en la página 2") end

local function onThirdView(event) print("Estás en la página 3") end

local tabButtons = {
    {
        label = "",
        defaultFile = "img/home.png",
        overFile = "img/home.png",
        width = 32,
        height = 32,
        onPress = onFirstView,
        selected = true
    }, {
        label = "",
        defaultFile = "img/list.png",
        overFile = "img/list.png",
        width = 32,
        height = 32,
        onPress = onSecondView
    }, {
        label = "",
        defaultFile = "img/settings.png",
        overFile = "img/settings.png",
        width = 32,
        height = 32,
        onPress = onThirdView
    }
}

local function tabBar(buttons)
    return widget.newTabBar {
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
end


return tabBar