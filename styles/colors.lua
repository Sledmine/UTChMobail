------------------------------------------------------------------------------
-- Color list
-- Author: Sledmine
-- Standard application colors
------------------------------------------------------------------------------
local color = require("lua-color-converter")

local colorList = {
    white = {
        default = {color.hex("#FFFFFF")},
        over = {color.hex("#e8e8e8")}
    },
    green = {
        default = {color.hex("#00796B")},
        over = {color.hex("#004D40")}
    }
}

return colorList