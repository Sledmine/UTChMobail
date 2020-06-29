------------------------------------------------------------------------------
-- Navigation Bar
-- Author: Dark_E
-- Navigation Bar scene for UTCh Virtual data
------------------------------------------------------------------------------
local composer = require("composer")
local widget = require("widget")

local color = require("lua-color-converter")

local scene = composer.newScene()

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------

-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
function scene:create(event)

    local sceneGroup = self.view
    -- Code here runs when the scene is first created but has not yet appeared on screen
    local background = display.newRect(display.contentCenterX,
                                       display.contentCenterY,
                                       display.actualContentWidth,
                                       display.actualContentHeight)
    background:setFillColor(color.hex("#c9f3df"))

    local appIcon = display.newImageRect("img/appIcon.png", 128, 128)
    appIcon.x = display.contentCenterX
    appIcon.y = 120

    -- Creacion de TabBar
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

    local tabBar = widget.newTabBar {
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

    sceneGroup:insert(background)
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
