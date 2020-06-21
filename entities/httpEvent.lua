------------------------------------------------------------------------------
-- Http Event entity
-- Author: Sledmine
-- Entity to reflect response from network library
------------------------------------------------------------------------------
local class = require("middleclass")

---@class httpEvent
local httpEvent = class("httpEvent")

function httpEvent:initialize(event)
    self.rawEvent = event
    self.bytesEstimated = event.bytesEstimated
    self.bytesTransferred = event.bytesTransferred
    self.isError = event.isError
    self.name = event.name
    self.phase = event.phase
    self.requestId = event.requestId
    --- Response from network request
    ---@type string
    self.response = event.response
    self.responseHeaders = event.responseHeaders
    self.responseType = event.responseType
    self.status = event.status
    self.url = event.url
end

return httpEvent

