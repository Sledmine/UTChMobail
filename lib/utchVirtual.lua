------------------------------------------------------------------------------
-- UTCh Virtual Module
-- Author: Sledmine
-- Module to gather data from UTCh Virtual
------------------------------------------------------------------------------
local htmlParser = require("htmlparser")
local glue = require("glue")

-- Entities
local Task = require("entities.task")
local HTTPEvent = require("entities.httpEvent")

-- Module
local utchVirtual = {}

-- Increase loop limit for large html files
htmlparser_looplimit = 2000

local lastCookie = ""
local returnCallback = nil
local process = nil

local function substractCookie(cookie) return glue.string.split(';', cookie)[1] end

--- Parse token from an http response
local function parseToken(event)
    if (not event.isError) then
        -- UTCh Virtual send us back a cookie to match with our token in order to keep it alive
        local SetCookie
        if (event.responseHeaders) then
            SetCookie = event.responseHeaders['Set-Cookie']
            if (SetCookie) then
                print('Set-Cookie: ' .. SetCookie)
                lastCookie = substractCookie(SetCookie)
            end
        end

        local htmlText = event.response

        -- Create selector from html parser
        local htmlSelector = htmlParser.parse(htmlText)

        local elements = htmlSelector("input[name='logintoken']")

        if (elements and #elements > 0) then
            local token = elements[1].attributes.value
            if (token) then return token end
        end
    end
    return nil
end

--- Parse cookie from an http response
local function parseCookie(event)
    if (not event.isError) then
        -- We need to get the new cookie if our login is success
        local SetCookie
        if (event.responseHeaders) then
            SetCookie = event.responseHeaders['Set-Cookie']
            if (SetCookie) then
                print('Set-Cookie: ' .. SetCookie)
                lastCookie = substractCookie(SetCookie)
            end
        end

        local htmlText = event.response

        local htmlSelector = htmlParser.parse(htmlText)

        local elements = htmlSelector("input[name='logintoken']")

        return SetCookie
    end
    return nil
end

--- Parse tasks from an http response
local function parseTasks(event)
    if (not event.isError) then
        local htmlText = event.response

        local htmlSelector = htmlParser.parse(htmlText)

        local tasks = htmlSelector("div[data-type='event']")

        ---@type Task[]
        local studentTasks = {}

        for taskIndex, taskElement in pairs(tasks) do
            -- Get task name
            local taskName = taskElement.attributes['data-event-title']
            local taskDate = ''
            local taskUrl = ''

            -- Get isolated task
            local taskElementText = taskElement:gettext()
            local taskElementSelector = htmlParser.parse(taskElementText)

            -- Get hyperlinks to retrieve date, attachments and task url
            local taskElementHyperlinks = taskElementSelector('a')
            for hyperlinkIndex, hyperlinkElement in pairs(taskElementHyperlinks) do
                -- Get href url
                local href = hyperlinkElement.attributes.href

                -- Processing epoch date
                if (hyperlinkIndex == 1) then
                    local splitValues = glue.string.split('=', href)
                    taskDate = splitValues[#splitValues]
                else
                    local attachment = hyperlinkElement.attributes.title
                    -- Processing task attachment
                    if (attachment) then
                        -- TO DO: Add attachments list to Task class
                    else
                        taskUrl = href
                    end
                end

                local hyperlinkElementText = hyperlinkElement:gettext()
            end

            -- Create Task object instance
            local singleTask = Task:new(taskName, taskDate, taskUrl)

            -- Append to the list the new task
            studentTasks[#studentTasks + 1] = singleTask
            -- glue.append(studentTasks, singleTask)
        end
        -- THIS IS NO OK.. OK?, HARD REMOVING COOKIE TO FORCE SESSION TO EXPIRE AND RELOGIN IF NEED
        lastCookie = ""
        return studentTasks
    end
    return nil
end

local function parseSubjects(event)
    if (not event.isError) then
        local htmlText = event.response

        local htmlSelector = htmlParser.parse(htmlText)

    end
end

---------------------------------------------------------

-- Listener to recieve async HTTP response
---@param eventObject table
local function networkListener(eventObject)
    local event = HTTPEvent:new(eventObject)
    if (event.isError) then
        -- print(inspect(eventObject))
        print('Network error: ', event.response)
    else
        -- print(inspect(eventObject))
        -- print('RESPONSE: ' .. event.response)
    end
    returnCallback(process(event))
end

--- Get the login token by an async call
---@param methodCallback function
---@return string token
function utchVirtual.getToken(methodCallback)
    if (methodCallback) then
        process = parseToken
        returnCallback = methodCallback
        local headers = {['Cookie'] = lastCookie}
        local params = {headers = headers}
        print('Get Cookie: ' .. lastCookie)
        network.request('http://virtual.utch.edu.mx/login/index.php', 'GET',
                        networkListener, params)
    else
        print("Warning, no callback method on getToken")
    end
end

--- Create a session and get the session cookie by an async call
---@param userName string
---@param password string
---@param token string
---@param methodCallback function
---@return string cookie
function utchVirtual.login(userName, password, token, methodCallback)
    if (methodCallback) then
        process = parseCookie
        returnCallback = methodCallback

        local body = 'username=' .. userName .. '&password=' .. password ..
                         '&logintoken=' .. token

        local headers = {
            ['Cookie'] = lastCookie,
            ['Content-Type'] = 'application/x-www-form-urlencoded'
        }
        print('Post Cookie: ' .. lastCookie)

        local params = {headers = headers, body = body, handleRedirects = false}

        print('Body: ' .. body)

        network.request('http://virtual.utch.edu.mx/login/index.php', 'POST',
                        networkListener, params)
    else
        print("Warning, no callback method on login")
    end
end

--- Get current session tasks by an async call
---@param methodCallback function
---@return Task[]
function utchVirtual.getTasks(methodCallback)
    if (methodCallback) then
        process = parseTasks
        returnCallback = methodCallback
        local headers = {['Cookie'] = lastCookie}
        local params = {headers = headers}
        network.request(
            'http://virtual.utch.edu.mx/calendar/view.php?view=upcoming', 'GET',
            networkListener, params)
    end
end

function utchVirtual.getSubject(methodCallback)
    if (methodCallback) then
        process = parseSubjects
        returnCallback = methodCallback
        local headers = {['Cookie'] = lastCookie}
        local params = {headers = headers}
        network.request(
            'http://virtual.utch.edu.mx/mod/assign/view.php?id=66336', "GET",
            networkListener, params)
    else
        print("Warning, getSubject called with no callback")
    end
end

utchVirtual.parsers = {
    parseToken = parseToken,
    parseCookie = parseCookie,
    parseTasks = parseTasks
}

return utchVirtual
