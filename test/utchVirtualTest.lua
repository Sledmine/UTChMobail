------------------------------------------------------------------------------
-- utchVirtualTest
-- Author: Gelatinoso
-- Tests for utchVirtual module
------------------------------------------------------------------------------
local lu = require("luaunit")
local glue = require("glue")

local utchVirtual = require("lib.utchVirtual")

----------------- utchVirtual Tests -----------------------
test_UtchVirtual = {}

function test_UtchVirtual:setUp()
   debug.print("Running test")
end

function test_UtchVirtual:test_getToken()
    local tokenResult = nil
    debug.print("hola")
    --[[local function tokenCallback(token)
        tokenResult = token
        debug.print(token)
    end
    utchVirtual.getToken(tokenCallback)]]
    -- lu.assertNotIsNil(tokenResulto)
end

return function()
    local runner = lu.LuaUnit.new()
    runner:runSuite()
end
