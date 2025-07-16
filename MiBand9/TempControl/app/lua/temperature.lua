local watchVersion = require("watchVersion")
local memory = require("memory")
local math = require("math")

local temp = {
    g_temp_ptr = 0,
    g_reminder_ptr = 0,
    init_done = false
}

local bodyTempMapping = {
    ["miwear.watch.n66cn"] = {
        ["1.3.206"] = 0x200A15E8
    },
    ["miwear.watch.n66nfc"] = {
        ["1.3.206"] = 0x200A15E8
    },
    ["miwear.watch.n66tc"] = {
        ["1.3.206"] = 0x200A15E8
    },
    ["miwear.watch.n66gl"] = {
        ["2.3.97"] = 0x200A55A0
    },
    ["unknown"] = {
        ["version1"] = 0x20000000,
        ["version2"] = 0x20000000
    }
}

local tempReminder = {
    -- MiBand 9
    ["miwear.watch.n66cn"] = {
        ["1.3.206"] = 0x200A1174
    },
    ["miwear.watch.n66nfc"] = {
        ["1.3.206"] = 0x200A1174
    },
    ["miwear.watch.n66tc"] = {
        ["1.3.206"] = 0x200A1174
    },
    ["miwear.watch.n66gl"] = {
        ["2.3.97"] = 0x200A5150
    },
    ["unknown"] = {
        ["version1"] = 0x20000000,
        ["version2"] = 0x20000000
    }	
}

local function getTempValueByVersion(model, version)
    local modelVersions = bodyTempMapping[model]
    if modelVersions then
        return modelVersions[version]
    end
    return nil
end

local function getReminderValueByVersion(model, version)
    local modelVersions = tempReminder[model]
    if modelVersions then
        return modelVersions[version]
    end
    return nil
end

local function uint32_to_float(u)
    local sign = ((u >> 31) & 0x01)
    local exponent = ((u >> 23) & 0xFF)
    local mantissa = u & 0x7FFFFF

    if exponent == 255 then
        if mantissa == 0 then
            return sign == 1 and -math.huge or math.huge
        else
            return 0/0  -- NaN
        end
    end

    local value
    if exponent == 0 then
        -- denormalized
        value = (mantissa / 2^23) * 2^-126
    else
        -- normalized
        value = (1 + mantissa / 2^23) * 2^(exponent - 127)
    end

    return sign == 1 and -value or value
end

local function init()

    if temp.init_done then
        return
    end

    local model = watchVersion.get_model()
    local ver = watchVersion.get_version()
    
    local addr = getTempValueByVersion(model, ver)
    if addr ~= nil then
        temp.g_temp_ptr = addr
    end

    addr = getReminderValueByVersion(model, ver)
    if addr ~= nil then
        temp.g_reminder_ptr = addr
    end

    temp.init_done = true
end

function temp:readIntByAddress(addr)

    if addr == 0 then
        return
    end

    local maddr, res = memory:readAddr(addr)
    if res == "OK" then
        return maddr
    end

    return 0
end

function temp:getTemp()

    if not self.init_done then
        init()
    end

    return self:readIntByAddress(self.g_temp_ptr)

end

function temp:getTempFloat()

    if not self.init_done then
        init()
    end

    local res = self:readIntByAddress(self.g_temp_ptr)
    if res ~= 0 then
        return uint32_to_float(res)
    end

    return res
end

function temp:isEnabled()

    if not self.init_done then
        init()
    end

    local res = self:readIntByAddress(self.g_reminder_ptr)
    return res == 0
end

function temp:enable()

    if not self.init_done then
        init()
    end

    memory:writeAddr(self.g_reminder_ptr, 0x00000000)
end

function temp:disable()

    if not self.init_done then
        init()
    end

    memory:writeAddr(self.g_reminder_ptr, 0x01010101)
end

return temp