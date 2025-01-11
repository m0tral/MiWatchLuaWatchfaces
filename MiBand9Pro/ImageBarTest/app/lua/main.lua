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

local secondHand = widgets.ImageBar(root, {
	x = 0, y = 0,
	w = lvgl.HOR_RES(),
	h = lvgl.VER_RES(),
	pad_left = 0,
	--offset_x = 200, offset_y = 200,
	--border_width = 1, border_color = 0xee0000,
	src = imgPath("img.png"),
	para = {
		center_x = lvgl.HOR_RES() / 2, center_y = lvgl.VER_RES() / 2,
		radius = 100, width = 115,
		--start_angle = 0, end_angle = 360,
		start_angle = 270, end_angle = 630,
		linecap = 0
		}
	--start_angle = 0, end_angle = 3600,
	--center: {x = lvgl.HOR_RES() / 2, y = lvgl.VER_RES() / 2},
	--bar_width = 50,
	--radius = 100,
	})
	
secondHand:clear_flag(lvgl.FLAG.SCROLLABLE)
secondHand:add_flag(lvgl.FLAG.EVENT_BUBBLE)

secondHand:Anim {
        run = true,     -- create and stop
        start_value = 270, -- start angle
        end_value = 630,  -- end angle
        duration = 1000, -- 1000 msec
        repeat_count = -1,
        path = "linear", -- type of animation
        exec_cb = function(obj, value)
            obj:set { end_angle = value }
        end
    }



