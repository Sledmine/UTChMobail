local htmlParser = require('htmlparser')
local inspect = require('inspect')
local glue = require('glue')

-- Entities
local Task = require('entities.task')

-- Module
local utchVirtual = {}

local lastCookie = ''
local returnCallback = nil
local process = nil

local debugFolder = 'D:\\VirtualMobailDump'

----------------- Parse functions ----------------------

local function parseToken(event)
    if (not event.isError) then
        local SetCookie = event.responseHeaders['Set-Cookie']
        if (SetCookie) then
            print('Set-Cookie: ' .. SetCookie)
            lastCookie = glue.string.split(';', SetCookie)[1]
            print('New Cookie: ' .. lastCookie)
        end

        local htmlText = event.response

        local htmlSelector = htmlParser.parse(htmlText)

        local elements = htmlSelector("input[name='logintoken']")

        if (elements and #elements > 0) then
            local token = elements[1].attributes.value
            if (token) then
                return token
            end
        end
    end
    return nil
end

local function parseCookie(event)
    if (not event.isError) then
        local SetCookie = event.responseHeaders['Set-Cookie']
        if (SetCookie) then
            print('You recieved a NEW cookie!!!!!!!!!!')
            print('Set-Cookie: ' .. SetCookie)
            lastCookie = glue.string.split(';', SetCookie)[1]
            print('New Cookie: ' .. lastCookie)
        end
        local htmlText = event.response

        local htmlSelector = htmlParser.parse(htmlText)

        local elements = htmlSelector("input[name='logintoken']")

        return lastCookie
    end
    return nil
end

local function parseTasks(event)
    if (not event.isError) then
        local htmlText = event.response
        --glue.writefile(debugFolder .. '\\tasks.html', htmlText, 't')

        local htmlSelector = htmlParser.parse(htmlText)

        local tasks = htmlSelector("div[data-type='event']")
        print('Found ' .. #tasks .. ' pending tasks!')

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
            glue.append(studentTasks, singleTask)
        end

        return studentTasks
    end
    return nil
end

local function dumpRequest(event)
    glue.writefile(debugFolder .. '\\dump.html', event.response, 't')
end

---------------------------------------------------------

-- Listener to recieve async HTTP response
local function networkListener(event)
    if (event.isError) then
        print(inspect(event))
        print('Network error: ', event.response)
    else
        --print(inspect(event))
        --print('RESPONSE: ' .. event.response)
    end
    returnCallback(process(event))
end

function utchVirtual.getToken(methodCallback)
    if (methodCallback) then
        process = parseToken
        returnCallback = methodCallback
        local headers = {
            ['Cookie'] = lastCookie
        }
        local params = {
            headers = headers
        }
        print('Get Cookie: ' .. lastCookie)
        network.request('http://virtual.utch.edu.mx/login/index.php', 'GET', networkListener, params)
    end
end

function utchVirtual.login(userName, password, token, methodCallback)
    if (methodCallback) then
        process = parseCookie
        returnCallback = methodCallback

        local body = 'username=' .. userName .. '&password=' .. password .. '&logintoken=' .. token

        local headers = {
            ['Cookie'] = lastCookie,
            ['Content-Type'] = 'application/x-www-form-urlencoded'
        }
        print('Post Cookie: ' .. lastCookie)

        local params = {
            headers = headers,
            body = body,
            handleRedirects = false
        }

        print('Body: ' .. body)

        network.request('http://virtual.utch.edu.mx/login/index.php', 'POST', networkListener, params)
    end
end

---@return Task[]
function utchVirtual.getTasks(methodCallback)
    if (methodCallback) then
        process = parseTasks
        returnCallback = methodCallback
        local headers = {
            ['Cookie'] = lastCookie
        }
        local params = {
            headers = headers
        }
        network.request('http://virtual.utch.edu.mx/calendar/view.php?view=upcoming', 'GET', networkListener, params)
    end
end

return utchVirtual
