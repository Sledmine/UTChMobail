------------------------------------------------------------------------------
-- Utils module
-- Author: Sledmine
-- Some util functions
------------------------------------------------------------------------------

local utils = {}

--- Provide simple list/array iterator
function each(t)
    local i = 0
    local n = table.getn(t)
    return function()
        i = i + 1
        if i <= n then
            return t[i], i
        end
    end
end

return utils