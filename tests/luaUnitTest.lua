local lu = require("luaunit")

test_Luaunit = {}

function test_Luaunit:test_NoErrorDetection()
    print("Testing no error triggering\n")

    lu.assertEquals(true, true)
end

-- Try to comment this function test to see how it is supposed to work
function test_Luaunit:test_ErrorDetection()
    print("Testing error function triggering\n")

    lu.assertEquals(true, false)
end

function test_Luaunit:test_StringComparision()
    lu.assertEquals("true", "false")
end

local runner = lu.LuaUnit.new()
runner:runSuite()