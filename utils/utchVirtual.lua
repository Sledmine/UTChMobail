local inspect = require('inspect')
local glue = require('glue')
local htmlParser = require('htmlparser')

-- Module
local utchVirtual = {}

local lastCookie = ''
local returnCallback = nil
local process = nil

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
        glue.writefile('D:\\get.html', htmlText, 't')

        local htmlObject = htmlParser.parse(htmlText)

        local elements = htmlObject("input[name='logintoken']")
        glue.writefile('D:\\get.json', inspect(elements), 't')

        local token = elements[1].attributes.value
        return token
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
        glue.writefile('D:\\post.html', htmlText, 't')

        local htmlObject = htmlParser.parse(htmlText)

        local elements = htmlObject("input[name='logintoken']")
        glue.writefile('D:\\post.json', inspect(elements), 't')

        return lastCookie
    end
    return nil
end

local function parseTasks(event)
    if (not event.isError) then
        
    end
    return nil
end

local function dumpRequest(event)
    glue.writefile('D:\\dump.html', event.response, 't')
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

function utchVirtual.getTasks(methodCallback)
    if (methodCallback) then
        process = dumpRequest
        returnCallback = methodCallback
        local headers = {
            ['Cookie'] = lastCookie
        }
        local params = {
            headers = headers
        }
        network.request('http://virtual.utch.edu.mx/my/', 'GET', networkListener, params)
    end
end

return utchVirtual
