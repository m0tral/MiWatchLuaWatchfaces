local lvgl = require("lvgl")
local topic = require("topic")

-- load our submodules
require "image"
require "root"

local function getItemsPosition()
    
	local imgPosition = {
        cat =	 { 168, 240 },
    }

    return imgPosition
end

-- frames config
local frameCountMax = 3

-- prepare main watchface fuction
local function entry()

    local root = createRoot()
	
	local watchface = {}
	
    -- setup watchface elements positions
	local pos = getItemsPosition()
	
    -- create watchface elements

    watchface.cat   = HandImage(root, "cat_01.bin", pos.cat)
    watchface.catIndex = 1

    function watchface:move()
        watchface.cat.widget:set {
			src = string.format("cat_%02d.bin", watchface.catIndex)
		}
		watchface.catIndex = watchface.catIndex + 1;
		if (watchface.catIndex > frameCountMax)
			watchface.catIndex = 0;
    end

    local t
    local function screenONCb()
        if t then return end

        t = topic.subscribe("sensor_accel", 0, function(topic, status, value)
            if status ~= 0 or not value or #value == 0 then
                return
            end

            watchface:move()
        end)
        
        t:frequency(50) -- set update interval 50msec
    end

    local function screenOFFCb()
        if t then
            t:unsubscribe()
            t = nil
        end
    end

    screenONCb()

    return screenONCb, screenOFFCb
end

-- execute watchface function
local on, off = entry()

-- subscribe on screen state
-- turn off subscription when screen is off
-- to low down load on MCU and save a battery
function ScreenStateChangedCB(pre, now, reason)
    if pre ~="ON" and now == "ON" then
        on()
    elseif pre == "ON" and now ~= "ON" then
        off()
    end
end
