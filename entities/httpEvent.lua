------------------------------------------------------------------------------
-- Http Event entity
-- Author: Sledmine
-- Entity to reflect response from network library
------------------------------------------------------------------------------
local class = require("middleclass")

---@class httpEvent
local httpEvent = class("httpEvent")

function httpEvent:initialize(event)
    --- Raw event object
    ---@type table
    self.rawEvent = event
    --- Bytes estimated to recieve
    ---@type number
    self.bytesEstimated = event.bytesEstimated
    --- Bytes transferred in request
    ---@type number
    self.bytesTransferred = event.bytesTransferred
    --- Flag for possible errors in the request
    ---@type boolean
    self.isError = event.isError
    self.name = event.name
    self.phase = event.phase
    self.requestId = event.requestId
    --- Response from network request
    ---@type string
    self.response = event.response
    --- Headers sent in the response
    ---@type table
    self.responseHeaders = event.responseHeaders
    --- Type of data in the response field
    ---@type string
    self.responseType = event.responseType
    self.status = event.status
    self.url = event.url
end

return httpEvent

