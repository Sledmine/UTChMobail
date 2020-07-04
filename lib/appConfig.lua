------------------------------------------------------------------------------
-- Application configuration module
-- Author: Gelatinoso
-- Module tool for handling application settings
------------------------------------------------------------------------------
local glue = require("glue")
local json = require("json")

local appConfig = {}
system = system or {pathForFile = function ()
    return "settings.json"
end}

--- Stores the app settings given a table
---@param config table
---@return boolean
function appConfig.set(config)
    local jsonConfig = json.encode(config)
    local settingsPath =system.pathForFile("settings.json", system.ApplicationSupportDirectory)
    glue.writefile(settingsPath, jsonConfig, "t")
    local result = glue.canopen(settingsPath)
    if (result) then
        return true
    end
    return false
end

--- Returns default or currently app settings
---@return table
function appConfig.get()
    local settingsPath = system.pathForFile("settings.json", system.ApplicationSupportDirectory)
    local jsonConfig = glue.readfile(settingsPath, "t")
    local config = json.decode(jsonConfig)

    return config
end

return appConfig

