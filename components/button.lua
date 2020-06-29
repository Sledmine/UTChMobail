------------------------------------------------------------------------------
-- Generic Button
-- Author: Sledmine
-- Reusable button component
------------------------------------------------------------------------------
local widget = require("widget")

---@param x number
---@param y number
---@param label string
---@param id any
---@param color table
---@param onEvent function
local function button(x, y, label, id, color, onEvent)
    return widget.newButton({
        x = x,
        y = y,
        label = label,
        labelColor = color[1],
        onEvent = onEvent,
        id = id,
        shape = "roundedRect",
        width = display.contentWidth - 30,
        height = 45,
        cornerRadius = 3,
        fillColor = color[2]
    })
end

return button
