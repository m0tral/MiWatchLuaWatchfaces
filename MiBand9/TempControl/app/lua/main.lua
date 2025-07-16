local lvgl = require("lvgl")
local temp = require("temperature")
local watchVersion = require("watchVersion")
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
        w = lvgl.HOR_RES(),
        h = lvgl.VER_RES(),
        flex = {
            flex_direction = "row",
            flex_wrap = "wrap",
            justify_content = "center",
            align_items = "center",
            align_content = "center",
        }        
    })

root:clear_flag(lvgl.FLAG.SCROLLABLE)
root:add_flag(lvgl.FLAG.EVENT_BUBBLE)

local function createText(wgt)
    return lvgl.Label(wgt, {
        text_font = lvgl.Font("MiSans-Regular", 60),
        text = "Temp",
        align = lvgl.ALIGN.CENTER,
        border_color = '#eee',
        border_width = 0,
        text_color = '#eee'
        })
end

local time = lvgl.Label(root, {
    text_font = lvgl.Font("MiSans-Regular", 26),
    text = "00:00",
    text_color = '#eee',
    pad_bottom = 5
})

local title = lvgl.Label(root, {
    text_font = lvgl.Font("MiSans-Regular", 30),
    text = "Band Temp",
    text_color = '#eee',
    pad_bottom = 20
})
title:add_flag(lvgl.FLAG.EVENT_BUBBLE)

local txt = createText(root)
txt:add_flag(lvgl.FLAG.EVENT_BUBBLE)

local function setText(str)
    txt:set { text = str }
end

local temp1 = lvgl.Label(root, {
    text_font = lvgl.Font("MiSans-Regular", 26),
    text = "Temperature",
    text_color = '#eee',
    pad_top = 40
})
local temp2 = lvgl.Label(root, {
    text_font = lvgl.Font("MiSans-Regular", 26),
    text = "shutdowns",
    text_color = '#eee'
})
temp1:add_flag(lvgl.FLAG.EVENT_BUBBLE)
temp2:add_flag(lvgl.FLAG.EVENT_BUBBLE)

local installWd = lvgl.Checkbox(root, {
    text_font = lvgl.Font("MiSans-Regular", 26),
    text = "turned off",
    text_color = '#eee',
    pad_top = 10
})

local tempEnabled = temp:isEnabled()

if tempEnabled then
    installWd:add_state(lvgl.STATE.CHECKED)
    installWd:set { text = "turned on"}
end

installWd:add_flag(lvgl.FLAG.CLICKABLE)
installWd:onevent(lvgl.EVENT.CLICKED, function(obj, code)

    if tempEnabled then
        temp:disable()
        installWd:set { text = "turned off"}
        tempEnabled = false
    else
        temp:enable()
        installWd:set { text = "turned on"}
        tempEnabled = true
    end

end)

dataman.subscribe("timeMinuteLow", time, function(obj, value)
    local t = os.time()
    local time_str = os.date("%H:%M", t)
    time:set { text = time_str }
end)

dataman.subscribe("timeSecond", txt, function(obj, value)
    setText(string.format("%.1f", temp:getTempFloat()))
end)
