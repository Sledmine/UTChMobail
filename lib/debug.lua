------------------------------------------------------------------------------
-- Debug module
-- Author: Sledmine
-- Debug tool module for testing
------------------------------------------------------------------------------
local glue = require("glue")

-- Debug module
local debug = {}

debug.mode = false
debug.filesPath = ""

--- Debug printing to console, only works if debug mode is turned on
---@param message string
function debug.print(message) if (debug.mode) then print(message) end end

--- Debug file writing to a specific folder, text mode by default
---@param path string
---@param content string
---@param mode string
function debug.writefile(path, content, mode)
    if (debug.mode) then
        print("Debug writing!!")
        local outputPath = debug.filesPath .. "\\" .. path
        if (mode) then return glue.writefile(outputPath, content, mode) end
        -- Default output mode is text
        return glue.writefile(outputPath, content, "t")
    end
end

return debug
