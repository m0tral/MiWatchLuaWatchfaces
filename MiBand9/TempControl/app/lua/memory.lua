local memory = {
    tempFile = "/data/tmp_mem_".. os.date("%Y%m%d_%H%M%S")
}

local function reverse_uint32_bytes(n)
    local b1 = (n >> 24) & 0xFF
    local b2 = (n >> 16) & 0xFF
    local b3 = (n >> 8) & 0xFF
    local b4 = n & 0xFF

    return (b4 << 24) | (b3 << 16) | (b2 << 8) | b1
end

-- 0x40000000 = 0x3c001234
function memory:readAddr(addr, byteEndianIsLittle)

    byteEndianIsLittle = byteEndianIsLittle or false

    local hexAddr = string.format("%x", addr)
    os.execute("mw 0x" .. hexAddr .. " > ".. self.tempFile)

    for line in io.lines(self.tempFile) do
        local value = string.match(line, "= 0x(%w+)")
        if value then
            dwordValue = tonumber(value, 16)
            if byteEndianIsLittle then
                dwordValue = reverse_uint32_bytes(dwordValue)
            end

            return dwordValue, "OK"
        end
    end

    return 0, "ERR_FAIL"
end

function memory:readBytes(addr)
    local hexAddr = string.format("%x", addr)
    os.execute("mw 0x" .. hexAddr .. " > " .. self.tempFile)

    for line in io.lines(self.tempFile) do
        local value = string.match(line, "= 0x(%w+)")
        if value then
            -- Convert the 4-byte integer to a number
            local intValue = tonumber(value, 16)

            -- Split the 4-byte integer into individual bytes (little-endian order)
            local byteArray = {}
            for i = 0, 3 do
                local byte = (intValue >> (i * 8)) & 0xFF
                table.insert(byteArray, byte)  -- Insert at the end for little-endian order
            end

            return byteArray, "OK"
        end
    end

    return {}, "ERR_FAIL"
end

function memory:readUtf8String(addr)
    local str = ""
    local i = 0
    while true do
        -- Read 4 bytes (1 integer) at the current address
        local bytes, status = self:readBytes(addr + i)
        if status ~= "OK" then
            return "", status
        end

        -- Process each byte in the 4-byte array
        for _, byte in ipairs(bytes) do
            if byte == 0 then  -- Stop at the null terminator
                return str, "OK"
            end
            str = str .. string.char(byte)  -- Append the byte as a character
        end

        i = i + 4  -- Move to the next 4-byte chunk
    end
end

function memory:writeAddr(addr, value)
    local hexAddr = string.format("%X", addr)
    local hexVal = string.format("%X", value)
    os.execute("mw 0x" .. hexAddr .. "=" .. hexVal)
end

return memory