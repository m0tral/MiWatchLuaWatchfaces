local lvgl = require("lvgl")
local dataman = require("dataman")

require "image"
require "root"

local function getItemsPosition()
    
	local imgPosition = {
        timeHourHigh =		{ 25, 200 },
        timeHourLow =		{ 90, 200 },
        timeDelim =		    { 152, 197 },
        timeMinuteHigh =	{ 193, 200 },
        timeMinuteLow =		{ 258, 200 },
    }

    return imgPosition
end

local function entry()

    local root = createRoot()
	
	local watchface = {}
	
	local pos = getItemsPosition();
	
    watchface.timeHourHigh =	Image(root, imgPath("num_0.bin"), pos.timeHourHigh)
    watchface.timeHourLow =		Image(root, imgPath("num_0.bin"), pos.timeHourLow)
    watchface.timeDelim =       Image(root, imgPath("delim.bin"), pos.timeDelim)
    watchface.timeMinuteHigh =	Image(root, imgPath("num_0.bin"), pos.timeMinuteHigh)
    watchface.timeMinuteLow =	Image(root, imgPath("num_0.bin"), pos.timeMinuteLow)
	
    dataman.subscribe("timeHourHigh", watchface.timeHourHigh.widget, function(obj, value)
        local src = string.format("num_%d.bin", value // 256)
        obj:set { src = imgPath(src) }
    end)
    dataman.subscribe("timeHourLow", watchface.timeHourLow.widget, function(obj, value)
        local src = string.format("num_%d.bin", value // 256)
        obj:set { src = imgPath(src) }
    end)

    dataman.subscribe("timeMinuteHigh", watchface.timeMinuteHigh.widget, function(obj, value)
        local src = string.format("num_%d.bin", value // 256)
        obj:set { src = imgPath(src) }
    end)
    dataman.subscribe("timeMinuteLow", watchface.timeMinuteLow.widget, function(obj, value)
        local src = string.format("num_%d.bin", value // 256)
        obj:set { src = imgPath(src) }
    end)	

    -- handle demiliter blinking
    dataman.subscribe("timeSecondLow", watchface.timeDelim.widget, function(obj, value)
        local second = value // 256;
        second = second & 0x01; -- take a low bit of second, odd/even
        if second == 0 then
            obj:clear_flag(lvgl.FLAG.HIDDEN)
        else
            obj:add_flag(lvgl.FLAG.HIDDEN)
        end
    end)	

end

entry()
