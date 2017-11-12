local EventHandler = {}

EventHandler.events = {}

function EventHandler:fire(event, ...)
    self.events[event] = self.events[event] or {}
    for _, func in pairs(self.events[event]) do
        func(...)
    end
end

function EventHandler:on(event, func)
    self.events[event] = self.events[event] or {}
    table.insert(self.events[event], func)
end

OOP:Register("EventHandler", EventHandler)