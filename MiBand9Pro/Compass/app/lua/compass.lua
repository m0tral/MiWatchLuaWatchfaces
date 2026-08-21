local uorb = require("uorb")

local M = {}

local PATH = "/dev/uorb/sensor_compass0"
local SIZE = 20

function M.parse(buf)
    local ts_lo = string.unpack("<I4", buf, 1)
    local ts_hi = string.unpack("<I4", buf, 5)
    local x = string.unpack("<f", buf, 9)
    local y = string.unpack("<f", buf, 13)
    local z = string.unpack("<f", buf, 17)
    return ts_hi << 32 | ts_lo, x, y, z
end

function M.open()
    return { fd = uorb.open(PATH), lastRaw = "" }
end

function M.poll(s, cb)
    if not s or not s.fd then return end
    local buf = uorb.read(s.fd, SIZE)
    if buf and buf ~= s.lastRaw then
        s.lastRaw = buf
        local ok, ts, x, y, z = pcall(M.parse, buf)
        if ok and cb then cb(ts, x, y, z) end
    end
end

return M