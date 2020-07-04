------------------------------------------------------------------------------
-- Task entity
-- Author: Sledmine
-- Entity to reflect data gathered from UTCh Virtual
------------------------------------------------------------------------------
local class = require("middleclass")

--- Task class
---@class Task
local Task = class("Task")

--- Table dayweeks translation
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
    local formattedDate = os.date("%A %d/%m/%Y a las %H:%M UTC", tonumber(epochDate))
    --local formattedDate = os.date("%H:%M UTC", tonumber(epochDate))
    for dayname, translation in pairs(dayweeks) do
        if (formattedDate:find(dayname)) then
            formattedDate = string.gsub(formattedDate, dayname, translation)
        end
    end
    return formattedDate
end

local function cleanTaskTitle(title)
    local cleanedTitle = title
    cleanedTitle = string.gsub(title, " está en fecha de entrega", "")
    return cleanedTitle
end

--[[
    public class Task {
    String title;
    Date date;
    String link;

    public Task(String title, Date date, String link) {
        this.title = title;
        this.date = date;
        this.link = link;
    }
}
]]

---@param title string
---@param date string
---@param link string
function Task:initialize(title, date, link)
    -- Try to see if this is not giving us problems
    self:setTitle(title)
    self:setDate(date)
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
    self.title = cleanTaskTitle(title)
end

---@return string
function Task:getDate()
    return self.date
end

---@param date string
function Task:setDate(date)
    self.date = epochToDateString(date)
end

---@return string
function Task:getLink()
    return self.link
end

---@param link string
function Task:setLink(link)
    self.link = link
end

return Task