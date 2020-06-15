------------------------------------------------------------------------------
-- Task entity
-- Author: Sledmine
-- Entity to reflect data gathered from UTCh Virtual
------------------------------------------------------------------------------
local class = require("middleclass")

--- Task class
---@class Task
local Task = class('Task')

local dayweeks = {
    Monday = "Lunes",
    Tuesday = "Martes",
    Thursday = "Miercoles",
    Wednesday = "Jueves",
    Friday = "Viernes",
    Saturday = "Sabado",
    Sunday = "Domingo"
}

local function epochToDateString(epochDate)
    local formattedDate = os.date('%A %e/%m/%Y a las %H:%M UTC', tonumber(epochDate))
    for dayname, translation in pairs(dayweeks) do
        if (formattedDate:find(dayname)) then
            formattedDate = string.gsub(formattedDate, dayname, translation)
        end
    end
    return formattedDate
end

--[[
    public class Task {
    String title;
    Date date;
    String link;

    public Task(title) {

    }
}
]]

---@param title string
---@param date string
---@param link string
function Task:initialize(title, date, link)
    self.title = title
    self.date = epochToDateString(date)
    self.link = link
end

--[[
    public String getTitle() {
       return this.title; 
    }
]]
---@return string
function Task:getTitle()
    return self.title
end

---@param title string
function Task:setTitle(title)

    self.title = title
end

---@return string
function Task:getDate()
    return self.title
end

---@param date string
function Task:setDate(date)
    self.date = epochToDateString(date)
end

---@return string
function Task:getLink()
    return self.title
end

---@param link string
function Task:setLink(link)
    self.link = link
end

return Task