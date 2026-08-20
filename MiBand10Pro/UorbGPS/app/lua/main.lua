local lvgl = require("lvgl")

local fsRoot = SCRIPT_PATH
local DEBUG_ENABLE = false
local GPS_LOG_ENABLE = false

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
        h = lvgl.VER_RES()
    })

root:clear_flag(lvgl.FLAG.SCROLLABLE)
root:add_flag(lvgl.FLAG.EVENT_BUBBLE)

local tmpLogFile = '/tmp/tmp.log'

if DEBUG_ENABLE then
    tmpLogFile = '/tmp/tmp.log'
end

local widget = root:Textarea {
    w = lvgl.HOR_RES()- 10,
    h = 400,
    x = 5,
    y = 10,
    text_font = lvgl.Font("MiSans-Regular", 22),
    text = '',
    bg_color = 160,
    font_size = 40,
    text_color = '#eeeeee'
}

local gpsLogPath = '/tmp/gps.log'
local gpsLog
if GPS_LOG_ENABLE then
    gpsLog = io.open(gpsLogPath, 'a')
    if gpsLog then
        gpsLog:write('-- start ', tostring(os.time()), '\n')
        gpsLog:flush()
    end
end

local function toHex(buf)
    local hex = {}
    for i = 1, #buf do
        hex[i] = string.format('%02x', buf:byte(i))
    end
    return table.concat(hex, ' ')
end

local sensors = {
    {
        path = '/dev/uorb/sensor_gps0',
        size = 32,
        parse = function(buf)
            local ts_lo = string.unpack('<I4', buf, 1)
            local ts_hi = string.unpack('<I4', buf, 5)
            local ts = ts_hi << 32 | ts_lo
            local lat = string.unpack('<f', buf, 17)  -- 0x10
            local lon = string.unpack('<f', buf, 21)  -- 0x14
            local alt = string.unpack('<f', buf, 25)  -- 0x18
            return string.format(
                'ts=%d\nlat=%.7f\nlon=%.7f\nalt=%.3f',
                ts, lat, lon, alt)
        end,
        onchange = function(raw)
            if gpsLog then
                gpsLog:write(tostring(os.time()), ' ', toHex(raw), '\n')
                gpsLog:flush()
            end
        end,
    },
    {
        path = '/dev/uorb/sensor_compass0',
        size = 20,
        parse = function(buf)
            local ts_lo = string.unpack('<I4', buf, 1)
            local ts_hi = string.unpack('<I4', buf, 5)
            local ts = ts_hi << 32 | ts_lo
            local x = string.unpack('<f', buf, 9)
            local y = string.unpack('<f', buf, 13)
            local z = string.unpack('<f', buf, 17)
            return string.format('ts=%d\nangle=%.3f', ts, y)
        end,
    },
}

for _, s in ipairs(sensors) do
    s.fd = io.open(s.path, 'rb')
    s.last = s.path .. '\n' .. (s.fd and 'opened...' or 'open failed')
    s.lastRaw = ''
end

widget:set { text = table.concat((function()
    local t = {}
    for _, s in ipairs(sensors) do
        t[#t + 1] = s.last
        t[#t + 1] = ''
    end
    return t
end)(), '\n') }

timer = lvgl.Timer {
    period = 200,
    cb = function(t)
        local lines = {}
        for _, s in ipairs(sensors) do
            lines[#lines + 1] = s.path
            if not s.fd then
                lines[#lines + 1] = 'open failed'
            else
                local data = s.fd:read('*a')
                if data and #data >= s.size then
                    local buf = data:sub(1, s.size)
                    local ok, parsed = pcall(s.parse, buf)
                    if ok and parsed then
                        s.last = s.path .. '\n' .. parsed
                    end
                    if s.onchange and buf ~= s.lastRaw then
                        s.lastRaw = buf
                        s.onchange(buf)
                    end
                end
            end
            lines[#lines + 1] = s.last:sub(#s.path + 2)
            lines[#lines + 1] = ''
        end
        widget:set { text = table.concat(lines, '\n') }
    end
}

pageOnPause = function()
    timer:pause()
end

pageOnResume = function()
    timer:resume()
end

