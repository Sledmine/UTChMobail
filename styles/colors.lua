------------------------------------------------------------------------------
-- Color list
-- Author: Sledmine
-- Standard application colors
------------------------------------------------------------------------------
local color = require("lua-color-converter")

local colors = {}

colors.composed = {
    white = {
        default = {color.hex("#FFFFFF")},
        over = {color.hex("#e8e8e8")}
    },
    green = {
        default = {color.hex("#00796B")},
        over = {color.hex("#004D40")}
    },
    orange = {
        default = {color.hex("#cc9600")},
        over = {color.hex("#8f6900")}
    }
}

colors.plain = {
    white = color.hex("#fafafa"),
    gray = color.hex("#263238"),
    test = color.hex("#00E5FF")
}

return colors