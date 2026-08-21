local lvgl = require("lvgl")
local compass = require("compass")
local gps = require("gps")

local fsRoot = SCRIPT_PATH

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

local function pngSize(path)
    local f = io.open(path, "rb")
    if not f then return nil, nil end
    f:seek("set", 16)
    local bytes = f:read(8)
    f:close()
    if not bytes or #bytes < 8 then return nil, nil end
    local b1, b2, b3, b4, b5, b6, b7, b8 = bytes:byte(1, 8)
    return (b1 << 24) | (b2 << 16) | (b3 << 8) | b4,
           (b5 << 24) | (b6 << 16) | (b7 << 8) | b8
end

local imgW, imgH = pngSize(imgPath("compass_200.png"))
local halfW, halfH = imgW / 2, imgH / 2

local compassHand = widgets.Pointer(root, {
	x = lvgl.HOR_RES() / 2 - halfW,
	y = lvgl.VER_RES() / 2 - halfH,
	pivot = { x = halfW, y = halfH },
	value = 0,
	src = imgPath("compass_200.png")
	})

compassHand:set {
    range = {
	    angleStart = 0, angleRange = 3600,
	    valueStart = 0, valueRange = 360
    }
}

local sensor = compass.open()
local gpsSensor = gps.open()

local gpsLabel = lvgl.Label(root, {
    x = 4,
    y = 4,
    width = lvgl.HOR_RES() - 8,
    text = "GPS: --",
    text_color = '#eeeeee',
    text_font = lvgl.Font("MiSans-Regular", 22),
    text_align = lvgl.ALIGN.TOP_MID,
})

local COMPASS_OFFSET = 0

local function isLocked(lat, lon)
    if lat ~= lat or lon ~= lon then return false end
    if lat == 0 and lon == 0 then return false end
    return math.abs(lat) <= 90 and math.abs(lon) <= 180
end

local timer = lvgl.Timer {
    period = 200,
    cb = function(t)
        compass.poll(sensor, function(ts, x, y, z)
            local heading = (y or 0) // 1
            local angle = -heading
            if angle < 0 then
                angle = angle + 360
            end
            compassHand:set { value = angle }
        end)
        gps.poll(gpsSensor, function(ts, lat, lon, alt)
            if isLocked(lat, lon) then
                gpsLabel:set { text = string.format("GPS: %.4f, %.4f", lat, lon) }
            else
                gpsLabel:set { text = "GPS: --" }
            end
        end)
    end
}

pageOnPause = function()
    timer:pause()
end

pageOnResume = function()
    timer:resume()
end