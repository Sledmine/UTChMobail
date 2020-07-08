------------------------------------------------------------------------------
-- Scene Controller
-- Author: Sledmine
-- Controller for scene creation, destruction and history
------------------------------------------------------------------------------
local composer = require("composer")

local sceneController = {}

--- Set a scene to render it on screen, optional destroy current scene
---@param newScene string
---@param options table
function sceneController.setScene(newScene, options)
    local currentScene = composer.getSceneName("current")
    if (currentScene) then
        composer.removeScene(currentScene)
    end
    composer.gotoScene(newScene, options)
end

--- Go back to the last rendered scene, optional destroy current scene
---@param options table
---@return boolean
function sceneController.setPreviousScene(options)
    local previousScene = composer.getSceneName("previous")
    if (previousScene) then
        local currentScene = composer.getSceneName("current")
        if (currentScene) then
            composer.removeScene(currentScene)
            composer.gotoScene(previousScene, options)
            return true
        end
    end
    return false
end

return sceneController
