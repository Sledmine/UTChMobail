------------------------------------------------------------------------------
-- Generic mage rect
-- Author: Gelatinoso
-- Reusable rect component
------------------------------------------------------------------------------
local display = require("display")

---@param parent table or number
---@param filename string
---@param x number
---@param y number
---@param width number
---@param heigth number
local function imageRect(parent, filename, x, y, width, heigth)
    if(heigth) then
        return display.newImageRect(parent, filename, x, y, width, heigth)
    end
    return display.newImageRect(parent, filename, x, y, width)
end

return imageRect
