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

local tmpLogFile = '/data/tmp.log'

if DEBUG_ENABLE then
    tmpLogFile = '/home/tmp.log'
end

local test = miwear_apps_available
local widgets = debug.getregistry()["widgets"]

local secondHand = widgets.__index.Pointer(root, {
	x = lvgl.HOR_RES() / 2 - 15,
	y = lvgl.VER_RES() / 2 - 85,
	--border_width = 1, border_color = 0xee0000,
	pivot = { x = 15, y = 85 },
	angleStart = 0, angleRange = 3600,
	valueStart = 0, valueRange = 100,
	value = 0,
	src = imgPath("img.png")
	})


dataman.subscribe("timeSecond", secondHand, function(obj, value)
	local secPos = value * 100 / 0x3c00
	
	secondHand:set { value = secPos }
end)

