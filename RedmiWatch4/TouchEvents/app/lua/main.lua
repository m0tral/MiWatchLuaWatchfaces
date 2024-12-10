local lvgl = require("lvgl")
local DEBUG_ENABLE = false

require "image"
require "root"

local tmpLogFile = '/data/tmp.log'

if DEBUG_ENABLE then
    tmpLogFile = '/home/tmp.log'
end

local globalWidth = lvgl.HOR_RES()
local globalHeight = lvgl.VER_RES()

local function getItemsPosition()
    
	local imgPosition = {
        cat =	{ (globalWidth - 130) / 2, (globalHeight - 174) / 2},
		txt =  { 160, 400 }
    }

    return imgPosition
end

local function entry()
	
	local root = createRoot()
	
	local pos = getItemsPosition()
	
	local wf = {}
    wf.cat = Image(root, "cat.png", pos.cat)
	
	wf.cat.widget:clear_flag(lvgl.FLAG.SCROLLABLE)
	wf.cat.widget:add_flag(lvgl.FLAG.EVENT_BUBLE)

	wf.txt = root:Label {
		x = 120,
		y = 400,
		text = "touch events",
		text_color = '#eee',
		text_font = lvgl.Font("misansw regular", 32)
	}

	root:onevent(lvgl.EVENT.ALL, function(obj, code)
        local indev = lvgl.indev.get_act()

        if not indev then return end

        if code == lvgl.EVENT.PRESSED then
            local x, y = indev:get_point()
			wf.txt:set { text = string.format("pressed x:%d, y:%d", x, y) }
		end

        if code == lvgl.EVENT.PRESSING then
            local x, y = indev:get_vect()
			wf.txt:set { text = string.format("pressing x:%d, y:%d", x, y) }
        end

        if code == lvgl.EVENT.GESTURE then
            local gesture_dir = indev:get_gesture_dir()
			wf.txt:set { text = string.format("gesture dir:%d", gesture_dir) }
        end

        if code == lvgl.EVENT.RELEASED then
            local scroll_dir = indev:get_scroll_dir()
            --print("scroll_dir: ", scroll_dir)

            local scroll_obj = indev:get_scroll_obj()
            --print("scroll_obj: ", scroll_obj)

            local x, y = indev:get_vect()
			wf.txt:set { text = string.format("release x:%d, y:%d", x, y) }
            --local obj_search = obj:indev_search(x, y)
        end
    end)

	return wf

end

entry()
