------------------------------------------------------------------------------
-- Generic Input
-- Author: Sledmine
-- Reusable input component
------------------------------------------------------------------------------
---@param x number
---@param y number
---@param placeholder string
---@param isSecure boolean
local function input(x, y, placeholder, isSecure)
    local newInput = native.newTextField(x, y, display.actualContentWidth - 30, 40)
    newInput.align = "center"
    newInput.size = 15
    -- userInput:resizeHeightToFitFont()
    newInput.height = 40
    newInput.placeholder = placeholder
    newInput.isSecure = isSecure or false
    --if (listener) then newInput:addEventListener("userInput", listener) end
    return newInput
end

return input
