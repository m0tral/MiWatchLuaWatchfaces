local uorb = require("uorb")

local M = {}

local PATH = "/dev/uorb/sensor_gps0"
local SIZE = 32

function M.parse(buf)
    local ts_lo = string.unpack("<I4", buf, 1)
    local ts_hi = string.unpack("<I4", buf, 5)
    local lat = string.unpack("<f", buf, 17)
    local lon = string.unpack("<f", buf, 21)
    local alt = string.unpack("<f", buf, 25)
    return ts_hi << 32 | ts_lo, lat, lon, alt
end

function M.open()
    return { fd = uorb.open(PATH), lastRaw = "" }
end

function M.poll(s, cb)
    if not s or not s.fd then return end
    local buf = uorb.read(s.fd, SIZE)
    if buf and buf ~= s.lastRaw then
        s.lastRaw = buf
        local ok, ts, lat, lon, alt = pcall(M.parse, buf)
        if ok and cb then cb(ts, lat, lon, alt) end
    end
end

return M