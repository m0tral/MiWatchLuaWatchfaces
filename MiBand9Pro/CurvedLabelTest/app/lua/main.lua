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

local label = widgets.CurvedLabel(root, {
	x = 0, y = 0,
	--w = lvgl.HOR_RES(),
	--h = lvgl.VER_RES(),
	--pad_left = 0,
	align = lvgl.ALIGN.CENTER,
	bg_color = 0x333333,
	text_color = 0xffffff,
	--font_size = 50,
	--text_font = lvgl.Font("montserrat", 20, "normal"),
	--text_font = lvgl.Font("MiSans-Demibold", 52),
	--text_font = lvgl.Font("MiSansF-Demibold", 32),
	
	angle_start = 225,
	angle_range = 360,
	radius = 100,
	text = "CURVED LABEL SAMPLE",
	--recolor = 0
	})
	
label:clear_flag(lvgl.FLAG.SCROLLABLE)
label:add_flag(lvgl.FLAG.EVENT_BUBBLE)


