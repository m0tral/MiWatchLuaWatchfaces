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

local animIndex = 1
local animPath = {
	"linear", "ease_in", "ease_out", "ease_in_out", "overshoot", "bounce", "step"
}

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
    watchface.timeSecond = HandImageAnim(root, "arrSecond.bin", pos.timeSecond)
	
    -- create label to display current animation mode
	local labelMode = lvgl.Label(root, {
		x = 20, y = 20,
		h = 60,
		text_font = lvgl.BUILTIN_FONT.MONTSERRAT_14,
		text = "1",
		bg_color = 0,
		border_width = 0,
		text_color = '#eeeeee'
	})
	
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
		local secEnd = secPos + 60
		
		watchface.timeSecond.rotateAnim:set {
			start_value = secPos,
			end_value = secEnd,
            path = animPath[animIndex],
			run = true,
		}
		
    end)
	
	animIndex = 1
	
    -- attach on pressed event
    -- changing on animation mode
    watchface.background.widget:add_flag(lvgl.FLAG.CLICKABLE)
    watchface.background.widget:onevent(lvgl.EVENT.PRESSED, function(obj, code)

		animIndex = animIndex + 1
		
		if animIndex == #animPath then
			animIndex = 1
		end
		
		labelMode:set { text = animIndex }
				
	end)

end

entry()
