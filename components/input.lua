------------------------------------------------------------------------------
-- Generic Input
-- Author: Sledmine
-- Reusable input component
------------------------------------------------------------------------------
---@param x number
---@param y number
---@param placeholder string
---@param listener function
local function input(x, y, placeholder, listener)
    local newInput = native.newTextField(x, y, display.actualContentWidth - 30,
                                         40)

    newInput.align = "center"
    newInput.size = 15
    -- userInput:resizeHeightToFitFont()
    newInput.height = 40
    newInput.placeholder = placeholder
    if (listener) then newInput:addEventListener("userInput", listener) end
    return newInput
end

return input
