------------------------------------------------------------------------------
-- Log module
-- Author: Sledmine
-- log tool module for testing
------------------------------------------------------------------------------
local glue = require("glue")

-- Log module
local log = {}

log.mode = false
log.filesPath = ""

--- Log printing to console, only works if log mode is turned on
---@param message string
function log.print(message) if (debug.mode) then print(message) end end

--- Debug file writing to a specific folder, text mode by default
---@param path string
---@param content string
---@param mode string
function log.writeFile(path, content, mode)
    if (debug.mode) then
        local outputPath = log.filesPath .. "\\" .. path
        if (mode) then return glue.writefile(outputPath, content, mode) end
        -- Default output mode is text
        return glue.writefile(outputPath, content, "t")
    end
end

return log
