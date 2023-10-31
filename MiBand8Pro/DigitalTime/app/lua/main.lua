local lvgl = require("lvgl")
local dataman = require("dataman")

local globalWidth = lvgl.HOR_RES()
local globalHeight = lvgl.VER_RES()

local IMAGE_PATH = SCRIPT_PATH
if not IMAGE_PATH then
    IMAGE_PATH = "/"
    print("Note image root path is set to: ", IMAGE_PATH)
end

print("IMAGE_PATH:", IMAGE_PATH)

function imgPath(src)
    return IMAGE_PATH .. src
end

local function Image(root, src, pos)
    --- @class Image
    local t = {} -- create new table

    t.widget = root:Image { src = src }

    local w, h = t.widget:get_img_size()
    t.w = w
    t.h = h
    -- current state, center
    t.pos = {
        x = pos[1],
        y = pos[2]
    }

    function t:getImageWidth()
        return t.w
    end

    function t:getImageheight()
        return t.h
    end   

    t.defaultY = pos[2]
    t.lastState = STATE_POSITION_MID
    t.state = STATE_POSITION_MID

    t.widget:set {
        w = w,
        h = h,
        x = t.pos.x,
        y = t.pos.y
    }

    return t
end

local function createRoot()
    local property = {
        w = globalWidth,
        h = globalHeight,
        bg_color = 0,
        bg_opa = lvgl.OPA(100),
        border_width = 0,
        pad_all = 0
    }

    scr = lvgl.Object(nil, property)
    scr:clear_flag(lvgl.FLAG.SCROLLABLE)
    return scr
end

local function calculateDefaultPosition()
    
	local imgInitialPosition = {
        timeHourHigh =		{ 25, 200 },
        timeHourLow =		{ 90, 200 },
        timeDelim =		    { 152, 197 },
        timeMinuteHigh =	{ 193, 200 },
        timeMinuteLow =		{ 258, 200 },
    }

    return imgInitialPosition
end

local function entry()
    local root = createRoot()
	
	local watchface = {}
	
	local pos = calculateDefaultPosition();
	
    watchface.timeHourHigh =	Image(root, imgPath("num_0.bin"), pos.timeHourHigh)
    watchface.timeHourLow =		Image(root, imgPath("num_0.bin"), pos.timeHourLow)
    watchface.timeDelim =       Image(root, imgPath("delim.bin"), pos.timeDelim)
    watchface.timeMinuteHigh =	Image(root, imgPath("num_0.bin"), pos.timeMinuteHigh)
    watchface.timeMinuteLow =	Image(root, imgPath("num_0.bin"), pos.timeMinuteLow)
	
    dataman.subscribe("timeHourHigh", watchface.timeHourHigh.widget, function(obj, value)
        src = string.format("num_%d.bin", value // 256)
        obj:set { src = imgPath(src) }
    end)
    dataman.subscribe("timeHourLow", watchface.timeHourLow.widget, function(obj, value)
        src = string.format("num_%d.bin", value // 256)
        obj:set { src = imgPath(src) }
    end)

    dataman.subscribe("timeMinuteHigh", watchface.timeMinuteHigh.widget, function(obj, value)
        src = string.format("num_%d.bin", value // 256)
        obj:set { src = imgPath(src) }
    end)
    dataman.subscribe("timeMinuteLow", watchface.timeMinuteLow.widget, function(obj, value)
        src = string.format("num_%d.bin", value // 256)
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
