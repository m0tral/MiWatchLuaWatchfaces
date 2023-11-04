local lvgl = require("lvgl")
local dataman = require("dataman")

-- load our submodules
require "image"
require "root"

local function getItemsPosition()
    
	local imgPosition = {
        background = { 0, 72 },
        timeHour =	 { 168, 240 },
        timeMinute = { 168, 240 },
        timeSecond = { 168, 240 },
    }

    return imgPosition
end

-- prepare main watchface fuction
local function entry()

    local root = createRoot()
	
	local watchface = {}
	
    -- setup watchface elements positions
	local pos = getItemsPosition()
	
    -- create watchface elements
    watchface.background = Image(root, "img_0001.bin", pos.background)
    watchface.timeHour =   HandImage(root, "arrHour.bin", pos.timeHour)
    watchface.timeMinute = HandImage(root, "arrMinute.bin", pos.timeMinute)
    watchface.timeSecond = HandImage(root, "arrSecond.bin", pos.timeSecond)
	
    -- attach events and setup update behaviour
    dataman.subscribe("timeHour", watchface.timeHour.widget, function(obj, value)
		local hour = value // 0x100
		local hourPos = 7200 // 24 * hour
		obj:set { angle = hourPos }
    end)

    dataman.subscribe("timeMinute", watchface.timeMinute.widget, function(obj, value)
		local min = value // 0x100
		local minPos = 3600 // 60 * min
        obj:set { angle = minPos }
    end)

    dataman.subscribe("timeSecond", watchface.timeSecond.widget, function(obj, value)
		local sec = value // 0x100
		local secPos = 3600 // 60 * sec
        obj:set { angle = secPos }
    end)

end

-- execute watchface function
entry()
