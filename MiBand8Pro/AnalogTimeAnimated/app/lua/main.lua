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

local function HandImageAnim(root, src, pos)
    --- @class Image
    local t = {} -- create new table

    t.widget = root:Image { src = src }

    local w, h = t.widget:get_img_size()
    t.w = w
    t.h = h
    -- current state, center
    t.pos = {
        x = pos[1] - (w // 2),
        y = pos[2] - (h // 2)
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
	
    local anim = t.widget:Anim {
        run = false,
        start_value = 0,
        end_value = 60,
        duration = 1000,
        repeat_count = 1,
        path = "linear",
        exec_cb = function(obj, value)
            obj:set { angle = value }
        end
    }
	t.rotateAnim = anim;

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
        background = { 0, 72 },
        timeHour =	 { 168, 240 },
        timeMinute = { 168, 240 },
        timeSecond = { 168, 240 },
    }

    return imgInitialPosition
end

local animIndex = 1
local animPath = {
	"linear", "ease_in", "ease_out", "ease_in_out", "overshoot", "bounce", "step"
}

local function entry()
    local root = createRoot()
	
	local watchface = {}
	
	local pos = calculateDefaultPosition();
	
    watchface.background = Image(root, imgPath("img_0001.bin"), pos.background)
    watchface.timeHour =   HandImageAnim(root, imgPath("arrHour.bin"), pos.timeHour)
    watchface.timeMinute = HandImageAnim(root, imgPath("arrMinute.bin"), pos.timeMinute)
    watchface.timeSecond = HandImageAnim(root, imgPath("arrSecond.bin"), pos.timeSecond)
	
	local labelMode = lvgl.Label(root, {
		x = 20, y = 20,
		h = 60,
		text_font = lvgl.BUILTIN_FONT.MONTSERRAT_14,
		text = "1",
		bg_color = 0,
		border_width = 0,
		text_color = '#eeeeee'
	})
	
	
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
		local secEnd = secPos + 60
		
		watchface.timeSecond.rotateAnim:set {
			start_value = secPos,
			end_value = secEnd,
			run = true,
		}
		
    end)
	
	animIndex = 1
	
    watchface.background.widget:add_flag(lvgl.FLAG.CLICKABLE)
    watchface.background.widget:onevent(lvgl.EVENT.PRESSED, function(obj, code)

		animIndex = animIndex + 1
		
		if animIndex == #animPath then
			animIndex = 1
		end		
	
		watchface.timeSecond.rotateAnim:set {
			path = animPath[animIndex]
		}
				
		labelMode:set { text = animIndex }
				
	end)
	

end

entry()
