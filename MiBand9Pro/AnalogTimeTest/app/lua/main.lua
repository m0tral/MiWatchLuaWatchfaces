local lvgl = require("lvgl")
local dataman = require("dataman")

local fsRoot = SCRIPT_PATH
local DEBUG_ENABLE = false

local selfFlag = false

local printf = DEBUG_ENABLE and print or function(...)
    end

local function imgPath(src)
    return fsRoot .. src
end

local rootbase = lvgl.Object(nil, {
        w = lvgl.HOR_RES(),
        h = lvgl.VER_RES(),
        bg_color = 0,
        bg_opa = lvgl.OPA(100),
        border_width = 0,
    })

rootbase:clear_flag(lvgl.FLAG.SCROLLABLE)
rootbase:add_flag(lvgl.FLAG.EVENT_BUBBLE)

local root = lvgl.Object(rootbase, {
        outline_width = 0,
        border_width = 0,
        pad_all = 0,
        bg_opa = 0,
        bg_color = 0,
        align = lvgl.ALIGN.CENTER,
        w = 336,
        h = 480
    })

root:clear_flag(lvgl.FLAG.SCROLLABLE)
root:add_flag(lvgl.FLAG.EVENT_BUBBLE)

local test = miwear_apps_available
local widgets = debug.getregistry()["widgets"].__index

local secondHand = widgets.AnalogTime(root, {
	x = 0, y = 0,
	w = lvgl.HOR_RES(),
	h = lvgl.VER_RES(),
	--pad_left = 60,
	offset_x = 200, offset_y = 200,											  -- I don't know how this shit works, there is a problems with it..
	--border_width = 1, border_color = 0xee0000,
	hands = {
		hour = imgPath("arrHour.png"),
		minute = imgPath("arrMinute.png"),
		second = imgPath("arrSecond.png"),
		},
	pivot = { hour = { 10, 148}, minute = { 10, 148}, second = { 18, 233}},		-- rotation centers of hands
	period = 100,
	})
	
secondHand:clear_flag(lvgl.FLAG.SCROLLABLE)
secondHand:add_flag(lvgl.FLAG.EVENT_BUBBLE)


