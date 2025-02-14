local lvgl = require("lvgl")

local dataman = {
    timer = nil,
    increase = true
}

-- Mock data storage for subscriptions
local subscriptions = {}

-- Mock function to simulate subscribing to a topic
function dataman.subscribe(topic, obj, callback)
    if not subscriptions[topic] then
        subscriptions[topic] = {}
    end
    table.insert(subscriptions[topic], {obj = obj, callback = callback})
end

-- Mock function to simulate publishing data to a topic
function dataman.publish(topic, value)
    if subscriptions[topic] then
        for _, sub in ipairs(subscriptions[topic]) do
            sub.callback(sub.obj, value)
        end
    end
end

-- Mock function to simulate time updates
function dataman.updateTime()

    local current_time = os.date("*t")

    local hourHigh = current_time.hour // 10
    local hourLow = current_time.hour % 10

    local minuteHigh = current_time.min // 10
    local minuteLow = current_time.min % 10

    local secondHigh = current_time.sec // 10
    local secondLow = current_time.sec % 10

    dataman.publish("dateYear", current_time.year * 256)
    dataman.publish("dateMonth", current_time.month * 256)
    dataman.publish("dateDay", current_time.day * 256)
    dataman.publish("dateWeek", current_time.wday * 256)

    dataman.publish("timeHour", current_time.hour * 256)
    dataman.publish("timeHourHigh", hourHigh * 256)
    dataman.publish("timeHourLow", hourLow * 256)

    dataman.publish("timeMinute", current_time.min * 256)
    dataman.publish("timeMinuteHigh", minuteHigh * 256)
    dataman.publish("timeMinuteLow", minuteLow * 256)

    dataman.publish("timeSecond", current_time.sec * 256)
    dataman.publish("timeSecondHigh", secondHigh * 256)
    dataman.publish("timeSecondLow", secondLow * 256)
end

-- Mock function to simulate battery updates
function dataman.updateBattery(level)
    dataman.publish("systemStatusBattery", level * 256) -- Simulate the value format
end

-- Function to simulate time progression
local function simulateTime()
    -- Publish time updates
    dataman.updateTime()
end

local level = 100
-- Function to simulate battery level changes
local function simulateBattery()

    if level >= 100 then dataman.increase = false end
    if level <= 50 then dataman.increase = true end

    level = dataman.increase and level + 1 or level - 1

    print ("increase: ".. tostring(dataman.increase))
    dataman.updateBattery(level)
end

-- Start simulation threads (for time and battery)
function dataman:startSimulation()

    self.timer = lvgl.Timer({
        paused = false,
        period = 1000,
        cb = function(t)
            simulateTime()
            simulateBattery()

            print("Simulation tick")
        end
    })
end

-- Start the simulation
dataman:startSimulation()

return dataman