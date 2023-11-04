local lvgl = require("lvgl")
local topic = require("topic")
local dataman = require("dataman")

-- load our submodules
require "image"
require "root"

local function getItemsPosition()
    
	local imgPosition = {
        cat =	 { 168, 240 },
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
    watchface.cat = HandImage(root, "cat.bin", pos.cat)

	local labelX = lvgl.Label(root, {
		x = 20, y = 20,
		h = 40,
		text_font = lvgl.BUILTIN_FONT.MONTSERRAT_14,
		text = "1",
		bg_color = 0,
		border_width = 0,
		text_color = '#eeeeee'
	})

	local labelY = lvgl.Label(root, {
		x = 20, y = 40,
		h = 40,
		text_font = lvgl.BUILTIN_FONT.MONTSERRAT_14,
		text = "1",
		bg_color = 0,
		border_width = 0,
		text_color = '#eeeeee'
	})

    function watchface:move(acc)
        labelX:set { text = acc.x }
        labelY:set { text = acc.y }
        
        local speed = 4;

        local pX = watchface.cat.pos.x - (acc.x * speed)
        local pY = watchface.cat.pos.y + (acc.y * speed)
        local pW = watchface.cat:getImageWidth()
        local pH = watchface.cat:getImageHeight()

        if pX < 0 then pX = 0 end
        if pY < 0 then pY = 0 end
        if pX > globalWidth - pW then pX = globalWidth - pW end
        if pY > globalHeight - pH then pY = globalHeight - pH end

        --watchface.cat.widget:scroll_by { x = pX, y = pY, anim = true }
        watchface.cat.widget:set { x = pX, y = pY }

        watchface.cat.pos.x = pX
        watchface.cat.pos.y = pY
    end
	
    -- attach events and setup update behaviour
    -- posible values:
    --      sensor_accel
    --      sensor_accel_uncal
    --      sensor_gyro
    --      sensor_gyro_uncal
    --      sensor_mag
    --      sensor_mag_uncal

    topic.subscribe("sensor_accel", 0, function(topic, status, value)
        if status ~= 0 or not value or #value == 0 then
            return
        end

        local acc = value[1]
        watchface:move(acc)
    end):frequency(50) -- set update interval 50msec
end

-- execute watchface function
entry()
